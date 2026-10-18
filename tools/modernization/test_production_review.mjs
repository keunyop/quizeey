// Isolated production configuration + actual Next/browser, using synthetic RPCs only.
import fs from 'node:fs';
import path from 'node:path';
import net from 'node:net';
import http from 'node:http';
import {spawn} from 'node:child_process';
import {randomUUID} from 'node:crypto';
import {fileURLToPath,pathToFileURL} from 'node:url';
import assert from 'node:assert/strict';
import {chromium,expect} from '../../web/node_modules/@playwright/test/index.mjs';

const root=fileURLToPath(new URL('../../',import.meta.url));
const release=process.argv.includes('--release');
const reuse=process.argv.find(arg=>arg.startsWith('--reuse='))?.slice(8);
if(process.argv.slice(2).some(arg=>arg!=='--release'&&!arg.startsWith('--reuse='))||(reuse&&!/^production-release-test-[a-f0-9-]+$/.test(reuse)))throw new Error('Unexpected QA option');
// Node24 fetch ignores a supplied Host header. Use the real HTTP transport for
// these explicit routed-host tests, rather than silently probing loopback Host.
const fetch=(url,init={})=>new Promise((resolve,reject)=>{
 const request=http.request(url,{method:init.method??'GET',headers:init.headers},response=>{
  const chunks=[];response.on('data',chunk=>chunks.push(chunk));response.on('error',reject);
  response.on('end',()=>resolve(new Response(Buffer.concat(chunks),{status:response.statusCode,headers:Object.fromEntries(Object.entries(response.headers).map(([key,value])=>[key,Array.isArray(value)?value.join(','):value]))})));
 });
 request.setTimeout(10000,()=>request.destroy(new Error('Owned QA request timeout')));request.on('error',reject);if(init.body)request.write(init.body);request.end();
});
const port=release?3114:3112;
await new Promise((resolve,reject)=>{const probe=net.createServer();probe.once('error',()=>reject(new Error('Refusing occupied QA port')));probe.listen(port,'127.0.0.1',()=>probe.close(resolve));});
const directory=path.join(root,'.modernization',reuse??(release?'production-release-test-':'production-review-test-')+randomUUID());
const app=path.join(directory,'app');fs.mkdirSync(app,{recursive:true});
const files=JSON.parse(fs.readFileSync(path.join(root,'.modernization',release?'vercel-production-release':'vercel-production-review','files.json'),'utf8'));
for(const file of files){
  assert.ok(file.file.startsWith('web/'));
  const target=path.resolve(app,file.file.slice(4));
  assert.ok(target.startsWith(app+path.sep),'Copy must remain in isolated app');
  if(reuse){assert.ok(fs.readFileSync(target).equals(Buffer.from(file.data,'base64')),'Reused build source differs: '+file.file);}
  else{fs.mkdirSync(path.dirname(target),{recursive:true});fs.writeFileSync(target,Buffer.from(file.data,'base64'));}
}
const modules=fs.realpathSync(path.join(root,'web/node_modules'));
assert.ok(modules.startsWith(fs.realpathSync(root)+path.sep));
if(!reuse)fs.symlinkSync(modules,path.join(app,'node_modules'),'junction');
const mock=path.join(directory,'mock-rpc.mjs');
// No real secrets, archives or user-authored posts are available in this test.
fs.writeFileSync(mock,`
import fs from 'node:fs';
const exams=Array.from({length:181},(_,i)=>({exam_id:String(i+1),name_ko:'Synthetic exam '+(i+1),name_en:null,legacy_slug:i===139?'industrial-engineer-electric-work':'synthetic-'+(i+1),priority:1}));
const all=Array.from({length:20},(_,i)=>({question_id:String(800000001+i),version_id:'11',number:i+1,body:'Synthetic question '+(i+1),explanation:'Synthetic built-in solution',reference:null,multiple_answers:false}));
globalThis.fetch=async(input,init)=>{
 const url=new URL(typeof input==='string'?input:input.url??input.toString());
 if(url.origin!=='https://tfkhnrbshvyfmrzxqfmq.supabase.co'||!['/rest/v1/rpc/quizeey_study_page','/rest/v1/rpc/quizeey_study_context'].includes(url.pathname))throw new Error('Synthetic test blocked external server fetch');
 fs.appendFileSync(process.env.SYNTHETIC_RPC_LOG,url.pathname+'\\n');
 const args=JSON.parse(init?.body??'{}');
 const questions=args.p_question_id?all.filter(q=>q.question_id===args.p_question_id):args.p_exam_id==='140'?all:[];
 const data={schema:1,tables:{exams,versions:questions.length?[{version_id:'11',exam_id:'140',number:1,name:'Synthetic first set'}]:[],questions,
 choices:questions.flatMap(q=>[0,1].map(n=>({choice_id:String(810000001+(Number(q.question_id)-800000001)*2+n),question_id:q.question_id,number:n+1,body:'Synthetic choice '+n,correct:n===0}))),legacy_counters:[]},pendingExplanationCounts:{}};
 if(url.pathname.endsWith('quizeey_study_page'))data.pagination={page:args.p_page??1,total:20};
 return Response.json(data);
};
`);
const credentials={username:'synthetic-review',password:'synthetic-test-only-password-over-24-characters'};
const authorization='Basic '+Buffer.from(credentials.username+':'+credentials.password).toString('base64');
const serverEnv={...process.env};
for(const key of Object.keys(serverEnv))if(/^(QUIZEEY_|VERCEL|CRON_SECRET|NEXT_PUBLIC_)/.test(key))delete serverEnv[key];
Object.assign(serverEnv,{
 VERCEL:'1',VERCEL_ENV:'production',QUIZEEY_ENV:'production',QUIZEEY_CONTENT_SOURCE:'supabase',
 QUIZEEY_PRODUCTION_REVIEW:release?'false':'true',QUIZEEY_RELEASE_READY:release?'true':'false',
 // Deliberately present: review must suppress them even on the canonical host.
 QUIZEEY_ADS_VERIFIED:'true',QUIZEEY_GA4_MEASUREMENT_ID:release?'G-XM8XM4CHX7':'G-TESTONLY123',
 QUIZEEY_CMP_SCRIPT_URL:'https://fundingchoicesmessages.google.com/i/pub-8362228066874729?ers=1',
 QUIZEEY_CANONICAL_ORIGIN:'https://quizeey.com',QUIZEEY_PREVIEW_USER:credentials.username,QUIZEEY_PREVIEW_PASSWORD:credentials.password,
 QUIZEEY_SUPABASE_URL:'https://tfkhnrbshvyfmrzxqfmq.supabase.co',QUIZEEY_SUPABASE_SECRET_KEY:'sb_secret_syntheticOnly',
 QUIZEEY_CONTENT_DATASET_SHA256:'88ed4da320cf3bbd40d65f1aa6de7ba6b81a09f5aa6bbcef1e3860ca58ccb42f',
 NODE_OPTIONS:'--import='+pathToFileURL(mock).href,NEXT_TELEMETRY_DISABLED:'1',SYNTHETIC_RPC_LOG:path.join(directory,'rpc.log'),
});
const buildLog=fs.openSync(path.join(directory,'build.log'),reuse?'a':'w');
const run=async(args)=>new Promise((resolve,reject)=>{
 const child=spawn(process.execPath,args,{cwd:app,env:serverEnv,windowsHide:true,stdio:['ignore',buildLog,buildLog]});
 child.once('error',reject);child.once('exit',code=>code===0?resolve():reject(new Error('Isolated build failed; inspect local synthetic build log')));
});
await run(['scripts/preflight-production.ts']);
if(!reuse)await run([path.join(modules,'next/dist/bin/next'),'build','--webpack']);
else assert.ok(fs.existsSync(path.join(app,'.next/BUILD_ID')),'Reused production build is missing');
fs.closeSync(buildLog);
assert.ok(fs.readFileSync(path.join(directory,'build.log'),'utf8').includes('"productionReadVerified":true'));
const log=fs.openSync(path.join(directory,'next.log'),'w');
const server=spawn(process.execPath,[path.join(modules,'next/dist/bin/next'),'start','--hostname','127.0.0.1','--port',String(port)],{cwd:app,env:serverEnv,windowsHide:true,stdio:['ignore',log,log]});
let browser;
try{
 const origin='http://127.0.0.1:'+port;let ready=false;
 for(let i=0;i<80;i++){
  if(server.exitCode!==null)throw new Error('Owned QA server exited');
  try{if((await fetch(origin,{signal:AbortSignal.timeout(1000)})).status===401){ready=true;break;}}catch{}
  await new Promise(resolve=>setTimeout(resolve,250));
 }
 assert.ok(ready,'Owned QA server did not start');
 for(const host of ['quizeey.com','www.quizeey.com','synthetic.vercel.app']){
  const response=await fetch(origin,{headers:{host},redirect:'manual'});
  assert.equal(response.status,release?(host==='quizeey.com'?200:host==='www.quizeey.com'?308:401):401,host);
  if(!release||host==='synthetic.vercel.app')assert.match(response.headers.get('x-robots-tag'),/noindex/);
  else if(host==='www.quizeey.com')assert.equal(response.headers.get('location'),'https://quizeey.com/');
  else assert.equal(response.headers.get('x-robots-tag'),null);
 }
 const headers={host:'quizeey.com',authorization};
 const robots=await fetch(origin+'/robots.txt',{headers});assert.equal(robots.status,200);const robotsText=await robots.text();
 if(release){assert.match(robotsText,/Allow: \//);assert.match(robotsText,/Sitemap: https:\/\/quizeey.com\/sitemap.xml/);assert.equal(robots.headers.get('x-robots-tag'),null);}
 else{assert.match(robotsText,/Disallow: \//);assert.match(robots.headers.get('x-robots-tag'),/noindex/);}
 const sitemap=await fetch(origin+'/sitemap.xml',{headers});assert.equal(sitemap.status,200);const xml=await sitemap.text();
 if(release){assert.ok((xml.match(/<loc>/g)??[]).length>180);assert.doesNotMatch(xml,/vercel\.app|\/kr\/|\/test</);}else assert.doesNotMatch(xml,/<loc>/);
 if(release){const ads=await fetch(origin+'/ads.txt',{headers});assert.equal((await ads.text()).trim(),'google.com, pub-8362228066874729, DIRECT, f08c47fec0942fa0');}
 for(const [id,status]of [['800000001',200],['899999999',404]]){
  const response=await fetch(origin+'/explanations',{method:'POST',headers:{...headers,'content-type':'application/json'},body:JSON.stringify({questId:id})});assert.equal(response.status,status);if(status===200)assert.deepEqual(await response.json(),[]);
 }
 browser=await chromium.launch({channel:'msedge',headless:true});
 const context=await browser.newContext();const external=[];const errors=[];const integrations={cmp:0,ads:0,ga:0};
 // Browser keeps the real canonical origin; transport goes exclusively to this QA server.
 await context.route('**/*',async route=>{
  const request=route.request();const url=new URL(request.url());
  if(release&&url.hostname==='fundingchoicesmessages.google.com'){
   integrations.cmp++;return route.fulfill({contentType:'application/javascript',body:`googlefc.getGoogleConsentModeValues=()=>({adStoragePurposeConsentStatus:3,adUserDataPurposeConsentStatus:3,adPersonalizationPurposeConsentStatus:3,analyticsStoragePurposeConsentStatus:3});googlefc.usstatesoptout.getInitialUsStatesOptOutStatus=()=>1;googlefc.callbackQueue.forEach(item=>Object.values(item).forEach(fn=>fn()));`});
  }
  if(release&&url.hostname==='www.googletagmanager.com'){assert.equal(url.searchParams.get('id'),'G-XM8XM4CHX7');integrations.ga++;return route.fulfill({contentType:'application/javascript',body:'window.__mockGa=true;'});}
  if(release&&url.hostname==='pagead2.googlesyndication.com'){assert.equal(url.searchParams.get('client'),'ca-pub-8362228066874729');integrations.ads++;return route.fulfill({contentType:'application/javascript',body:`window.adsbygoogle={push:()=>{document.querySelectorAll('ins.adsbygoogle').forEach(node=>node.dataset.adStatus='filled');}};`});}
  if(url.origin!=='https://quizeey.com'){external.push(url.origin+url.pathname);await route.abort();return;}
  const forwarded={...request.headers(),host:'quizeey.com','x-forwarded-proto':'https',authorization};delete forwarded['accept-encoding'];
  const response=await fetch(origin+url.pathname+url.search,{method:request.method(),headers:forwarded,body:request.postDataBuffer()});
  await route.fulfill({status:response.status,headers:Object.fromEntries(response.headers),body:Buffer.from(await response.arrayBuffer())});
 });
 const page=await context.newPage();page.on('pageerror',error=>errors.push(error.message));
 await page.goto('https://quizeey.com/');
 await expect(page.locator('meta[name="robots"]')).toHaveAttribute('content',release?'index, follow':/noindex/);
 if(release)await expect(page.locator('link[rel="canonical"]')).toHaveAttribute('href','https://quizeey.com/');
 await page.goto('https://quizeey.com/industrial-engineer-electric-work');
 await expect(page.locator('#question-content')).toHaveText('Synthetic question 1');
 await page.locator('input[value="810000001"]').check();await page.getByRole('button',{name:'정답 확인',exact:true}).click();
 await expect(page.getByText('정답입니다.',{exact:true})).toBeVisible();
 await page.reload();await expect(page.getByText('정답입니다.',{exact:true})).toBeVisible();
 await page.getByRole('button',{name:'다음',exact:true}).click();await expect(page.locator('#question-content')).toHaveText('Synthetic question 2');
 await expect(page.locator('meta[name="robots"]')).toHaveAttribute('content',release?'index, follow':/noindex/);
 if(release){
  await expect(page.locator('link[rel="canonical"]')).toHaveAttribute('href','https://quizeey.com/industrial-engineer-electric-work');
  await page.evaluate(()=>window.scrollTo(0,document.body.scrollHeight));await expect.poll(()=>integrations.ads).toBeGreaterThan(0);
  const views=await page.evaluate(()=>window.dataLayer.map(args=>Array.from(args)).filter(args=>args[0]==='event'&&args[1]==='page_view'));
  assert.equal(views.length,1);assert.equal(views[0][2].send_to,'G-XM8XM4CHX7');
 }
 assert.equal(await page.locator('.forum').count(),0);
 await page.waitForTimeout(1000);assert.deepEqual(errors,[]);assert.deepEqual(external,[]);
 const result={checkedAt:new Date().toISOString(),status:'passed',scope:'Isolated Next production-review build, synthetic RPC data/credentials and canonical-origin browser forwarding; no actual Google or cloud requests.',
 checks:['production preflight runs with bounded 181-exam/20-question synthetic read','Basic required for canonical/www/deployment hosts','robots disallow all and sitemap has no URLs','canonical browser metadata noindex','canonical home and practice suppress Google even with advertising/consent configuration present','grading, refresh restoration and next-question flow','deferred public posts stay empty; unknown question 404','zero browser errors/external requests'],
 actualProductionCredentialVerified:false,actualHostedBrowserVerified:false,buildMode:'webpack',externalBrowserRequests:0,browserErrors:0};
 if(release){result.scope='Actual Next public production configuration with synthetic RPCs and intercepted CMP/AdSense/GA4 scripts; no real Google/cloud requests.';result.checks=['canonical public access without Basic; www308; candidate Basic/noindex','public robots/sitemap with canonical URLs and no global noindex','existing ads.txt publisher retained','canonical metadata and existing GA4/publisher script identities','single page_view per document after synthetic consent','grading, restore, next question and deferred posts','zero browser errors or unhandled external requests'];result.integrationScriptInterceptions=integrations;}
 fs.writeFileSync(path.join(root,'docs/modernization',release?'production-release-browser-evidence.json':'production-review-browser-evidence.json'),JSON.stringify(result,null,2)+'\n');console.log(JSON.stringify(result));
}finally{
 if(browser)await browser.close();server.kill();await new Promise(resolve=>{if(server.exitCode!==null)resolve();else server.once('exit',resolve);});fs.closeSync(log);
}
