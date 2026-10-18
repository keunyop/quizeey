"""Inspect only the three catalog/controller discrepancies, serial public HTML GETs."""
import hashlib
import json
import time
from datetime import datetime,timezone
from html.parser import HTMLParser
from pathlib import Path
from urllib.error import HTTPError
from urllib.request import Request,build_opener
from probe_public import Metadata
from probe_read_api import NoRedirect

ROOT=Path(__file__).resolve().parents[2]
PATHS=['/industrial-engineer-air-conditioning-and-refrigerating-machinery','/@ccna-300-115','/microsoft-az-500']
class Identity(HTMLParser):
    def __init__(self):super().__init__();self.active=False;self.value=''
    def handle_starttag(self,tag,attrs):
        if dict(attrs).get('id')=='testId':self.active=True
    def handle_endtag(self,tag):self.active=False
    def handle_data(self,data):
        if self.active:self.value+=data


def main():
    records=[];opener=build_opener(NoRedirect())
    private=ROOT/'.modernization/public-api';private.mkdir(parents=True,exist_ok=True)
    for index,path in enumerate(PATHS):
        record={'path':path,'checkedAt':datetime.now(timezone.utc).isoformat()}
        try:
            try:response=opener.open(Request('https://quizeey.com'+path,headers={'User-Agent':'Quizeey-Compatibility-Audit/1.0 (bounded public reads)'}),timeout=10)
            except HTTPError as error:response=error
            with response:
                raw=response.read(2_000_001)
                if len(raw)>2_000_000:raise ValueError('Body bound exceeded')
                decoded=raw.decode('utf-8');meta=Metadata();meta.feed(decoded);identity=Identity();identity.feed(decoded)
                record.update(status=response.status,title=meta.title,description=meta.description,declaredTestId=identity.value.strip(),sha256=hashlib.sha256(raw).hexdigest(),canonical=meta.canonical,redirect=response.headers.get('Location'))
                (private/f'catalog-route-{index}.html').write_bytes(raw)
        except Exception as error:record['errorClass']=type(error).__name__
        records.append(record);print(json.dumps(record,ensure_ascii=True));time.sleep(1)
    (ROOT/'docs/modernization/catalog-route-probe.json').write_text(json.dumps(records,ensure_ascii=False,indent=2)+'\n',encoding='utf-8')


if __name__=='__main__':main()
