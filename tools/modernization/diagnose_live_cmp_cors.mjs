import fs from 'node:fs';
import {fileURLToPath} from 'node:url';
import {chromium} from '../../web/node_modules/@playwright/test/index.mjs';
const browser=await chromium.launch({channel:'msedge',headless:true});
const results=[];
try{
 for(const removeCmpCors of [false,true]){
  const context=await browser.newContext();
  if(removeCmpCors)await context.addInitScript(()=>{
   const append=Element.prototype.append;
   Element.prototype.append=function(...nodes){
    for(const node of nodes)if(node instanceof HTMLScriptElement&&new URL(node.src||location.href).hostname==='fundingchoicesmessages.google.com')node.removeAttribute('crossorigin');
    return append.apply(this,nodes);
   };
  });
  const page=await context.newPage();const errors=[],network=[];
  page.on('console',m=>{if(m.type()==='error')errors.push(m.text().slice(0,400));});
  page.on('requestfailed',r=>network.push({host:new URL(r.url()).hostname,failure:r.failure()?.errorText}));
  page.on('response',r=>{const u=new URL(r.url());if(u.hostname==='fundingchoicesmessages.google.com'&&u.pathname.startsWith('/i/'))network.push({host:u.hostname,status:r.status(),acao:r.headers()['access-control-allow-origin']??null});if(u.pathname.endsWith('/collect'))network.push({host:u.hostname,path:'/collect',status:r.status(),expectedMeasurementId:u.searchParams.get('tid')==='G-XM8XM4CHX7'});});
  await page.goto('https://quizeey.com/',{waitUntil:'domcontentloaded'});
  await page.waitForTimeout(10000);
  const state=await page.evaluate(()=>({cmpCrossorigin:document.getElementById('quizeey-cmp')?.getAttribute('crossorigin'),consent:window.googlefc?.getGoogleConsentModeValues?.()??null,ga:!!document.getElementById('quizeey-ga4'),ads:!!document.getElementById('quizeey-adsense')}));
  results.push({removeCmpCors,state,errors,network});await context.close();
 }
}finally{await browser.close();}
const report={checkedAt:new Date().toISOString(),scope:'Direct browser production network, no relay/mock. Second case removes only CMP crossorigin at insertion to diagnose cause; no production changes or ad clicks.',results};
fs.writeFileSync(fileURLToPath(new URL('../../docs/modernization/cmp-cors-diagnosis.json',import.meta.url)),JSON.stringify(report,null,2)+'\n');console.log(JSON.stringify(report));
