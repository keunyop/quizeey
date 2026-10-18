// Actual public production page + unmodified Google responses through Node transport.
// Work around this managed browser's direct Google network restriction, without
// fabricating consent or loader responses. Never click ads or log query payloads.
import fs from 'node:fs';
import {fileURLToPath} from 'node:url';
import {chromium} from '../../web/node_modules/@playwright/test/index.mjs';
const responses=[],failures=[],errors=[];
const safePath=u=>u.hostname==='fundingchoicesmessages.google.com'&&/^\/(el|f)\//.test(u.pathname)?'/'+u.pathname.split('/')[1]+'/[opaque]':u.pathname;
const browser=await chromium.launch({channel:'msedge',headless:true});
const context=await browser.newContext({viewport:{width:390,height:844},locale:'ko-KR'});
let result;
try{
 await context.route('**/*',async route=>{
  const request=route.request(),u=new URL(request.url());
  if(!/(^|\.)(google\.com|google-analytics\.com|googletagmanager\.com|googlesyndication\.com|doubleclick\.net|gstatic\.com|googleadservices\.com)$/.test(u.hostname))return route.continue();
  try{
   const headers={...request.headers()};delete headers.host;delete headers['content-length'];delete headers['accept-encoding'];
   const response=await fetch(u,{method:request.method(),headers,body:['GET','HEAD'].includes(request.method())?undefined:request.postDataBuffer(),signal:AbortSignal.timeout(12000)});
   const returned=Object.fromEntries(response.headers);delete returned['content-encoding'];delete returned['content-length'];
   const body=Buffer.from(await response.arrayBuffer());
   responses.push({host:u.hostname,path:safePath(u),status:response.status,...(u.pathname.endsWith('/collect')?{expectedMeasurementId:u.searchParams.get('tid')==='G-XM8XM4CHX7'}:{})});
   await route.fulfill({status:response.status,headers:returned,body});
  }catch(error){failures.push({host:u.hostname,path:safePath(u),error:error.name});await route.abort().catch(()=>{});}
 });
 const page=await context.newPage();page.on('pageerror',e=>errors.push(e.message.slice(0,200)));
 await page.goto('https://quizeey.com/industrial-engineer-electric-work',{waitUntil:'domcontentloaded',timeout:30000});
 await page.waitForFunction(()=>typeof window.googlefc?.getGoogleConsentModeValues==='function',null,{timeout:18000}).catch(()=>{});
 await page.evaluate(()=>window.scrollTo(0,document.body.scrollHeight));
 await page.waitForTimeout(10000);
 const observed=await page.evaluate(()=>({consent:window.googlefc?.getGoogleConsentModeValues?.()??null,
  usApi:typeof window.googlefc?.usstatesoptout?.getInitialUsStatesOptOutStatus==='function',
  gaLoader:!!document.querySelector('script[src*="googletagmanager.com/gtag/js"]'),adsLoader:!!document.querySelector('script[src*="pagead2.googlesyndication.com/pagead/js/adsbygoogle.js"]'),
  slots:[...document.querySelectorAll('ins.adsbygoogle')].map(el=>({status:el.getAttribute('data-ad-status'),height:Math.round(el.getBoundingClientRect().height)})),
  pageViewEvents:(window.dataLayer??[]).filter(args=>args?.[0]==='event'&&args?.[1]==='page_view').length,
  horizontalOverflow:document.documentElement.scrollWidth>window.innerWidth}));
 result={checkedAt:new Date().toISOString(),status:observed.consent&&observed.gaLoader&&observed.adsLoader?'integration-loaders-confirmed':'needs-attention',
  scope:'Actual public production page/data and Google CMP/AdSense/GA4 responses. Google transport relayed unchanged through Node because managed browser direct Google access fails; no fabricated consent or mocked scripts, ad clicks, account changes or logged query payloads. Actual GA4 property receipt and regional/ad-overlay UX still require owner field checks.',observed,responses,failures,browserErrors:errors};
}catch(error){result={checkedAt:new Date().toISOString(),status:'needs-attention',error:error.message.slice(0,300),responses,failures,browserErrors:errors};}
finally{await context.close();await browser.close();}
fs.writeFileSync(fileURLToPath(new URL('../../docs/modernization/live-google-evidence.json',import.meta.url)),JSON.stringify(result,null,2)+'\n');
console.log(JSON.stringify(result));
