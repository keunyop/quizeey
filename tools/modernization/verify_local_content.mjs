// Full source→server→legacy API→browser rehearsal. Source stays owner-private.
import fs from 'node:fs';
import path from 'node:path';
import net from 'node:net';
import crypto from 'node:crypto';
import { spawn } from 'node:child_process';
import { createRequire } from 'node:module';
import { fileURLToPath } from 'node:url';
import { learningHtml } from '../../web/src/lib/content.ts';
import { messages } from '../../web/src/lib/i18n.ts';
const root=path.resolve(path.dirname(fileURLToPath(import.meta.url)),'../..');
const require=createRequire(path.join(root,'web/package.json'));const {chromium}=require('@playwright/test');
const origin='http://127.0.0.1:3102';
const hash=value=>crypto.createHash('sha256').update(value).digest('hex');
const check=(condition,label)=>{if(!condition)throw Object.assign(Error('Verification check failed'),{verificationStep:label});};
const pause=ms=>new Promise(resolve=>setTimeout(resolve,ms));
async function main(){
  check(!process.env.VERCEL&&!process.env.VERCEL_ENV,'local process required');
  const source=fs.realpathSync(path.resolve(process.argv[2]??''));const relative=path.relative(fs.realpathSync(path.join(root,'.modernization/exports')),source);
  check(relative&&!relative.startsWith('..')&&!path.isAbsolute(relative),'private source path');
  const content=fs.readFileSync(path.join(source,'local-content.json'));
  const manifest=JSON.parse(fs.readFileSync(path.join(source,'local-content-manifest.json'),'utf8'));
  check(hash(content)===manifest.contentSha256,'content hash');
  const data=JSON.parse(content);const t=data.tables;
  const contract=JSON.parse(fs.readFileSync(path.join(root,'web/fixtures/legacy-contract.json'),'utf8'));
  const counts=new Map();for(const q of t.questions)counts.set(q.version_id,(counts.get(q.version_id)??0)+1);
  const routeFor=id=>contract.routes.find(r=>r.testId===id&&r.locale==='ko'&&!r.path.startsWith('/kr/')&&!r.path.endsWith('/test'));
  const candidates=t.versions.filter(v=>(counts.get(v.version_id)??0)>22&&routeFor(v.exam_id));
  const version=candidates.find(v=>v.exam_id==='5')??candidates[0];
  check(version,'real version with more than twenty questions required');
  const examId=version.exam_id;const examRoute=routeFor(examId).path;
  const group=t.questions.filter(q=>q.version_id===version.version_id).sort((a,b)=>a.number-b.number);
  const question=group[22];const choices=t.choices.filter(c=>c.question_id===question.question_id);
  const deleted=JSON.parse(fs.readFileSync(path.join(source,'new-service-deleted-question-ids.json'),'utf8'));
  const ids=new Set(t.questions.map(q=>q.question_id));check(deleted.every(id=>!ids.has(id)),'deleted IDs absent');
  const original=JSON.parse(fs.readFileSync(path.join(source,'normalized.json'),'utf8'));
  const removed=original.question.find(q=>deleted.includes(q.quest_id)&&t.exams.some(e=>e.exam_id===q.test_id));
  check(removed,'removed original with retained exam');
  await new Promise((resolve,reject)=>{const server=net.createServer();server.once('error',()=>reject(Error('review port occupied')));server.listen(3102,'127.0.0.1',()=>server.close(resolve));});
  const username='local-review';const password=crypto.randomBytes(32).toString('base64url');
  const authorization='Basic '+Buffer.from(username+':'+password).toString('base64');
  const environment={...process.env,QUIZEEY_ENV:'local',QUIZEEY_CONTENT_SOURCE:'local-archive',QUIZEEY_LOCAL_CONTENT_FILE:path.join(source,'local-content.json'),QUIZEEY_PREVIEW_USER:username,QUIZEEY_PREVIEW_PASSWORD:password,QUIZEEY_LOCAL_FORUM_DATABASE_URL:'',QUIZEEY_ADMIN_USER_IDS:'',NEXT_TELEMETRY_DISABLED:'1'};
  const log=fs.openSync(path.join(source,'local-content-server.log'),'w');
  const child=spawn(process.execPath,['node_modules/next/dist/bin/next','start','--hostname','127.0.0.1','--port','3102'],{cwd:path.join(root,'web'),env:environment,stdio:['ignore',log,log],windowsHide:true});
  let browser;let started=false;let external=0;let browserErrors=0;
  try{
    for(let i=0;i<100;i++){
      if(child.exitCode!==null)throw Error('review server exited');
      try{const response=await fetch(origin);if(response.status===401){started=true;break;}}catch{}
      await pause(250);
    }
    check(started,'authenticated review startup');
    check((await fetch(origin,{headers:{authorization:'Basic invalid'}})).status===401,'wrong auth denied');
    const post=async(route,input)=>{const response=await fetch(origin+route,{method:'POST',headers:{authorization,'content-type':'application/json'},body:JSON.stringify(input)});return {response,body:await response.json()};};
    const selected=await post('/question',{testId:examId,verNbr:version.number,questId:question.question_id});
    check(selected.response.status===200,'exact source question API');
    check(String(selected.body.questId)===question.question_id&&selected.body.questNbr===question.number,'IDs and question number');
    check(JSON.stringify(selected.body.examples.filter(c=>c.answer).map(c=>String(c.exmpId)).sort())===JSON.stringify(choices.filter(c=>c.correct).map(c=>c.choice_id).sort()),'correct choice ID set');
    check(selected.body.questTxt===learningHtml(question.body),'sanitized source body');
    check(selected.body.explanation===(question.explanation===null?null:learningHtml(question.explanation)),'nullable explanation');
    check(selected.body.reference===(question.reference===null?null:learningHtml(question.reference)),'nullable/blank reference');
    const versions=await post('/versions',{testId:examId});
    check(versions.response.status===200&&versions.body.length===t.versions.filter(v=>v.exam_id===examId).length,'full version list');
    for(const [locale,field] of [['kr','name_ko'],['en','name_en']]){
      const catalog=await post('/tests',{languageCd:locale});
      check(catalog.response.status===200&&catalog.body.length===t.exams.filter(e=>e[field]!==null).length,'source catalog count');
    }
    check((await post('/question',{testId:removed.test_id,questId:removed.quest_id})).response.status===404,'deleted question API');
    check((await post('/question',{testId:t.exams.find(e=>e.exam_id!==examId).exam_id,questId:question.question_id})).response.status===404,'foreign exam ID');
    const counter=t.legacy_counters.find(c=>c.question_id===question.question_id);
    const stats=await post('/questionStats',{questId:question.question_id});
    check(stats.response.status===200&&stats.body.correct===(counter?.correct??0)&&stats.body.inCorrect===(counter?.incorrect??0),'source counters');
    browser=await chromium.launch({channel:'msedge',headless:true});
    const context=await browser.newContext({httpCredentials:{username,password},viewport:{width:390,height:844}});
    await context.route('**/*',route=>{if(new URL(route.request().url()).origin===origin)return route.continue();external++;return route.abort();});
    const page=await context.newPage();page.on('pageerror',()=>browserErrors++);
    const response=await page.goto(origin+examRoute+'?testId='+examId+'&verNbr='+version.number+'&questId='+question.question_id);
    check(response.status()===200,'deep source page');check((response.headers()['x-robots-tag']??'').includes('noindex'),'review noindex');
    check((response.headers()['cache-control']??'').includes('no-store'),'private cache');
    check(await page.locator('.question-card input').count()===choices.length,'source choices rendered');
    check(await page.evaluate(expected=>{const node=document.createElement('div');node.innerHTML=expected;return node.textContent===document.querySelector('.question-card .learning-content')?.textContent;},learningHtml(question.body)),'source SSR/browser text');
    for(const c of choices.filter(c=>c.correct))await page.locator('input[value="'+c.choice_id+'"]').check();
    await page.getByRole('button',{name:messages.ko.grade,exact:true}).click();await page.locator('.correct').waitFor({state:'visible'});check(await page.locator('.correct').count()===1,'source grading');
    await page.reload();await page.locator('.correct').waitFor({state:'visible'});check(await page.locator('.correct').count()===1,'source resume');
    await page.screenshot({path:path.join(source,'local-content-review.png'),fullPage:true});
    check(external===0&&browserErrors===0,'no external requests or browser errors');
    const result={status:'protected_local_archive_flow_pass',contentSha256:manifest.contentSha256,sourceQuestions:t.questions.length,
      directLookupBeyondTwenty:true,fullVersionList:true,originalIdsAndCorrectSets:true,sourceCounters:true,nullableFieldsPreserved:true,
      deletedQuestionCount:deleted.length,deletedIdsAbsent:true,missingAndWrongAuthentication401:true,foreignAndDeletedQuestion404:true,
      browserSourceRendering:true,gradingAndResume:true,mobileViewport:390,noindex:true,noStore:true,externalRequests:external,browserErrors,
      authorNamesAndNativePostBodiesIncluded:false,sourceContentPrinted:false,hostedUseAllowed:false};
    fs.writeFileSync(path.join(source,'local-content-flow-evidence.json'),JSON.stringify(result,null,2)+'\n');
    fs.writeFileSync(path.join(root,'docs/modernization/local-content-flow-evidence.json'),JSON.stringify(result,null,2)+'\n');
    process.stdout.write('Private source app/API/browser flow verified; screenshot and detailed evidence remain owner-private.\n');
  }finally{
    if(browser)await browser.close();
    if(child.exitCode===null){child.kill();await new Promise(resolve=>child.once('exit',resolve));}
    fs.closeSync(log);
  }
}
try{await main();}catch(error){process.stderr.write('Private source flow failed ('+(error.verificationStep??error.constructor.name)+'); inspect owner-private logs.\n');process.exitCode=1;}
