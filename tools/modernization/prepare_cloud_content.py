"""Prepare private SQL batches and content hashes locally. Never uploads or prints content."""
import argparse
from datetime import datetime, timezone
import hashlib
import json
from pathlib import Path
import re
import sys
sys.path.insert(0,str(Path(__file__).resolve().parents[1]/'migration'))
from audit import ROOT, canonical, digest
from content_etl import transform, TYPES, KEYS, SOURCE_TABLES

EXPECTED = {'exams':181,'versions':330,'questions':26733,'choices':107516,'legacy_counters':25870}
DATASET = '88ed4da320cf3bbd40d65f1aa6de7ba6b81a09f5aa6bbcef1e3860ca58ccb42f'
DELETED = '425654b55ad190dce415c853c95908521c6de0ed9e2860101d0ae8ac2730c6fd'


def text_value(value,kind):
    if kind=='timestamptz':
        return datetime.fromisoformat(value).astimezone(timezone.utc).strftime('%Y-%m-%dT%H:%M:%S.%fZ')
    if isinstance(value,bool):return 'true' if value else 'false'
    return str(value)


def frame_hash(table,rows):
    row_hashes=[]
    for row in sorted(rows,key=lambda r:int(r[KEYS[table]])):
        parts=[]
        for column,kind in TYPES[table].items():
            value=row[column]
            if value is None:parts.append('N;')
            else:
                value=text_value(value,kind)
                parts.append('V'+str(len(value.encode('utf-8')))+':'+value+';')
        row_hashes.append(hashlib.sha256(''.join(parts).encode('utf-8')).hexdigest())
    return hashlib.sha256(''.join(row_hashes).encode('ascii')).hexdigest()


def verification_sql(table):
    parts=[]
    for column,kind in TYPES[table].items():
        value='"'+column+'"::text'
        if kind=='timestamptz':value='to_char("'+column+'" at time zone \'UTC\',\'YYYY-MM-DD"T"HH24:MI:SS.US"Z"\')'
        parts.append("case when \""+column+"\" is null then 'N;' else 'V'||octet_length("+value+")::text||':'||"+value+"||';' end")
    framed='||'.join(parts)
    return "select jsonb_build_object('table','"+table+"','rows',count(*),'framedSha256',encode(sha256(convert_to(coalesce(string_agg(encode(sha256(convert_to("+framed+",'UTF8')),'hex'),'' order by \""+KEYS[table]+"\"),''),'UTF8')),'hex')) from quizeey_content."+table+';'


def main():
    parser=argparse.ArgumentParser();parser.add_argument('snapshot',type=Path);args=parser.parse_args()
    source=args.snapshot.resolve()
    if not source.is_relative_to((ROOT/'.modernization/exports').resolve()):raise ValueError('Private source required')
    raw=(source/'new-service-dataset.json').read_bytes()
    if hashlib.sha256(raw).hexdigest()!=DATASET:raise ValueError('Dataset hash changed')
    policy=json.loads((source/'publication-candidate-plan.json').read_text(encoding='utf-8'))
    deleted=json.loads((source/'new-service-deleted-question-ids.json').read_text(encoding='utf-8'))
    if not policy.get('ownerPolicyApproved') or len(deleted)!=751 or digest(deleted)!=DELETED:raise ValueError('Exclusion scope changed')
    data=json.loads(raw)
    if set(deleted)&{r['quest_id'] for r in data['question']}:raise ValueError('Excluded question remains')
    schema=json.loads((ROOT/'tools/migration/verified_schema.json').read_text(encoding='utf-8'))
    target=transform(data,schema)
    if {t:len(r) for t,r in target.items()}!=EXPECTED:raise ValueError('Target row counts changed')
    destination=source/'cloud-preview-content';destination.mkdir(exist_ok=True)
    batches=[];summaries={}
    quote=lambda text:"'"+text.replace("'","''")+"'"
    for table,rows in target.items():
        columns=TYPES[table];names=','.join('"'+c+'"' for c in columns)
        record=','.join('"'+c+'" '+kind for c,kind in columns.items())
        updates=','.join('"'+c+'"=excluded."'+c+'"' for c in columns if c!=KEYS[table])
        offset=0;batch_number=0
        while offset<len(rows):
            size=min(1000,len(rows)-offset)
            while len(canonical(rows[offset:offset+size]).encode('utf-8'))>350000 and size>1:size=max(1,size//2)
            query="BEGIN; SET LOCAL TIME ZONE 'UTC'; SET LOCAL standard_conforming_strings=on; SET LOCAL statement_timeout='60s';\n"
            query+='INSERT INTO quizeey_content.'+table+'('+names+') SELECT '+names+' FROM jsonb_to_recordset('+quote(canonical(rows[offset:offset+size]))+'::jsonb) AS r('+record+') ON CONFLICT ('+KEYS[table]+') DO UPDATE SET '+updates+';\nCOMMIT;'
            batch_number+=1
            name=table+'-'+str(batch_number).zfill(4)+'.sql'
            (destination/name).write_text(query,encoding='utf-8',newline='\n')
            batches.append({'file':name,'table':table,'rows':size,'sha256':hashlib.sha256(query.encode('utf-8')).hexdigest()})
            offset+=size
        if table in SOURCE_TABLES:
            watermark=re.search(r'\bAUTO_INCREMENT=(\d+)\b',schema['ddl'][SOURCE_TABLES[table]])
            if not watermark:raise ValueError('Missing sequence watermark')
            query="BEGIN; SELECT setval(pg_get_serial_sequence('quizeey_content."+table+"','"+KEYS[table]+"'),greatest("+watermark[1]+',coalesce((SELECT max('+KEYS[table]+')+1 FROM quizeey_content.'+table+'),1)),false); COMMIT;'
            name=table+'-sequence.sql';(destination/name).write_text(query,encoding='utf-8',newline='\n')
            batches.append({'file':name,'table':table,'rows':0,'sha256':hashlib.sha256(query.encode('utf-8')).hexdigest()})
        summaries[table]={'rows':len(rows),'framedSha256':frame_hash(table,rows)}
    verification={t:verification_sql(t) for t in target}
    private={'schema':1,'status':'prepared-not-uploaded','projectId':'tfkhnrbshvyfmrzxqfmq','datasetSha256':DATASET,
             'deletedIdSetSha256':DELETED,'batches':batches,'tables':summaries,'verificationSql':verification,
             'nativePostsIncluded':False,'sourceAuthorColumnsIncluded':False}
    (destination/'manifest.json').write_text(json.dumps(private,indent=2)+'\n',encoding='utf-8',newline='\n')
    public={key:value for key,value in private.items() if key not in ['verificationSql']}
    (ROOT/'docs/modernization/cloud-content-preparation-evidence.json').write_text(json.dumps(public,indent=2)+'\n',encoding='utf-8',newline='\n')
    print(json.dumps({'prepared':True,'uploaded':False,'totalRows':sum(EXPECTED.values()),'batches':len(batches),'tables':summaries}))


if __name__=='__main__':
    try:main()
    except Exception as error:raise SystemExit('Private cloud content preparation failed ('+type(error).__name__+'); no source printed.')
