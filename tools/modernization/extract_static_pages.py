"""Preserve source static copy and explicitly referenced local images; never run legacy scripts."""
import hashlib
import json
import re
import shutil
from html import escape
from html.parser import HTMLParser
from pathlib import Path

ROOT=Path(__file__).resolve().parents[2]


class MainCopy(HTMLParser):
    def __init__(self):
        super().__init__(convert_charrefs=False)
        self.depth=0;self.output=[];self.heading=False;self.found=False
    def handle_starttag(self,tag,attrs):
        attributes=dict(attrs)
        if not self.depth:
            if tag=='div' and attributes.get('id')=='main-div':self.depth=1;self.found=True
            return
        if tag=='div':self.depth+=1
        if tag=='h1':self.heading=True;return
        if self.heading:return
        if tag=='img' and not attributes.get('src') and attributes.get('data-src'):
            attributes['src']='/'+attributes['data-src'].lstrip('/')
            attributes['alt']='AWS Certified Developer – Associate badge'
        rendered=''.join(' '+key+'="'+escape(value or '',quote=True)+'"' for key,value in attributes.items())
        self.output.append('<'+tag+rendered+'>')
    def handle_endtag(self,tag):
        if not self.depth:return
        if tag=='div':
            self.depth-=1
            if not self.depth:return
        if tag=='h1':self.heading=False;return
        if not self.heading:self.output.append('</'+tag+'>')
    def handle_data(self,text):
        if self.depth and not self.heading:self.output.append(text)
    def handle_entityref(self,name):
        if self.depth and not self.heading:self.output.append('&'+name+';')
    def handle_charref(self,name):
        if self.depth and not self.heading:self.output.append('&#'+name+';')


def main():
    pages={};evidence={}
    for name in ['about','privacy']:
        source=ROOT/'src/main/resources/templates'/f'{name}.hbs'
        original=source.read_text(encoding='utf-8')
        parser=MainCopy();parser.feed(re.sub(r'{{!--.*?--}}','',original,flags=re.S))
        if not parser.found or parser.depth:raise ValueError('Source content boundary changed')
        html=''.join(parser.output).strip()
        pages['/'+name]={'lang':'en','html':html}
        evidence['/'+name]={'source':str(source.relative_to(ROOT)).replace('\\','/'),'sourceSha256':hashlib.sha256(source.read_bytes()).hexdigest(),'extractedSha256':hashlib.sha256(html.encode()).hexdigest(),'sourceStatus':'reviewed-source-only','liveBodyVerified':False}
    image='img/awsCertifiedDeveloper-associate_badge.png'
    source=ROOT/'src/main/resources/static'/image;target=ROOT/'web/public'/image
    target.parent.mkdir(parents=True,exist_ok=True);shutil.copyfile(source,target)
    evidence['assets']=[{'path':'/'+image,'sha256':hashlib.sha256(source.read_bytes()).hexdigest(),'bytes':source.stat().st_size,'origin':'existing-repository-asset','rightsReview':'prelaunch'}]
    (ROOT/'web/fixtures/legacy-pages.json').write_text(json.dumps(pages,ensure_ascii=False,indent=2)+'\n',encoding='utf-8')
    (ROOT/'docs/modernization/static-copy-evidence.json').write_text(json.dumps(evidence,ensure_ascii=False,indent=2)+'\n',encoding='utf-8')
    print('Source copy extracted for 2 pages; 1 existing local image preserved. No live requests.')


if __name__=='__main__':main()
