"""Explicit-ID relational ETL of the approved new-service dataset. No DB calls."""
from datetime import datetime, timezone
import re
from audit import audit, canonical, digest
from source_contract import validate_contract

KEYS={'exams':'exam_id','versions':'version_id','questions':'question_id','choices':'choice_id','legacy_counters':'question_id'}
TYPES={
 'exams':{'exam_id':'bigint','name_ko':'text','name_en':'text','legacy_slug':'text','priority':'integer','created_at':'timestamptz','modified_at':'timestamptz'},
 'versions':{'version_id':'bigint','exam_id':'bigint','number':'integer','name':'text','created_at':'timestamptz','modified_at':'timestamptz'},
 'questions':{'question_id':'bigint','version_id':'bigint','number':'integer','body':'text','explanation':'text','reference':'text','multiple_answers':'boolean','created_at':'timestamptz','modified_at':'timestamptz'},
 'choices':{'choice_id':'bigint','question_id':'bigint','number':'integer','body':'text','correct':'boolean','created_at':'timestamptz','modified_at':'timestamptz'},
 'legacy_counters':{'question_id':'bigint','correct':'integer','incorrect':'integer','created_at':'timestamptz','modified_at':'timestamptz'}
}
SOURCE_TABLES={'exams':'test','versions':'version','questions':'question','choices':'example'}


def normalize(table,rows):
    result=[]
    for source in rows:
        if set(source)!=set(TYPES[table]):raise ValueError('Target column set changed')
        row=dict(source)
        for name,kind in TYPES[table].items():
            value=row[name]
            if value is None:continue
            if kind=='bigint':row[name]=str(value)
            elif kind=='timestamptz':
                stamp=datetime.fromisoformat(value)
                if stamp.tzinfo is None:stamp=stamp.replace(tzinfo=timezone.utc)
                row[name]=stamp.astimezone(timezone.utc).isoformat(timespec='microseconds')
        result.append(row)
    return sorted(result,key=lambda r:r[KEYS[table]])


def transform(data,schema):
    if validate_contract(data,schema):raise ValueError('Source type validation failed')
    report,source=audit(data)
    if report['errors']:raise ValueError('Unresolved source relationships cannot enter serving ETL')
    versions={(r['test_id'],r['ver_nbr']):r['ver_id'] for r in source['version']}
    questions={(r['test_id'],r['ver_nbr'],r['quest_nbr']):r['quest_id'] for r in source['question']}
    def times(r):return {'created_at':r['created_date'],'modified_at':r['modified_date']}
    target={
     'exams':[{'exam_id':r['test_id'],'name_ko':r['test_nm'],'name_en':r['test_nm_eng'],'legacy_slug':r['url'],'priority':r['inqr_seq'],**times(r)} for r in source['test']],
     'versions':[{'version_id':r['ver_id'],'exam_id':r['test_id'],'number':r['ver_nbr'],'name':r['ver_nm'],**times(r)} for r in source['version']],
     'questions':[{'question_id':r['quest_id'],'version_id':versions[(r['test_id'],r['ver_nbr'])],'number':r['quest_nbr'],'body':r['quest_txt'],'explanation':r['explanation'],'reference':r['reference'],'multiple_answers':r['multi_answer_yn']=='Y',**times(r)} for r in source['question']],
     'choices':[{'choice_id':r['exmp_id'],'question_id':questions[(r['test_id'],r['ver_nbr'],r['quest_nbr'])],'number':r['exmp_nbr'],'body':r['exmp_txt'],'correct':r['answer_yn']=='Y',**times(r)} for r in source['example']],
     'legacy_counters':[{'question_id':r['quest_id'],'correct':r['correct'],'incorrect':r['in_correct'],**times(r)} for r in source['question_stats']]
    }
    # The verified live source uses exact uppercase flags. Do not quietly change
    # a future snapshot whose auditor accepted case-insensitive historical aliases.
    if any(r['multi_answer_yn'] not in ['Y','N'] for r in source['question']) or any(r['answer_yn'] not in ['Y','N'] for r in source['example']):
        raise ValueError('Unexpected verified source flag encoding')
    return {table:normalize(table,rows) for table,rows in target.items()}


def sql_plan(target,schema):
    quote=lambda value:"'"+value.replace("'","''")+"'"
    lines=['-- PRIVATE NEW-SERVICE ETL; NOT A PRODUCTION EXECUTION REQUEST.','BEGIN;',"SET LOCAL TIME ZONE 'UTC';",'SET LOCAL standard_conforming_strings=on;']
    for table,rows in target.items():
        columns=TYPES[table];names=','.join('"'+n+'"' for n in columns)
        record=','.join('"'+n+'" '+kind for n,kind in columns.items())
        updates=','.join('"'+n+'"=excluded."'+n+'"' for n in columns if n!=KEYS[table])
        for offset in range(0,len(rows),500):
            lines.append('INSERT INTO quizeey_content.'+table+'('+names+') SELECT '+names+' FROM jsonb_to_recordset('+quote(canonical(rows[offset:offset+500]))+'::jsonb) AS r('+record+') ON CONFLICT ('+KEYS[table]+') DO UPDATE SET '+updates+';')
        if table in SOURCE_TABLES:
            match=re.search(r'\bAUTO_INCREMENT=(\d+)\b',schema['ddl'][SOURCE_TABLES[table]])
            if not match:raise ValueError('Source sequence watermark missing')
            lines.append("SELECT setval(pg_get_serial_sequence('quizeey_content."+table+"','"+KEYS[table]+"'),greatest("+match[1]+',coalesce((SELECT max('+KEYS[table]+')+1 FROM quizeey_content.'+table+'),1)),false);')
    lines.append('COMMIT;')
    return '\n'.join(lines)+'\n'


def summaries(target):return {table:{'rows':len(rows),'utcSemanticSha256':digest(normalize(table,rows))} for table,rows in target.items()}
