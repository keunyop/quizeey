// Actual Next server + synthetic private archive. No real content or hosted DB.
import fs from 'node:fs';
import path from 'node:path';
import net from 'node:net';
import {spawn} from 'node:child_process';
import {createHash,randomUUID} from 'node:crypto';
import {fileURLToPath} from 'node:url';
import assert from 'node:assert/strict';
import {chromium,expect} from '../../web/node_modules/@playwright/test/index.mjs';
const root=fileURLToPath(new URL('../../',import.meta.url));
const port=3110;
await new Promise((resolve,reject)=>{const probe=net.createServer();probe.once('error',()=>reject(new Error('Refusing occupied test port')));probe.listen(port,'127.0.0.1',()=>probe.close(resolve));});
const directory=path.join(root,'.modernization/exports','synthetic-study-pages-'+randomUUID());fs.mkdirSync(directory,{recursive:true});
const questions=Array.from({length:26},(_,i)=>({question_id:String(800000001+i),version_id:i<25?'11':'12',number:i<25?i+1:1,body:'Synthetic question '+(i+1),explanation:'Synthetic explanation',reference:null,multiple_answers:false}));
const payload=JSON.stringify({schema:1,tables:{exams:[{exam_id:'5',name_ko:'Synthetic exam',name_en:null,legacy_slug:'sqlp-developer',priority:1}],versions:[{version_id:'11',exam_id:'5',number:1,name:'Synthetic first set'},{version_id:'12',exam_id:'5',number:2,name:'Synthetic second set'}],questions,choices:questions.flatMap((q,i)=>[0,1].map(n=>({choice_id:String(810000001+i*2+n),question_id:q.question_id,number:n+1,body:'Synthetic choice '+n,correct:n===0}))),legacy_counters:[]},pendingExplanationCounts:{}});
const input=path.join(directory,'local-content.json');fs.writeFileSync(input,payload);
fs.writeFileSync(path.join(directory,'local-content-manifest.json'),JSON.stringify({status:'owner_approved_filtered_local_review',hostedUseAllowed:false,deletedQuestionCount:751,deletedQuestionIdSetSha256:'425654b55ad190dce415c853c95908521c6de0ed9e2860101d0ae8ac2730c6fd',contentSha256:createHash('sha256').update(payload).digest('hex'),syntheticTestOnly:true}));
const credentials={username:'synthetic-review',password:'synthetic-test-only-password-24-characters'};
const log=fs.openSync(path.join(directory,'next.log'),'w');
const serverEnv={...process.env,QUIZEEY_ENV:'local',QUIZEEY_CONTENT_SOURCE:'local-archive',QUIZEEY_LOCAL_CONTENT_FILE:input,QUIZEEY_PREVIEW_USER:credentials.username,QUIZEEY_PREVIEW_PASSWORD:credentials.password};
delete serverEnv.VERCEL_ENV;delete serverEnv.VERCEL;
const server=spawn(process.execPath,[path.join(root,'web/node_modules/next/dist/bin/next'),'start','--hostname','127.0.0.1','--port',String(port)],{cwd:path.join(root,'web'),stdio:['ignore',log,log],windowsHide:true,env:serverEnv});
let browser;
try{
 const origin='http://127.0.0.1:'+port;let ready=false;
 for(let i=0;i<60;i++){
  if(server.exitCode!==null)throw new Error('Owned Next server exited');
  try{const response=await fetch(origin,{signal:AbortSignal.timeout(1000)});if(response.status===401){ready=true;break;}}catch{}
  await new Promise(resolve=>setTimeout(resolve,250));
 }
 assert.ok(ready,'Owned Next server did not start');
 browser=await chromium.launch({channel:'msedge',headless:true});
 const context=await browser.newContext({httpCredentials:credentials});const page=await context.newPage();const errors=[];const external=[];
 page.on('pageerror',error=>errors.push(error.message));page.on('request',request=>{if(!request.url().startsWith(origin))external.push(request.url());});
 await page.goto(origin+'/sqlp-developer?verNbr=1');
 await expect(page.locator('#question-content')).toHaveText('Synthetic question 1');
 await page.locator('input[value="810000001"]').check();await page.getByRole('button',{name:'정답 확인',exact:true}).click();await page.getByRole('button',{name:'다음',exact:true}).click();
 for(let i=2;i<=20;i++)await page.getByRole('button',{name:'건너뛰기',exact:true}).click();
 await expect(page.getByRole('link',{name:'이어서 풀기',exact:true})).toHaveAttribute('data-google-vignette','false');
 await expect(page.getByRole('link',{name:'다음 문제',exact:true})).toHaveAttribute('data-google-vignette','false');
 await page.getByRole('link',{name:'이어서 풀기',exact:true}).click();
 await expect(page).toHaveURL(/verNbr=1&page=2$/);
 await expect(page.locator('#question-content')).toHaveText('Synthetic question 21');
 await expect(page.locator('.question-counter')).toContainText('/ 5');
 await page.locator('input').first().check();await page.getByRole('button',{name:'정답 확인',exact:true}).click();
 await page.reload();await expect(page.getByText('정답입니다.',{exact:true})).toBeVisible();
 await page.getByRole('button',{name:'다음',exact:true}).click();for(let i=22;i<=25;i++)await page.getByRole('button',{name:'건너뛰기',exact:true}).click();
 await expect(page.getByRole('link',{name:'이어서 풀기',exact:true})).toHaveCount(0);
 await page.getByRole('link',{name:'이전 문제',exact:true}).click();await expect(page.getByRole('heading',{name:'학습 결과',exact:true})).toBeVisible();
 await page.goto(origin+'/test?testId=5&verNbr=1&page=2');
 await expect(page.getByRole('link',{name:'이전 문제',exact:true})).toHaveAttribute('href','/test?testId=5&verNbr=1');
 await page.locator('#version').selectOption('2');await page.getByRole('button',{name:'적용',exact:true}).click();
 await expect(page).toHaveURL(/test\?testId=5&verNbr=2$/);await expect(page.locator('#question-content')).toHaveText('Synthetic question 26');
 assert.equal((await context.request.get(origin+'/sqlp-developer?verNbr=1&page=3')).status(),404);
 assert.equal((await context.request.get(origin+'/sqlp-developer?page=10001')).status(),400);
 assert.deepEqual(errors,[]);assert.deepEqual(external,[]);
 const result={checkedAt:new Date().toISOString(),status:'passed',scope:'Actual Next production bundle with 26 synthetic local-only questions; no live archive or cloud database used.',checks:['20→21 continuation','learning continuation links exclude vignette triggers','final batch of 5','independent per-page progress after refresh','return to previous results','generic URL testId/version preservation','set changes reset page','404 beyond last page','400 invalid page','zero browser errors/external integration requests']};
 fs.writeFileSync(path.join(root,'docs/modernization/study-page-browser-evidence.json'),JSON.stringify(result,null,2)+'\n');console.log(JSON.stringify(result));
}finally{if(browser)await browser.close();server.kill();await new Promise(resolve=>{if(server.exitCode!==null)resolve();else server.once('exit',resolve);});fs.closeSync(log);}
