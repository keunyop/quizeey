// Real published CMP only. Analytics/ad loaders are intercepted before transmission.
import fs from 'node:fs';
import path from 'node:path';
import {fileURLToPath} from 'node:url';
import {build} from '../../web/node_modules/vite/dist/node/index.js';
import {chromium} from '../../web/node_modules/@playwright/test/index.mjs';
const root=fileURLToPath(new URL('../../',import.meta.url));
const out=path.join(root,'.modernization/live-cmp-check');
await build({root:path.join(root,'web'),configFile:false,publicDir:false,logLevel:'error',define:{'process.env.NODE_ENV':JSON.stringify('development')},resolve:{alias:{'@':path.join(root,'web/src')}},oxc:{jsx:{runtime:'automatic'}},build:{outDir:out,emptyOutDir:false,lib:{entry:path.join(root,'web/e2e/monetization-harness.tsx'),name:'MonetizationTest',formats:['iife'],fileName:()=> 'harness.js'}}});
const js=fs.readFileSync(path.join(out,'harness.js'),'utf8');
const browser=await chromium.launch({channel:'msedge',headless:true});
const reports=[];
try{
 for(const mode of ['default','gdpr']){
  const context=await browser.newContext({locale:'en-US',viewport:{width:1280,height:900}});
  const page=await context.newPage();const requests={cmp:0,blockedAds:0,blockedAnalytics:0,blockedOther:[]};const errors=[];const transport=[];
  page.on('requestfailed',r=>transport.push({host:new URL(r.url()).hostname,error:r.failure()?.errorText}));
  page.on('response',r=>{if(new URL(r.url()).hostname==='fundingchoicesmessages.google.com')transport.push({host:'fundingchoicesmessages.google.com',status:r.status()});});
  page.on('pageerror',e=>errors.push(e.message.slice(0,200)));
  await context.route('**/*',async route=>{
   const u=new URL(route.request().url());
   if(u.origin==='https://quizeey.com')return route.fulfill({contentType:'text/html',body:`<!doctype html><html lang="en"><head><meta charset="utf-8"><title>Private CMP validation</title></head><body><div id="root"></div><script>${js}</script></body></html>`});
   if(u.hostname==='fundingchoicesmessages.google.com'||u.hostname==='www.gstatic.com'){
    requests.cmp++;
    // The managed browser cannot directly reach these hosts. Relay unchanged
    // public responses through Node; preserve actual CORS headers and JavaScript.
    try{
     const response=await fetch(u,{headers:{'User-Agent':route.request().headers()['user-agent']??'','Referer':'https://quizeey.com/','Origin':'https://quizeey.com'},signal:AbortSignal.timeout(12000)});
     const headers=Object.fromEntries(response.headers);delete headers['content-encoding'];delete headers['content-length'];
     return route.fulfill({status:response.status,headers,body:Buffer.from(await response.arrayBuffer())});
    }catch(e){transport.push({host:u.hostname,relayFailure:e.name});return route.abort();}
   }
   if(/googletagmanager|google-analytics/.test(u.hostname)){requests.blockedAnalytics++;return route.fulfill({contentType:'application/javascript',body:'window.__syntheticAnalyticsOnly=true;'});}
   if(u.hostname==='pagead2.googlesyndication.com'){requests.blockedAds++;return route.fulfill({contentType:'application/javascript',body:'window.adsbygoogle={push:()=>{}};'});}
   requests.blockedOther.push(u.origin+u.pathname);return route.abort();
  });
  await page.goto('https://quizeey.com/sqlp-developer'+(mode==='gdpr'?'?fc=alwaysshow&fctype=gdpr':''));
  await page.waitForFunction(()=>typeof window.googlefc?.getGoogleConsentModeValues==='function',null,{timeout:20000}).catch(()=>{});
  await page.waitForTimeout(2500);
  const read=()=>page.evaluate(()=>({consent:window.googlefc?.getGoogleConsentModeValues?.(),us:window.googlefc?.usstatesoptout?.getInitialUsStatesOptOutStatus?.(),tcf:typeof window.__tcfapi==='function'}));
  let values;try{values=await read();}catch{values={apiReadFailed:true};}
  const buttons=[];
  for(const frame of page.frames()){
   const labels=await frame.getByRole('button').allTextContents().catch(()=>[]);buttons.push(...labels.map(v=>v.trim()).filter(Boolean));
  }
  await page.screenshot({path:path.join(out,mode+'.png'),fullPage:false});
  reports.push({mode,values,buttons,requests,errors,transport});
  await context.close();
 }
 const report={checkedAt:new Date().toISOString(),scope:'Isolated canonical-origin synthetic page loads actual published Google CMP only; ad and analytics loaders never transmitted. No live Quizeey data/cookies or account mutations.',reports};
 fs.writeFileSync(path.join(out,'inspection.json'),JSON.stringify(report,null,2)+'\n');
 console.log(JSON.stringify(report));
}finally{await browser.close();}
