"""Two bounded TCP/greeting probes to the owner-confirmed legacy host. No login or SQL."""
import ipaddress
import json
import re
import socket
from datetime import datetime,timezone
from pathlib import Path

ROOT=Path(__file__).resolve().parents[2]
HOST='ec2-52-35-43-187.us-west-2.compute.amazonaws.com'


def main():
    report={'checkedAt':datetime.now(timezone.utc).isoformat(),'ownerInstanceId':'i-046087bdb8dff10f7','host':HOST,'instanceIdentityVerified':False,'scope':'TCP and protocol greeting only; no authentication or query','ports':{},'authenticationAttempts':0,'databaseQueries':0,'serverChanges':0,'keyCopiedOrPrinted':False}
    peer=None
    for port in [22,3306]:
        result={}
        try:
            with socket.create_connection((HOST,port),timeout=5) as connection:
                connection.settimeout(5)
                result['tcp']='reachable'
                if port==3306:
                    header=b''
                    while len(header)<4:
                        chunk=connection.recv(4-len(header))
                        if not chunk:raise ValueError('Truncated greeting')
                        header+=chunk
                    length=int.from_bytes(header[:3],'little')
                    if not 1<=length<=4096:raise ValueError('Greeting bound exceeded')
                    payload=b''
                    while len(payload)<length:
                        chunk=connection.recv(length-len(payload))
                        if not chunk:raise ValueError('Truncated greeting')
                        payload+=chunk
                    result['greeting']='error' if payload[0]==255 else 'handshake'
                    if payload[0]==255:
                        result['errorCode']=int.from_bytes(payload[1:3],'little')
                        match=re.search(r"Host '([0-9.]+)'",payload.decode('utf-8',errors='ignore'))
                        if match:
                            try:peer=str(ipaddress.ip_address(match.group(1)))
                            except ValueError:pass
        except TimeoutError:result['tcp']=result.get('tcp','timed_out')
        except ConnectionRefusedError:result['tcp']='refused'
        except Exception as error:result['errorClass']=type(error).__name__
        report['ports'][str(port)]=result
    private=ROOT/'.modernization/ssh';private.mkdir(parents=True,exist_ok=True)
    (private/'direct-peer.json').write_text(json.dumps({'sourceIpSeenByDatabase':peer,'scope':'Private network diagnosis only; no credentials or query sent'},indent=2)+'\n',encoding='utf-8')
    (ROOT/'docs/modernization/ssh-access-evidence.json').write_text(json.dumps(report,indent=2)+'\n',encoding='utf-8')
    print(json.dumps(report,indent=2))


if __name__=='__main__':main()
