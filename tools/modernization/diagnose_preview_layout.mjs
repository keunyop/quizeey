// Layout measurements only; do not print source question text or credentials.
import fs from 'node:fs';
import path from 'node:path';
import { createRequire } from 'node:module';
import { fileURLToPath } from 'node:url';
const root=path.resolve(path.dirname(fileURLToPath(import.meta.url)),'../..');
const source=path.join(root,'.modernization/exports/source-265c3ca16e');
const require=createRequire(path.join(root,'web/package.json'));
const {chromium}=require('@playwright/test');
let browser;
try {
  const a=JSON.parse(fs.readFileSync(path.join(source,'preview-access.json'),'utf8'));
  const {tables:t}=JSON.parse(fs.readFileSync(path.join(source,'local-content.json'),'utf8'));
  const contract=JSON.parse(fs.readFileSync(path.join(root,'web/fixtures/legacy-contract.json'),'utf8'));
  const routeFor=id=>contract.routes.find(r=>r.testId===id&&r.locale==='ko'&&!r.path.startsWith('/kr/')&&!r.path.endsWith('/test'));
  const candidates=t.versions.filter(v=>t.questions.filter(q=>q.version_id===v.version_id).length>22&&routeFor(v.exam_id));
  const version=candidates.find(v=>v.exam_id==='5')??candidates[0];
  const q=t.questions.filter(q=>q.version_id===version.version_id).sort((a,b)=>a.number-b.number||Number(a.question_id)-Number(b.question_id))[22];
  const route=routeFor(version.exam_id);
  browser=await chromium.launch({channel:'msedge',headless:true});
  const context=await browser.newContext({httpCredentials:{username:a.user,password:a.password},viewport:{width:390,height:844}});
  await context.route('**/*',r=>new URL(r.request().url()).origin===a.origin?r.continue():r.abort());
  const page=await context.newPage();
  await page.goto(a.shareUrl,{waitUntil:'networkidle'});
  await page.goto(a.origin+route.path+'?verNbr='+version.number+'&questId='+q.question_id);
  if(process.argv.includes('--verify-fix'))await page.addStyleTag({content:'.version-form select { min-width:0; max-width:100%; }'});
  const details=await page.evaluate(()=>({viewport:innerWidth,documentWidth:document.documentElement.scrollWidth,scripts:[...document.querySelectorAll('script[src]')].map(e=>{const u=new URL(e.src);return {host:u.host,path:u.pathname};}),elements:[...document.querySelectorAll('body *')].map(e=>{
    const r=e.getBoundingClientRect(),s=getComputedStyle(e);
    return {tag:e.tagName,className:typeof e.className==='string'?e.className:'',id:e.id,left:r.left,right:r.right,width:r.width,scrollWidth:e.scrollWidth,overflowX:s.overflowX,whiteSpace:s.whiteSpace,display:s.display};
  }).filter(e=>e.right>innerWidth+1||e.left< -1).slice(0,35)}));
  fs.writeFileSync(path.join(source,'cloud-preview-layout-diagnostic.json'),JSON.stringify(details,null,2)+'\n');
  await page.screenshot({path:path.join(source,'cloud-preview-layout-diagnostic.png'),fullPage:true});
  console.log(JSON.stringify(details));
  if(process.argv.includes('--verify-fix')&&details.documentWidth>details.viewport)throw new Error('Layout still overflows');
}catch {console.error('Private layout diagnosis failed; no source or credentials printed.');process.exitCode=1;}
finally {if(browser)await browser.close();}
