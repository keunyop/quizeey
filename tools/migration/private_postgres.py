"""A new, owner-private, password-authenticated loopback rehearsal cluster."""
import os
from pathlib import Path
import secrets
import shutil
import socket
import subprocess
import uuid
from audit import ROOT


class PrivatePostgres:
    def __init__(self,parent,port=55435):
        self.parent=Path(parent).resolve();self.port=port;self.role='quizeey_content_rehearsal';self.index=0
        self.hidden=subprocess.CREATE_NO_WINDOW if os.name=='nt' else 0
        if not self.parent.is_relative_to((ROOT/'.modernization/exports').resolve()):raise ValueError('Private export parent required')
        if os.name=='nt':
            script=('$a=Get-Acl -LiteralPath $env:QUIZEEY_SOURCE_ACL_PATH; $s=[System.Security.Principal.WindowsIdentity]::GetCurrent().User.Value; '
                    'if(-not $a.AreAccessRulesProtected -or $a.GetOwner([System.Security.Principal.SecurityIdentifier]).Value -ne $s){exit 3}; '
                    'foreach($r in $a.GetAccessRules($true,$true,[System.Security.Principal.SecurityIdentifier])){if($r.IdentityReference.Value -ne $s){exit 4}}')
            result=subprocess.run(['powershell.exe','-NoProfile','-Command',script],capture_output=True,creationflags=self.hidden,env={**os.environ,'QUIZEEY_SOURCE_ACL_PATH':str(self.parent)})
            if result.returncode:raise ValueError('Owner-only parent ACL required')
        elif self.parent.stat().st_mode&0o077:raise ValueError('Owner-only directory required')
        if port!=55435:raise ValueError('Only isolated content rehearsal port permitted')
        with socket.socket() as sock:
            if sock.connect_ex(('127.0.0.1',port))==0:raise ValueError('Occupied port; refusing existing DB')
        self.binary=Path(shutil.which('psql') or '').parent;self.suffix='.exe' if os.name=='nt' else ''
        for name in ['initdb','pg_ctl','psql','pg_dump','pg_restore']:
            if not (self.binary/(name+self.suffix)).is_file():raise ValueError('PostgreSQL tools required')
        self.directory=self.parent/('content-postgres-'+uuid.uuid4().hex[:10]);self.directory.mkdir(mode=0o700)
        self.password=secrets.token_urlsafe(40)
        self.env={key:value for key,value in os.environ.items() if not key.startswith('PG')}
        self.env.update(PGPASSWORD=self.password,PGCLIENTENCODING='UTF8',LC_ALL='C')
        self.common=['-X','-h','127.0.0.1','-p',str(port),'-U',self.role,'-v','ON_ERROR_STOP=1']

    def run(self,tool,*args,input=None,denied=False):
        self.index+=1;out=self.directory/('command-%02d.stdout'%self.index);err=self.directory/('command-%02d.stderr'%self.index)
        with out.open('wb') as stdout,err.open('wb') as stderr:
            result=subprocess.run([str(self.binary/(tool+self.suffix)),*map(str,args)],input=input,encoding='utf-8',stdout=stdout,stderr=stderr,env=self.env,creationflags=self.hidden,timeout=180)
        if (result.returncode==0)==denied:raise RuntimeError('Local rehearsal command failed; inspect private logs')
        if denied and '42501' not in err.read_text(encoding='utf-8',errors='replace'):raise RuntimeError('Expected privilege denial SQLSTATE')
        return out

    def sql(self,db,query=None,file=None,denied=False):
        args=[*self.common,'-v','VERBOSITY=sqlstate','-d',db,'-At']
        if file is not None:args+=['-f',str(file)]
        return self.run('psql',*args,input=query,denied=denied)

    def stop(self):
        if (self.directory/'data/postmaster.pid').exists():self.run('pg_ctl','-D',self.directory/'data','-m','fast','-w','stop')

    def __enter__(self):
        password_file=self.directory/'init-password.tmp';password_file.write_text(self.password,encoding='utf-8')
        try:self.run('initdb','-D',self.directory/'data','--username='+self.role,'--locale=C','--encoding=UTF8','--auth=scram-sha-256','--pwfile='+str(password_file))
        finally:password_file.unlink(missing_ok=True)
        try:self.run('pg_ctl','-D',self.directory/'data','-l',self.directory/'server.log','-o','-h 127.0.0.1 -p '+str(self.port),'-w','start')
        except Exception:self.stop();raise
        return self

    def __exit__(self,*_):self.stop()
