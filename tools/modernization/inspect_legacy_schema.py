"""Compile a private read-only JDBC inspector; one attempt, verified TLS, no row data."""
import hashlib
import json
import os
import subprocess
import urllib.request
import argparse
import sys
import getpass
import warnings
from datetime import datetime, timezone
from pathlib import Path

ROOT=Path(__file__).resolve().parents[2]
LOCAL=ROOT/'.modernization/legacy-schema'


def download(url,path):
    with urllib.request.urlopen(url,timeout=30) as response, path.open('wb') as file:
        while chunk:=response.read(1024*1024):file.write(chunk)


def main():
    parser=argparse.ArgumentParser()
    modes=parser.add_mutually_exclusive_group()
    modes.add_argument('--credentials-stdin',action='store_true',help='Read one JSON line from a private stdin pipe; never use a shell argument or file for credentials')
    modes.add_argument('--credentials-prompt',action='store_true',help='Read hidden credentials from an interactive terminal; never echo or persist values')
    args=parser.parse_args()
    credentials=None
    if args.credentials_prompt:
        if not sys.stdin.isatty(): raise SystemExit('A private interactive terminal is required; refusing to echo credentials')
        warnings.simplefilter('error',getpass.GetPassWarning)
        credentials={'username':getpass.getpass('Username (hidden): '),'password':getpass.getpass('Password (hidden): ')}
        args.credentials_stdin=True
    elif args.credentials_stdin:
        print('Waiting for private credential input; values will not be printed or saved.',flush=True)
        try:
            credentials=json.loads(sys.stdin.readline(4097))
            if not isinstance(credentials,dict) or set(credentials)!={'username','password'} or not all(isinstance(v,str) and 0<len(v)<=1024 for v in credentials.values()): raise ValueError()
        except Exception: raise SystemExit('Invalid private credential input; no connection attempted')
    LOCAL.mkdir(parents=True,exist_ok=True)
    java=next((ROOT/'.modernization/jdk8').glob('*/bin/java.exe'))
    yaml=next((ROOT/'.modernization/gradle-cache/caches/modules-2/files-2.1/org.yaml/snakeyaml').rglob('snakeyaml-*.jar'))
    base='https://repo.maven.apache.org/maven2/org/mariadb/jdbc/mariadb-java-client/'
    version='3.5.10'  # Reviewed stable artifact. Do not silently upgrade a credential-bearing inspector.
    name='mariadb-java-client-'+version+'.jar'
    jar=LOCAL/name
    if not jar.exists():download(base+version+'/'+name,jar)
    content=jar.read_bytes()
    if hashlib.sha256(content).hexdigest()!='919b8c1c771d9ee3465811462f242c9543ab401e140c64988ddbf1d8abcb18b2':raise SystemExit('Reviewed official Maven artifact integrity mismatch')
    certificate=LOCAL/'rds-global-bundle.pem'
    if not certificate.exists():download('https://truststore.pki.rds.amazonaws.com/global/global-bundle.pem',certificate)
    classpath=os.pathsep.join([str(LOCAL),str(jar),str(yaml)])
    compiled=subprocess.run([str(java.with_name('javac.exe')),'-encoding','UTF-8','-cp',classpath,'-d',str(LOCAL),str(ROOT/'tools/modernization/LegacySchemaAudit.java')],capture_output=True)
    if compiled.returncode:raise SystemExit('Inspector compile failed; no DB connection attempted')
    result=LOCAL/('master-metadata.json' if args.credentials_stdin else 'metadata.json')
    try:
        command=[str(java),'-cp',classpath,'LegacySchemaAudit',str(ROOT/'src/main/resources/application.yml'),str(certificate),str(result)]
        if args.credentials_stdin: command.append('stdin-credentials')
        process=subprocess.run(command,input=(json.dumps(credentials)+'\n').encode('utf-8') if credentials is not None else None,capture_output=True,timeout=45)
        credentials=None
        if process.returncode or not result.exists():raise RuntimeError('Inspector failed')
        report=json.loads(result.read_text(encoding='utf-8'))
        summary={k:report[k] for k in ['status','readOnly','scope','phase','sqlState','vendorCode','errorClass','credentialSource','targetEvidence','rdsHostname','tlsMode'] if k in report}
        if report.get('status')=='verified':
            summary['tables']=[t['TABLE_NAME'] for t in report['tables']]
            summary['metadataSha256']=hashlib.sha256(result.read_bytes()).hexdigest()
    except subprocess.TimeoutExpired:summary={'status':'timed_out','readOnly':True}
    summary.update(checkedAt=datetime.now(timezone.utc).isoformat(),driverVersion=version,driverSha256=hashlib.sha256(content).hexdigest(),credentialOutput=False,rowDataExported=False)
    (ROOT/'docs/modernization'/('legacy-schema-access-master.json' if args.credentials_stdin else 'legacy-schema-access.json')).write_text(json.dumps(summary,indent=2)+'\n',encoding='utf-8')
    print(json.dumps(summary,indent=2))


if __name__=='__main__':main()
