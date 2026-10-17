"""Read-only identification of the owner-specified legacy host and RDS name.

Explicit existing AWS profile required. Never configures credentials, opens a firewall,
retrieves secrets/user-data, creates a resource or deletes anything. No account connected here yet.
"""
import argparse
import hashlib
import json
import os
import re
import shutil
import subprocess
from datetime import datetime,timezone
from pathlib import Path

ROOT=Path(__file__).resolve().parents[2]
HOST='52.35.43.187'
INSTANCE='i-046087bdb8dff10f7'


def main():
    parser=argparse.ArgumentParser()
    parser.add_argument('--profile',required=True,help='An existing authorized read-only AWS CLI profile')
    parser.add_argument('--region',default='us-west-2')
    parser.add_argument('--instance-id',default=INSTANCE,help='Owner-identified questionbank instance; do not guess other targets')
    args=parser.parse_args()
    if not re.fullmatch(r'[A-Za-z0-9_.@-]{1,100}',args.profile):parser.error('Invalid profile name')
    if not re.fullmatch(r'[a-z]{2}(?:-[a-z]+)+-\d',args.region):parser.error('Invalid region')
    if not re.fullmatch(r'i-(?:[a-f0-9]{8}|[a-f0-9]{17})',args.instance_id):parser.error('Invalid instance ID')
    binary=shutil.which('aws')
    if not binary:raise SystemExit('AWS CLI is unavailable; no cloud requests made')
    hidden=subprocess.CREATE_NO_WINDOW if os.name=='nt' else 0
    def query(service,action,query,*parameters):
        # Structured argv, selected metadata fields only. Never print raw AWS errors.
        command=[binary,'--profile',args.profile,'--region',args.region,'--no-cli-pager','--output','json',service,action,*parameters,'--query',query]
        result=subprocess.run(command,capture_output=True,timeout=25,creationflags=hidden,env={**os.environ,'AWS_MAX_ATTEMPTS':'1','AWS_PAGER':''})
        if result.returncode:
            error=result.stderr.decode('utf-8',errors='replace')
            code=re.search(r'\(([A-Za-z0-9]+)\)',error)
            return {'status':'unavailable','errorCode':code.group(1) if code else 'credential_or_transport_unavailable'}
        return {'status':'ok','data':json.loads(result.stdout)}
    identity=query('sts','get-caller-identity','{Account:Account,Arn:Arn}')
    if identity['status']!='ok':raise SystemExit('Existing AWS profile is unavailable; no EC2/RDS discovery performed')
    ec2=query('ec2','describe-instances','Reservations[].Instances[].{Id:InstanceId,State:State.Name,Type:InstanceType,PublicIp:PublicIpAddress,PrivateIp:PrivateIpAddress,Vpc:VpcId,Subnet:SubnetId,SecurityGroups:SecurityGroups[].GroupId,Volumes:BlockDeviceMappings[].Ebs.VolumeId,LaunchTime:LaunchTime}','--instance-ids',args.instance_id)
    rds=query('rds','describe-db-instances','DBInstances[].{Id:DBInstanceIdentifier,Engine:Engine,Version:EngineVersion,Class:DBInstanceClass,Status:DBInstanceStatus,Endpoint:Endpoint.Address,Port:Endpoint.Port,PubliclyAccessible:PubliclyAccessible,MultiAZ:MultiAZ,BackupDays:BackupRetentionPeriod,AllocatedGiB:AllocatedStorage,Vpc:DBSubnetGroup.VpcId,SecurityGroups:VpcSecurityGroups[].VpcSecurityGroupId}','--db-instance-identifier','quizeey')
    matches=any(item.get('PublicIp')==HOST for item in ec2.get('data',[])) if ec2['status']=='ok' else None
    report={'checkedAt':datetime.now(timezone.utc).isoformat(),'region':args.region,'scope':'Read-only identification only; not a complete AWS retirement inventory','identity':identity['data'],'sourceHost':HOST,'ownerInstanceId':args.instance_id,'instancePublicIpMatchesSource':matches,'ec2':ec2,'rds':rds,'mutations':0,'secretRetrieval':0}
    private=ROOT/'.modernization/aws-inventory';private.mkdir(parents=True,exist_ok=True)
    raw=(json.dumps(report,indent=2)+'\n').encode('utf-8');(private/'legacy-host.json').write_bytes(raw)
    summary={'checkedAt':report['checkedAt'],'region':args.region,'scope':report['scope'],'ownerInstanceId':args.instance_id,'instancePublicIpMatchesSource':matches,'ec2Status':ec2['status'],'ec2Matches':len(ec2.get('data',[])),'rdsStatus':rds['status'],'rdsMatches':len(rds.get('data',[])),'privateReportSha256':hashlib.sha256(raw).hexdigest(),'mutations':0,'secretRetrieval':0}
    (ROOT/'docs/modernization/aws-account-identification.json').write_text(json.dumps(summary,indent=2)+'\n',encoding='utf-8')
    print(json.dumps(summary,indent=2))


if __name__=='__main__':main()
