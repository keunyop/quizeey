"""Exactly three serial, source-reviewed public read POSTs; no mutating API or ad requests."""
import hashlib
import json
import time
from datetime import datetime,timezone
from pathlib import Path
from urllib.request import HTTPRedirectHandler,Request,build_opener
from urllib.error import HTTPError

ROOT=Path(__file__).resolve().parents[2]
READS=[('/tests',{'languageCd':'kr'}),('/versions',{'testId':5}),('/question',{'testId':5,'verNbr':0})]
class NoRedirect(HTTPRedirectHandler):
    def redirect_request(self,*args,**kwargs):return None


def shape(value):
    if isinstance(value,dict):return {key:shape(item) for key,item in sorted(value.items())}
    if isinstance(value,list):return {'type':'array','length':len(value),'itemShapes':list({json.dumps(shape(item),sort_keys=True):shape(item) for item in value}.values())}
    if value is None:return 'null'
    return type(value).__name__


def main():
    private=ROOT/'.modernization/public-api';private.mkdir(parents=True,exist_ok=True)
    result=[];opener=build_opener(NoRedirect())
    for path,payload in READS:
        record={'path':path,'method':'POST','sourceReviewedReadOnly':True,'checkedAt':datetime.now(timezone.utc).isoformat()}
        try:
            request=Request('https://quizeey.com'+path,data=json.dumps(payload).encode('utf-8'),method='POST',headers={'Content-Type':'application/json','User-Agent':'Quizeey-Compatibility-Audit/1.0 (bounded public reads)'})
            try:response=opener.open(request,timeout=10)
            except HTTPError as error:response=error
            with response:
                raw=response.read(2_000_001)
                if len(raw)>2_000_000:raise ValueError('Response bound exceeded')
                record.update(status=response.status,contentType=response.headers.get('Content-Type',''),responseSha256=hashlib.sha256(raw).hexdigest())
                if response.status==200 and 'application/json' in record['contentType']:
                    value=json.loads(raw)
                    record['shape']=shape(value)
                    (private/(path[1:]+'.json')).write_bytes(raw)
                    record['privateSampleSaved']=True
                    if path=='/question' and isinstance(value,dict):
                        record['identity']={key:value.get(key) for key in ['questId','testId','verNbr','questNbr']}
                        examples=value.get('examples',[])
                        record['choiceCount']=len(examples)
                        record['correctChoiceCount']=sum(item.get('answer') is True for item in examples)
        except Exception as error:record['errorClass']=type(error).__name__
        result.append(record);print(json.dumps({key:record[key] for key in ['path','status','errorClass'] if key in record}))
        time.sleep(1)
    report={'scope':'Three public read-only API samples; not a DB snapshot or live DDL','mutatingRequests':0,'adRequests':0,'results':result}
    (ROOT/'docs/modernization/public-read-api.json').write_text(json.dumps(report,ensure_ascii=False,indent=2)+'\n',encoding='utf-8')


if __name__=='__main__':main()
