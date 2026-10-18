"""Read-only Linux runtime inspection, streamed over SSH; Python 2/3 stdlib only.

Never prints private keys, process arguments/environment, config bodies or credentials.
"""
from __future__ import print_function
import binascii
import hashlib
import json
import os
import pwd
import re
import socket
import subprocess
import zipfile
try:
    from urllib.request import Request,build_opener,ProxyHandler
    from urllib.parse import urlsplit
except ImportError:
    from urllib2 import Request,build_opener,ProxyHandler
    from urlparse import urlsplit

EXPECTED='i-046087bdb8dff10f7'


def read(path,limit=65536):
    with open(path,'rb') as source:
        value=source.read(limit+1)
    if len(value)>limit:raise ValueError('Read bound exceeded')
    return value


def text(value):return value.decode('utf-8','replace')


def metadata():
    opener=build_opener(ProxyHandler({}))
    request=Request('http://169.254.169.254/latest/api/token',headers={'X-aws-ec2-metadata-token-ttl-seconds':'60'})
    request.get_method=lambda:'PUT'
    token=text(opener.open(request,timeout=2).read(4096))
    result={}
    for field in ['instance-id','local-ipv4','public-ipv4','placement/region']:
        try:
            response=opener.open(Request('http://169.254.169.254/latest/meta-data/'+field,headers={'X-aws-ec2-metadata-token':token}),timeout=2)
            result[field]=text(response.read(1024)).strip()
            response.close()
        except Exception:result[field]=None
    return result


def address(value):
    host,port=value.split(':')
    packed=binascii.unhexlify(host)
    if len(packed)==4:host=socket.inet_ntop(socket.AF_INET,packed[::-1])
    else:host=socket.inet_ntop(socket.AF_INET6,b''.join(packed[i:i+4][::-1] for i in range(0,16,4)))
    return {'address':host,'port':int(port,16)}


def sockets(pid=None):
    owned=set()
    if pid:
        try:
            for fd in os.listdir('/proc/'+pid+'/fd'):
                try:
                    link=os.readlink('/proc/'+pid+'/fd/'+fd)
                    if link.startswith('socket:['):owned.add(link[8:-1])
                except OSError:pass
        except OSError:return {'status':'permission_unavailable'}
    result=[]
    for table in ['tcp','tcp6']:
        try:
            for line in text(read('/proc/'+(pid+'/net/' if pid else 'net/')+table,262144)).splitlines()[1:]:
                fields=line.split()
                if len(fields)<10:continue
                if pid and fields[9] not in owned:continue
                local=address(fields[1]);remote=address(fields[2])
                if pid and remote['port'] in [3306,3307,5432] and fields[3]=='01':result.append({'peer':remote,'state':'ESTABLISHED'})
                elif not pid and fields[3]=='0A' and local['port'] in [22,80,443,3306,3307,5432,8080,8443]:result.append({'bind':local,'state':'LISTEN'})
        except (IOError,OSError):pass
    return {'status':'read','items':result}


def config_summary(name,raw):
    decoded=text(raw);targets=[]
    for match in re.finditer(r'jdbc:(?:mariadb|mysql|postgresql)://[^\s\"\'<>]+',decoded):
        try:
            parsed=urlsplit(match.group(0)[5:])
            if not parsed.hostname or not re.match(r'^[a-zA-Z0-9.:-]+$',parsed.hostname):continue
            database=parsed.path.lstrip('/')
            targets.append({'host':parsed.hostname,'port':parsed.port or (5432 if parsed.scheme=='postgresql' else 3306),'database':database if re.match(r'^[A-Za-z0-9_-]{1,100}$',database) else '[unresolved]'})
        except ValueError:pass
    return {'entry':name,'sha256':hashlib.sha256(raw).hexdigest(),'datasourceCandidates':targets,'scope':'packaged config candidates; runtime overrides must be checked'}


def java(pid):
    result={'pid':int(pid),'databaseConnections':sockets(pid)}
    try:
        args=[text(item) for item in read('/proc/'+pid+'/cmdline').split(b'\0') if item]
        cwd=os.readlink('/proc/'+pid+'/cwd')
        result['cwd']=cwd
        profiles=[arg.split('=',1)[1] for arg in args if arg.startswith(('--spring.profiles.active=','-Dspring.profiles.active='))]
        result['profileArguments']=[value for value in profiles if re.match(r'^[A-Za-z0-9,_.-]{1,100}$',value)]
        config_locations=[]
        classpath_locations=[]
        result['springArgumentKeys']=[arg.split('=',1)[0] for arg in args if arg.startswith(('-Dspring.','--spring.'))]
        for arg in args:
            if arg.startswith(('--spring.config.location=','-Dspring.config.location=','--spring.config.additional-location=','-Dspring.config.additional-location=')):
                for location in arg.split('=',1)[1].split(','):
                    value=location.replace('optional:','',1)
                    if value.startswith('classpath:'):
                        entry=value[len('classpath:'):].lstrip('/')
                        if re.match(r'^[A-Za-z0-9_/.-]{1,200}$',entry):classpath_locations.append(entry)
                        continue
                    if value.startswith('file:'):value=value[5:]
                    if '://' not in value and value.startswith('/') and '\n' not in value:config_locations.append(value)
        result['externalConfigLocations']=config_locations
        result['classpathConfigLocations']=classpath_locations
        result['datasourceArgumentOverridePresent']=any(arg.startswith(('--spring.datasource.','-Dspring.datasource.')) for arg in args)
        defaults=[os.path.join(cwd,'application'+suffix) for suffix in ['.yml','.yaml','.properties','-prod.yml','-prod.yaml','-prod.properties']]
        configs=[]
        for path in config_locations+defaults:
            if os.path.isfile(path) and path not in [config['entry'] for config in configs]:
                try:
                    config=config_summary(path,read(path,262144));config['scope']='external config candidate; active profile and override precedence must be checked';configs.append(config)
                except (IOError,OSError):pass
        result['externalConfiguration']=configs
        for executable in ['/usr/bin/git','/bin/git']:
            if os.path.isfile(executable):
                git=subprocess.Popen([executable,'-C',cwd,'rev-parse','HEAD'],stdout=subprocess.PIPE,stderr=subprocess.PIPE,env=dict(os.environ,GIT_OPTIONAL_LOCKS='0'))
                gitout,unused=git.communicate()
                commit=text(gitout).strip()
                if git.returncode==0 and re.match(r'^[0-9a-f]{40}$',commit):result['deploymentCheckoutCommit']=commit
                break
        try:
            environment=[text(item) for item in read('/proc/'+pid+'/environ').split(b'\0') if item]
            result['datasourceEnvironmentOverridePresent']=any(item.startswith('SPRING_DATASOURCE_') for item in environment)
            result['springEnvironmentKeys']=[item.split('=',1)[0] for item in environment if item.startswith(('SPRING_','JAVA_TOOL_OPTIONS=','JDK_JAVA_OPTIONS='))]
        except (IOError,OSError):result['environmentRead']='permission_unavailable'
        if '-jar' in args:
            path=args[args.index('-jar')+1]
            path=os.path.realpath(os.path.join(cwd,path))
            result['jarPath']=path;size=os.path.getsize(path);result['jarBytes']=size
            result['jarMatchesOpenProcessFile']=False
            try:
                file_stat=os.stat(path)
                for fd in os.listdir('/proc/'+pid+'/fd'):
                    try:
                        descriptor='/proc/'+pid+'/fd/'+fd
                        target=os.readlink(descriptor)
                        if target==path or target==path+' (deleted)':
                            opened=os.stat(descriptor)
                            if (opened.st_dev,opened.st_ino)==(file_stat.st_dev,file_stat.st_ino):result['jarMatchesOpenProcessFile']=True
                    except OSError:pass
            except OSError:pass
            if size<=100000000:
                digest=hashlib.sha256()
                with open(path,'rb') as source:
                    while True:
                        chunk=source.read(1048576)
                        if not chunk:break
                        digest.update(chunk)
                result['jarSha256']=digest.hexdigest()
                with zipfile.ZipFile(path) as archive:
                    configs=[]
                    resource_hashes={};controller_hashes={}
                    for entry in archive.infolist():
                        if entry.file_size>262144:continue
                        if re.match(r'^(BOOT-INF/classes/)?application(?:-[A-Za-z0-9_-]+)?\.(?:yml|yaml|properties)$',entry.filename) or entry.filename in ['BOOT-INF/classes/'+name for name in classpath_locations]:configs.append(config_summary(entry.filename,archive.read(entry)))
                        if entry.filename.startswith('BOOT-INF/classes/templates/') and entry.filename.endswith('.hbs'):
                            resource_hashes[entry.filename[len('BOOT-INF/classes/'):]]=hashlib.sha256(archive.read(entry).replace(b'\r\n',b'\n')).hexdigest()
                        if entry.filename.startswith('BOOT-INF/classes/com/questionbank/webservice/web/') and entry.filename.endswith('.class'):
                            controller_hashes[entry.filename[len('BOOT-INF/classes/'):]]=hashlib.sha256(archive.read(entry)).hexdigest()
                    result['packagedConfiguration']=configs
                    result['templateHashesNormalizedLF']=resource_hashes
                    result['controllerClassHashes']=controller_hashes
                    application_class='BOOT-INF/classes/com/questionbank/webservice/Application.class'
                    production_config='/home/ec2-user/app/config/real-application.yml'
                    if application_class in archive.namelist() and production_config.encode('ascii') in archive.read(application_class):
                        result['appClassReferencesProductionConfig']=True
                        if os.path.isfile(production_config):
                            config=config_summary(production_config,read(production_config,262144))
                            # Never publish a digest derived from a private credential-bearing config.
                            config.pop('sha256',None)
                            config['scope']='External config referenced by running Application.class; profile matching required'
                            result['externalConfiguration'].append(config)
                    if 'META-INF/MANIFEST.MF' in archive.namelist():
                        result['manifest']={}
                        for line in text(archive.read('META-INF/MANIFEST.MF')).splitlines():
                            if ': ' in line:
                                key,value=line.split(': ',1)
                                if key in ['Implementation-Title','Implementation-Version','Start-Class','Spring-Boot-Version']:result['manifest'][key]=value
    except Exception as error:result['inspectionError']=type(error).__name__
    return result


def main():
    report={'scope':'Read-only runtime metadata; no DB query or config/environment bodies','sshUser':pwd.getpwuid(os.getuid()).pw_name,'hostname':socket.gethostname(),'mutations':0,'credentialsPrinted':False}
    try:report['instance']=metadata()
    except Exception as error:report.update(status='identity_unavailable',errorClass=type(error).__name__);print(json.dumps(report));return
    if report['instance'].get('instance-id')!=EXPECTED:report['status']='instance_mismatch';print(json.dumps(report));return
    report['identityVerified']=True
    try:
        report['osName']=[line.split('=',1)[1].strip('"') for line in text(read('/etc/os-release',8192)).splitlines() if line.startswith('PRETTY_NAME=')][0]
    except Exception:pass
    processes=[];java_processes=[]
    for pid in sorted([item for item in os.listdir('/proc') if item.isdigit()],key=int):
        try:comm=text(read('/proc/'+pid+'/comm',256)).strip()
        except (IOError,OSError):continue
        if comm in ['java','mysqld','mariadbd','mysqld_safe','nginx','dockerd','docker-proxy','postgres']:
            processes.append({'pid':int(pid),'name':comm})
            if comm=='java' and len(java_processes)<5:java_processes.append(java(pid))
    report['processes']=processes;report['java']=java_processes;report['listeners']=sockets()
    report['mysqlClientAvailable']=os.path.isfile('/usr/bin/mysql') or os.path.isfile('/bin/mysql')
    try:
        import yaml
        report['safeYamlAvailable']=hasattr(yaml,'safe_load_all')
    except ImportError:report['safeYamlAvailable']=False
    report['status']='verified_runtime'
    print(json.dumps(report,sort_keys=True))


if __name__=='__main__':main()
