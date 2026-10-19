"""Owner-approved 2026-10-18 production comment import bridge.

Only --read-index/--verify-query/--publish-query emit SQL, for direct forwarding
to the Supabase connector. Never print their output to chat or commit exports.
Data is staged pending; exact hashes and valid archive contexts gate publication.
"""
import argparse
from datetime import datetime, timezone
import hashlib
import json
from pathlib import Path
import sys

from audit import ROOT, canonical
from legacy_explanations import TYPES, KEYS
from restore_comments import prepare as restored_target

sys.stdout.reconfigure(encoding='utf-8')
PROJECT = 'tfkhnrbshvyfmrzxqfmq'
DATASET = '88ed4da320cf3bbd40d65f1aa6de7ba6b81a09f5aa6bbcef1e3860ca58ccb42f'
DIRECTORY = ROOT / '.modernization/exports/source-265c3ca16e/hosted-comments-202610'
OMIT = {'visibility', 'approved_post_count'}


def quote(value):
    return "'" + value.replace("'", "''") + "'"


def scope(table, alias=''):
    return alias + KEYS[table] + ' LIKE ' + quote('mysql:question:%' if table == 'topics' else 'mysql:explanation:%')


def framed_hash(table, rows):
    hashes = []
    for row in sorted(rows, key=lambda value: value[KEYS[table]]):
        parts = []
        for column, kind in TYPES[table].items():
            if column in OMIT:
                continue
            value = row[column]
            if value is None:
                parts.append('N;')
                continue
            if kind == 'timestamptz':
                value = datetime.fromisoformat(value).astimezone(timezone.utc).strftime('%Y-%m-%dT%H:%M:%S.%fZ')
            elif isinstance(value, bool):
                value = 'true' if value else 'false'
            else:
                value = str(value)
            parts.append('V' + str(len(value.encode('utf-8'))) + ':' + value + ';')
        hashes.append(hashlib.sha256(''.join(parts).encode('utf-8')).hexdigest())
    return hashlib.sha256(''.join(hashes).encode('ascii')).hexdigest()


def hash_sql(table):
    parts = []
    for column, kind in TYPES[table].items():
        if column in OMIT:
            continue
        value = '"' + column + '"::text'
        if kind == 'timestamptz':
            value = 'to_char("' + column + '" at time zone \'UTC\',\'YYYY-MM-DD"T"HH24:MI:SS.US"Z"\')'
        parts.append('case when "' + column + '" is null then \'N;\' else \'V\'||octet_length(' + value + ')::text||\':\'||' + value + "||';' end")
    expression = '||'.join(parts)
    return "(SELECT encode(sha256(convert_to(coalesce(string_agg(encode(sha256(convert_to(" + expression + ",'UTF8')),'hex'),'' order by " + KEYS[table] + " collate \"C\"),''),'UTF8')),'hex') FROM public.quizeey_" + table + ' WHERE ' + scope(table) + ')'


def table_query(table):
    return "(SELECT jsonb_build_object('rows',count(*),'approved',count(*) filter(where visibility='approved'),'pending',count(*) filter(where visibility='pending'),'framedSha256'," + hash_sql(table) + ') FROM public.quizeey_' + table + ' WHERE ' + scope(table) + ')'


CONTEXT_ERRORS = "(SELECT count(*) FROM public.quizeey_topics t LEFT JOIN quizeey_content.questions q ON q.question_id::text=t.question_id LEFT JOIN quizeey_content.versions v ON v.version_id=q.version_id WHERE " + scope('topics', 't.') + " AND (q.question_id IS NULL OR v.exam_id::text<>t.exam_id))"
OWNERS = "(SELECT count(*) FROM quizeey_private.post_owners o JOIN public.quizeey_posts p ON p.id=o.post_id WHERE " + scope('posts', 'p.') + ')'
COUNT_ERRORS = "(SELECT count(*) FROM public.quizeey_topics t WHERE " + scope('topics', 't.') + " AND t.visibility='approved' AND t.approved_post_count<>(SELECT count(*) FROM public.quizeey_posts p WHERE p.topic_id=t.id AND p.visibility='approved'))"


def verification_sql():
    return "SELECT jsonb_build_object('topics'," + table_query('topics') + ",'posts'," + table_query('posts') + ",'invalidContexts'," + CONTEXT_ERRORS + ",'importedOwners'," + OWNERS + ",'countMismatch'," + COUNT_ERRORS + ",'exams',(SELECT count(*) FROM quizeey_content.exams),'questions',(SELECT count(*) FROM quizeey_content.questions)) AS verification;"


def prepare():
    target, _, _, source = restored_target()
    if source['sourceSha256'] != DATASET:
        raise ValueError('Wrong approved dataset')
    DIRECTORY.mkdir(exist_ok=True)
    batches = []
    for table, rows in target.items():
        columns = TYPES[table]
        names = ','.join('"' + name + '"' for name in columns)
        definition = ','.join('"' + name + '" ' + kind for name, kind in columns.items())
        for offset in range(0, len(rows), 250):
            group = [dict(row, visibility='pending', **({'approved_post_count': 0} if table == 'topics' else {})) for row in rows[offset:offset + 250]]
            query = "BEGIN; SET LOCAL TIME ZONE 'UTC'; SET LOCAL standard_conforming_strings=on; SET LOCAL statement_timeout='60s'; SET LOCAL lock_timeout='5s';\n"
            query += 'INSERT INTO public.quizeey_' + table + '(' + names + ') SELECT ' + names + ' FROM jsonb_to_recordset(' + quote(canonical(group)) + '::jsonb) AS r(' + definition + ') ON CONFLICT (' + KEYS[table] + ') DO NOTHING;\n'
            query += "SELECT jsonb_build_object('table'," + quote(table) + ",'rows',count(*)) AS batch FROM public.quizeey_" + table + ' WHERE ' + scope(table) + ';\nCOMMIT;'
            filename = 'batch-' + str(len(batches)).zfill(2) + '.sql'
            raw = query.encode('utf-8')
            if len(raw) > 350000:
                raise ValueError('Batch exceeds bound')
            (DIRECTORY / filename).write_bytes(raw)
            batches.append({'file': filename, 'table': table, 'rows': len(group), 'cumulativeRows': offset + len(group), 'sha256': hashlib.sha256(raw).hexdigest()})
    manifest = {'projectId': PROJECT, 'datasetSha256': DATASET, 'ownerApprovalDate': '2026-10-18',
        'tables': {table: {'rows': len(rows), 'framedSha256': framed_hash(table, rows)} for table, rows in target.items()},
        'batches': batches, 'sourceUserTextInPublicReports': False, 'publicationRequiresExactVerification': True}
    existing = DIRECTORY / 'manifest.json'
    if existing.exists() and json.loads(existing.read_text(encoding='utf-8')) != manifest:
        raise ValueError('Existing import manifest changed')
    existing.write_text(json.dumps(manifest, indent=2) + '\n', encoding='utf-8')
    state = DIRECTORY / 'checkpoint.json'
    if not state.exists():
        state.write_text(json.dumps({'completed': [], 'pending': None, 'published': False}) + '\n', encoding='utf-8')
    print(json.dumps(manifest))


def load():
    manifest = json.loads((DIRECTORY / 'manifest.json').read_text(encoding='utf-8'))
    if manifest['projectId'] != PROJECT or manifest['datasetSha256'] != DATASET:
        raise ValueError('Target mismatch')
    return manifest, json.loads((DIRECTORY / 'checkpoint.json').read_text(encoding='utf-8'))


def save(state):
    temporary = DIRECTORY / 'checkpoint.next.json'
    temporary.write_text(json.dumps(state, indent=2) + '\n', encoding='utf-8')
    temporary.replace(DIRECTORY / 'checkpoint.json')


def publication_sql(manifest):
    tests = []
    for table, summary in manifest['tables'].items():
        tests.extend(['(SELECT count(*) FROM public.quizeey_' + table + ' WHERE ' + scope(table) + ')<>' + str(summary['rows']),
                      hash_sql(table) + '<>' + quote(summary['framedSha256']),
                      'EXISTS(SELECT 1 FROM public.quizeey_' + table + ' WHERE ' + scope(table) + " AND visibility NOT IN ('pending','approved'))"])
    tests += [CONTEXT_ERRORS + '<>0', OWNERS + '<>0', 'EXISTS(SELECT 1 FROM public.quizeey_topics WHERE ' + scope('topics') + ' AND locked)']
    query = "BEGIN; SET LOCAL statement_timeout='60s'; SET LOCAL lock_timeout='5s';\nDO $restore$ BEGIN\n"
    for table in ['topics', 'posts']:
        query += 'PERFORM id FROM public.quizeey_' + table + ' WHERE ' + scope(table) + ' ORDER BY id FOR UPDATE;\n'
    query += "IF " + ' OR '.join(tests) + " THEN RAISE EXCEPTION 'Comment restoration integrity gate failed'; END IF;\nEND; $restore$;\n"
    query += "UPDATE public.quizeey_posts SET visibility='approved' WHERE " + scope('posts') + " AND visibility='pending';\n"
    query += "UPDATE public.quizeey_topics t SET visibility='approved',approved_post_count=(SELECT count(*) FROM public.quizeey_posts p WHERE p.topic_id=t.id AND p.visibility='approved') WHERE " + scope('topics', 't.') + ";\n"
    query += verification_sql() + '\nCOMMIT;'
    return query


def main():
    parser = argparse.ArgumentParser()
    group = parser.add_mutually_exclusive_group(required=True)
    group.add_argument('--prepare', action='store_true')
    group.add_argument('--read-index', type=int)
    group.add_argument('--ack-index', type=int)
    group.add_argument('--verify-query', action='store_true')
    group.add_argument('--publish-query', action='store_true')
    group.add_argument('--finalize', action='store_true')
    args = parser.parse_args()
    if args.prepare:
        prepare()
        return
    manifest, state = load()
    if args.read_index is not None:
        index = args.read_index
        if state['pending'] is not None or index != len(state['completed']):
            raise ValueError('Inspect and reconcile an in-flight batch before resuming')
        batch = manifest['batches'][index]
        raw = (DIRECTORY / batch['file']).read_bytes()
        if hashlib.sha256(raw).hexdigest() != batch['sha256']:
            raise ValueError('Batch changed')
        state['pending'] = index
        save(state)
        print(json.dumps({'projectId': PROJECT, 'index': index, 'batch': batch, 'query': raw.decode('utf-8')}, ensure_ascii=False))
    elif args.ack_index is not None:
        if state['pending'] != args.ack_index:
            raise ValueError('Unexpected acknowledgement')
        state['completed'].append(args.ack_index)
        state['pending'] = None
        save(state)
        print(json.dumps({'acknowledged': args.ack_index, 'completed': len(state['completed'])}))
    elif args.verify_query:
        print(json.dumps({'projectId': PROJECT, 'tables': manifest['tables'], 'query': 'BEGIN READ ONLY; ' + verification_sql() + ' COMMIT;'}))
    elif args.publish_query:
        if state['pending'] is not None or len(state['completed']) != len(manifest['batches']):
            raise ValueError('Staging is incomplete')
        print(json.dumps({'projectId': PROJECT, 'tables': manifest['tables'], 'query': publication_sql(manifest)}))
    else:
        if state['pending'] is not None or len(state['completed']) != len(manifest['batches']):
            raise ValueError('Import is incomplete')
        state['published'] = True
        state['verifiedAt'] = datetime.now(timezone.utc).isoformat()
        save(state)
        print(json.dumps({'published': True, 'projectId': PROJECT, 'tables': manifest['tables']}))


if __name__ == '__main__':
    try:
        main()
    except Exception as error:
        raise SystemExit('Hosted comment bridge failed (' + type(error).__name__ + '); private values suppressed.')
