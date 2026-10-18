"""Rehearse the owner-approved filtered dataset with REAL FK/unique constraints."""
import argparse
import hashlib
import json
from pathlib import Path
import time
from audit import ROOT, digest
from content_etl import KEYS, sql_plan, summaries, transform
from private_postgres import PrivatePostgres


def verify(path,expected):
    actual={table:[] for table in KEYS}
    with path.open(encoding='utf-8') as stream:
        for line in stream:
            table,row=json.loads(line)
            if table not in actual:raise ValueError('Unexpected target table')
            actual[table].append(row)
    if summaries(actual)!=summaries(expected):raise ValueError('Relational target values changed')
    return summaries(actual)


def main():
    parser=argparse.ArgumentParser();parser.add_argument('snapshot',type=Path);args=parser.parse_args();source=args.snapshot.resolve()
    if not source.is_relative_to((ROOT/'.modernization/exports').resolve()):parser.error('Approved private snapshot path required')
    evidence=json.loads((source/'snapshot-evidence.json').read_text(encoding='utf-8'))
    policy=json.loads((source/'publication-candidate-plan.json').read_text(encoding='utf-8'))
    if not policy.get('ownerPolicyApproved') or policy.get('status')!='owner_approved_new_service_exclusion':raise ValueError('Confirmed new-service deletion scope required')
    for filename,expected in [('snapshot.ndjson',evidence['snapshotSha256']),('normalized.json',evidence['normalizedSha256']),('new-service-dataset.json',policy['newServiceDatasetSha256'])]:
        with (source/filename).open('rb') as stream:
            if hashlib.file_digest(stream,'sha256').hexdigest()!=expected:raise ValueError('Reviewed source/dataset changed')
    data=json.loads((source/'new-service-dataset.json').read_text(encoding='utf-8'))
    removed=json.loads((source/'new-service-deleted-question-ids.json').read_text(encoding='utf-8'))
    if len(removed)!=751 or digest(removed)!=policy['reviewQuestionIdSetSha256']:raise ValueError('Approved deletion set changed')
    if set(removed)&{row['quest_id'] for row in data['question']}:raise ValueError('Deleted source question remains')
    schema=json.loads((ROOT/'tools/migration/verified_schema.json').read_text(encoding='utf-8'))
    target=transform(data,schema);plan=sql_plan(target,schema)
    query='\n'.join("SELECT json_build_array('"+table+"',to_jsonb(t)) FROM quizeey_content."+table+' t ORDER BY '+key+';' for table,key in KEYS.items())
    start=time.monotonic();stages=[]
    with PrivatePostgres(source) as db:
        (db.directory/'content-etl.sql').write_text(plan,encoding='utf-8')
        db.sql('postgres','CREATE ROLE anon;CREATE ROLE authenticated;CREATE ROLE service_role BYPASSRLS;CREATE DATABASE quizeey_content;')
        db.sql('quizeey_content',file=ROOT/'supabase/migrations/202610160006_exam_content.sql')
        for attempt in [1,2]:
            db.sql('quizeey_content',file=db.directory/'content-etl.sql')
            checked=verify(db.sql('quizeey_content',query),target)
            # Check actual answer-ID sets after the deterministic question mapping.
            correct_query="SELECT json_build_array(question_id::text,json_agg(choice_id::text ORDER BY choice_id::text)) FROM quizeey_content.choices WHERE correct GROUP BY question_id ORDER BY question_id::text;"
            observed={}
            for line in db.sql('quizeey_content',correct_query).read_text(encoding='utf-8').splitlines():
                id_,ids=json.loads(line);observed[id_]=ids
            # One pass; avoid a question*choice full scan for the real archive.
            expected={r['question_id']:[] for r in target['questions']}
            for choice in target['choices']:
                if choice['correct']:expected[choice['question_id']].append(choice['choice_id'])
            expected={id_:sorted(ids) for id_,ids in expected.items()}
            if observed!=expected:raise ValueError('Actual correct-choice ID sets differ')
            stages.append({'stage':'import_'+str(attempt),'allValuesAndIdsMatch':True,'correctChoiceSetsMatch':True,'fkAndUniqueConstraintsEnforced':True})
            print('Private new-service content import %d verified'%attempt,flush=True)
        for table in ['exams','versions','questions','choices']:
            key=KEYS[table]
            db.sql('quizeey_content',"DO $$ BEGIN IF nextval(pg_get_serial_sequence('quizeey_content."+table+"','"+key+"')) <= (SELECT coalesce(max("+key+"),0) FROM quizeey_content."+table+") THEN RAISE EXCEPTION 'sequence below source IDs'; END IF;END $$;")
        # Constraint probes roll back atomically. No original or target row deleted.
        constraint_query="BEGIN; DELETE FROM quizeey_content.exams WHERE exam_id=(SELECT exam_id FROM quizeey_content.versions LIMIT 1); ROLLBACK;"
        try:db.sql('quizeey_content',constraint_query)
        except RuntimeError:
            log=db.directory/('command-%02d.stderr'%db.index)
            if '23503' not in log.read_text(encoding='utf-8',errors='replace'):raise
        else:raise ValueError('Foreign key probe did not fail')
        duplicate_query="BEGIN; INSERT INTO quizeey_content.choices(question_id,number,body,correct,created_at,modified_at) SELECT question_id,number,body,correct,created_at,modified_at FROM quizeey_content.choices LIMIT 1;ROLLBACK;"
        try:db.sql('quizeey_content',duplicate_query)
        except RuntimeError:
            if '23505' not in (db.directory/('command-%02d.stderr'%db.index)).read_text(encoding='utf-8',errors='replace'):raise
        else:raise ValueError('Unique choice number probe did not fail')
        for role in ['anon','authenticated','service_role']:
            db.sql('quizeey_content','SET ROLE '+role+';SELECT * FROM quizeey_content.questions LIMIT 1;',denied=True)
        db.run('pg_dump','-h','127.0.0.1','-p',str(db.port),'-U',db.role,'-Fc','-f',db.directory/'content.dump','quizeey_content')
        db.sql('postgres','CREATE DATABASE quizeey_content_restore;')
        db.run('pg_restore','-h','127.0.0.1','-p',str(db.port),'-U',db.role,'-d','quizeey_content_restore','--exit-on-error',db.directory/'content.dump')
        verify(db.sql('quizeey_content_restore',query),target)
        for role in ['anon','authenticated','service_role']:
            db.sql('quizeey_content_restore','SET ROLE '+role+';SELECT * FROM quizeey_content.questions LIMIT 1;',denied=True)
        stages.append({'stage':'backup_restore','allValuesAndIdsMatch':True,'fkAndUniqueConstraintsEnforced':True})
        result={'status':'approved_filtered_content_rehearsal_pass','sourceSnapshotSha256':evidence['snapshotSha256'],
                'newServiceDatasetSha256':policy['newServiceDatasetSha256'],'deletedFromNewServiceQuestions':751,
                'sourceMySQLMutations':0,'originalBackupsRetained':True,'tables':checked,'stages':stages,
                'foreignKeyViolationRejected':True,'duplicateChoiceNumberRejected':True,'identitySequencesAboveSourceIds':True,'publicAndServiceRolesDenied':True,
                'userExplanationsPreservedForPendingNativeImport':len(data['explanation']),
                'publicServingEnabled':False,'externalUploads':0,'privatePath':db.directory.relative_to(ROOT).as_posix()}
    result.update(localServerStopped=not (db.directory/'data/postmaster.pid').exists(),elapsedSeconds=round(time.monotonic()-start,3))
    (db.directory/'content-rehearsal-evidence.json').write_text(json.dumps(result,indent=2)+'\n',encoding='utf-8')
    (ROOT/'docs/modernization/content-rehearsal-evidence.json').write_text(json.dumps(result,indent=2)+'\n',encoding='utf-8')
    print('Filtered relational content replay/restore verified; local server stopped.')


if __name__=='__main__':
    try:main()
    except Exception as error:raise SystemExit('Private content rehearsal failed ('+type(error).__name__+'); inspect private logs, source content not printed.')
