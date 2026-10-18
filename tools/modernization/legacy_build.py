"""Download a verified official portable JDK8 into ignored workspace and compile only.

No application startup, import generator, DB test, or deployment is invoked.
"""
import hashlib
import json
import os
import subprocess
import urllib.request
import zipfile
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
LOCAL = ROOT/'.modernization'


def main():
    api='https://api.adoptium.net/v3/assets/latest/8/hotspot?architecture=x64&image_type=jdk&os=windows&vendor=eclipse'
    request=urllib.request.Request(api,headers={'User-Agent':'Quizeey-local-build-audit'})
    with urllib.request.urlopen(request,timeout=60) as response: asset=json.load(response)[0]
    package=asset['binary']['package']
    destination=LOCAL/'jdk8'
    destination.mkdir(parents=True,exist_ok=True)
    archive=destination/'jdk.zip'
    if not archive.exists() or hashlib.file_digest(archive.open('rb'),'sha256').hexdigest()!=package['checksum']:
        with urllib.request.urlopen(package['link'],timeout=120) as response, archive.open('wb') as file:
            while chunk:=response.read(1024*1024): file.write(chunk)
    with archive.open('rb') as file:
        if hashlib.file_digest(file,'sha256').hexdigest()!=package['checksum']: raise SystemExit('JDK checksum mismatch')
    with zipfile.ZipFile(archive) as file:
        for name in file.namelist():
            if not (destination/name).resolve().is_relative_to(destination.resolve()): raise SystemExit('Unsafe archive path')
        file.extractall(destination)
    java=next(destination.glob('*/bin/java.exe')).parent.parent
    evidence={'provider':'Eclipse Temurin/Adoptium','version':asset['version']['semver'],'archiveSha256':package['checksum'],
              'scope':'compile/package only; no application runtime or DB connection; no Java test sources present'}
    (LOCAL/'legacy-build-runtime.json').write_text(json.dumps(evidence,indent=2)+'\n',encoding='utf-8')
    env={**os.environ,'JAVA_HOME':str(java),'GRADLE_USER_HOME':str(LOCAL/'gradle-cache')}
    print('Verified portable JDK '+evidence['version']+'. Compiling legacy project without application startup.',flush=True)
    result=subprocess.run([str(ROOT/'gradlew.bat'),'build','--no-daemon','--console=plain'],cwd=ROOT,env=env)
    raise SystemExit(result.returncode)


if __name__=='__main__':main()
