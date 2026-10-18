"""Stream a fixed read-only audit over SSH; no remote files, credential copies or auth retries."""
import argparse
import hashlib
import json
import os
import shutil
import subprocess
import uuid
import csv
from datetime import datetime,timezone
from pathlib import Path

ROOT=Path(__file__).resolve().parents[2]
HOST='ec2-52-35-43-187.us-west-2.compute.amazonaws.com'


def main():
    parser=argparse.ArgumentParser()
    parser.add_argument('--key',type=Path,required=True,help='Existing owner-provided PEM; never copied')
    parser.add_argument('--phase',choices=['runtime','schema','aggregates','export'],default='runtime')
    parser.add_argument('--export-mode',choices=['original','anonymized-authors'],help='Explicit owner-approved row export mode; does not replace obtaining actual owner authorization')
    parser.add_argument('--summary',action='store_true',help='Print bounded runtime summary; keep full nonsecret evidence in docs')
    parser.add_argument('--evidence-prefix',choices=['','precutover-','postcutover-'],default='',help='Preserve earlier snapshot evidence during cutover')
    args=parser.parse_args()
    if args.phase=='export' and not args.export_mode:parser.error('Row export needs explicit owner authorization and its corresponding --export-mode')
    if not args.key.is_file():raise SystemExit('Existing SSH key not found')
    private=ROOT/'.modernization/ssh';private.mkdir(parents=True,exist_ok=True)
    known=private/'known_hosts'
    if not known.is_file():raise SystemExit('Pinned SSH known_hosts required before inspecting runtime')
    command=[shutil.which('ssh'),'-T','-i',str(args.key),'-o','BatchMode=yes','-o','IdentitiesOnly=yes','-o','ConnectTimeout=8','-o','ConnectionAttempts=1','-o','StrictHostKeyChecking=yes','-o','UserKnownHostsFile="'+str(known).replace('\\','/')+'"','ec2-user@'+HOST,'if command -v python3 >/dev/null 2>&1; then exec python3 -; else exec python -; fi']
    script=(ROOT/'tools/modernization/remote_ec2_runtime.py').read_bytes()
    if args.phase in ['schema','aggregates','export']:script=script.replace(b"if __name__=='__main__':main()",b'')+b'\n'+(ROOT/'tools/modernization/remote_ec2_schema.py').read_bytes()
    if args.phase=='aggregates':script=script.replace(b'from __future__ import print_function',b"from __future__ import print_function\nAUDIT_MODE='aggregates'",1)
    if args.phase=='export':
        script=script.replace(b"if __name__=='__main__':main()",b'')+b'\n'+(ROOT/'tools/modernization/remote_ec2_export.py').read_bytes()
        script=script.replace(b'EXPORT_MODE=None',('EXPORT_MODE='+repr(args.export_mode)).encode('ascii'),1)
        compile(script,'remote_export','exec')
        destination=ROOT/'.modernization/exports'/('source-'+uuid.uuid4().hex[:10])
        destination.mkdir(parents=True)
        if not destination.resolve().is_relative_to((ROOT/'.modernization').resolve()):raise SystemExit('Unsafe export path')
        if os.name=='nt':
            identity=subprocess.check_output(['whoami','/user','/fo','csv','/nh'],creationflags=subprocess.CREATE_NO_WINDOW).decode('utf-8',errors='replace')
            sid=next(csv.reader(identity.strip().splitlines()))[-1]
            if not sid.startswith('S-1-'):raise SystemExit('Cannot protect private export storage')
            subprocess.run(['icacls',str(destination),'/inheritance:r','/grant:r','*'+sid+':(OI)(CI)F'],check=True,capture_output=True,creationflags=subprocess.CREATE_NO_WINDOW)
        else:destination.chmod(0o700)
        partial=destination/'snapshot.ndjson.partial'
        try:
            with partial.open('wb') as output:
                result=subprocess.run(command,input=script,stdout=output,stderr=subprocess.PIPE,timeout=120,creationflags=subprocess.CREATE_NO_WINDOW if os.name=='nt' else 0,cwd=ROOT)
            if result.returncode:raise RuntimeError('Snapshot transport unavailable')
            if not 0<partial.stat().st_size<=100000000:raise RuntimeError('Snapshot byte bound exceeded')
            tables={};expected={};start=None;end=None
            with partial.open(encoding='utf-8') as stream:
                for line in stream:
                    record=json.loads(line)
                    if record['kind']=='snapshot_start':start=record
                    elif record['kind']=='snapshot_end':end=record
                    elif record['kind']=='table_start':expected[record['table']]=record['expectedRows'];tables[record['table']]=[]
                    elif record['kind']=='row':tables[record['table']].append(record['payload'])
                    else:raise RuntimeError('Unexpected snapshot record')
            if not start or start.get('readOnly')!=1 or not end or end.get('status')!='complete':raise RuntimeError('Incomplete or writable snapshot')
            if any(len(tables[name])!=expected[name] for name in expected) or len(expected)!=6:raise RuntimeError('Snapshot row reconciliation failed')
            completed=destination/'snapshot.ndjson';partial.replace(completed)
            normalized=destination/'normalized.json'
            normalized.write_text(json.dumps(tables,ensure_ascii=False,separators=(',',':'))+'\n',encoding='utf-8')
            summary={'status':'consistent_read_only_snapshot','exportMode':args.export_mode,'authorNamesAnonymized':args.export_mode=='anonymized-authors','sourceInstanceId':'i-046087bdb8dff10f7','sourceEngine':start['serverVersion'],'sourceDatabase':start['database'],'snapshotUtc':start['snapshotUtc'],'completedUtc':end['completedUtc'],'sessionTimezone':start['sessionTimezone'],'sessionReadOnly':True,'tables':expected,'snapshotBytes':completed.stat().st_size,'snapshotSha256':hashlib.sha256(completed.read_bytes()).hexdigest(),'normalizedSha256':hashlib.sha256(normalized.read_bytes()).hexdigest(),'privatePath':str(destination.relative_to(ROOT)).replace('\\','/'),'privateStorage':'owner-only directory ACL; Git ignored','sourceRowsPrinted':False,'credentialsPrinted':False,'sourceMutations':0,'scope':'Development snapshot only; not a final migration or whole-instance backup'}
            (destination/'snapshot-evidence.json').write_text(json.dumps(summary,indent=2)+'\n',encoding='utf-8')
            if args.evidence_prefix:summary['scope']=('Post-cutover' if args.evidence_prefix=='postcutover-' else 'Pre-cutover')+' read-only snapshot; source writers are not frozen. Not a final frozen snapshot or whole-instance backup.'
            (destination/'snapshot-evidence.json').write_text(json.dumps(summary,indent=2)+'\n',encoding='utf-8')
            (ROOT/'docs/modernization'/(args.evidence_prefix+'source-snapshot-evidence.json')).write_text(json.dumps(summary,indent=2)+'\n',encoding='utf-8')
            print(json.dumps(summary,indent=2))
        except Exception as error:raise SystemExit('Snapshot unavailable: '+type(error).__name__+'. Partial private output retained; no final import performed.')
        return
    try:
        compile(script,'remote_audit','exec')
        result=subprocess.run(command,input=script,capture_output=True,timeout=45,creationflags=subprocess.CREATE_NO_WINDOW if os.name=='nt' else 0,cwd=ROOT)
        if result.returncode:raise RuntimeError('SSH audit unavailable')
        if len(result.stdout)>262144:raise RuntimeError('Audit bound exceeded')
        report=json.loads(result.stdout.decode('utf-8'))
    except Exception as error:raise SystemExit('Remote audit unavailable: '+type(error).__name__)
    report['checkedAt']=datetime.now(timezone.utc).isoformat()
    content=(json.dumps(report,indent=2)+'\n').encode('utf-8')
    (private/(args.phase+'.json')).write_bytes(content)
    if args.phase=='runtime':
        (ROOT/'docs/modernization/ec2-runtime-evidence.json').write_bytes(content)
        if args.summary:print(json.dumps({'status':report.get('status'),'identityVerified':report.get('identityVerified'),'instance':report.get('instance'),'java':[{key:app.get(key) for key in ['pid','jarPath','jarSha256','jarMatchesOpenProcessFile','deploymentCheckoutCommit','profileArguments','externalConfiguration']} for app in report.get('java',[])],'mutations':report.get('mutations')},indent=2))
        else:print(content.decode('utf-8'))
    else:
        summary={key:report[key] for key in ['scope','status','instanceId','checkedAt','credentialsPrinted','mutations','configurationDocuments','selectedDatasourceFields','server','tables','missingExpectedTables','readOnlyEnforcement','connection','snapshotContext','aggregates'] if key in report}
        summary['privateMetadataSha256']=hashlib.sha256(content).hexdigest()
        (ROOT/'docs/modernization'/('live-aggregate-evidence.json' if args.phase=='aggregates' else 'live-schema-evidence.json')).write_text(json.dumps(summary,indent=2)+'\n',encoding='utf-8')
        print(json.dumps(summary,indent=2))


if __name__=='__main__':main()
