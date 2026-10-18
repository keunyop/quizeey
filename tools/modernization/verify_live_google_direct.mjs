// Actual production browser network: no request routing, relay, init scripts,
// fabricated consent, DNS overrides or pointer/keyboard input. Keep live ads
// passive; verify input interactions separately with mocked ad responses.
import fs from 'node:fs';
import path from 'node:path';
import {fileURLToPath} from 'node:url';
import {chromium} from '../../web/node_modules/@playwright/test/index.mjs';
const browser=await chromium.launch({channel:'msedge',headless:true});
const context=await browser.newContext({viewport:{width:390,height:844},locale:'ko-KR'});
const responses=[],failures=[],errors=[];
let report,page,observed;
try{
 page=await context.newPage();
 page.on('pageerror',e=>errors.push(e.message.slice(0,200)));
 page.on('console',m=>{if(m.type()==='error'&&/CORS policy/.test(m.text()))errors.push(m.text().slice(0,400));});
 page.on('requestfailed',r=>{const u=new URL(r.url());failures.push({host:u.hostname,error:r.failure()?.errorText});});
 page.on('response',r=>{const u=new URL(r.url());
  if(u.hostname==='fundingchoicesmessages.google.com'&&u.pathname==='/i/pub-8362228066874729'||u.hostname==='www.googletagmanager.com'&&u.pathname==='/gtag/js'||u.hostname==='pagead2.googlesyndication.com'&&u.pathname==='/pagead/js/adsbygoogle.js'||u.pathname.endsWith('/collect'))responses.push({host:u.hostname,path:u.pathname,status:r.status(),...(u.pathname.endsWith('/collect')?{expectedMeasurementId:u.searchParams.get('tid')==='G-XM8XM4CHX7'}:{})});
 });
 await page.goto('https://quizeey.com/industrial-engineer-electric-work',{waitUntil:'domcontentloaded',timeout:30000});
 await page.waitForFunction(()=>typeof window.googlefc?.getGoogleConsentModeValues==='function',null,{timeout:20000});
 await page.evaluate(()=>window.scrollTo(0,document.body.scrollHeight));
 await page.waitForTimeout(10000);
 observed=await page.evaluate(()=>({cmpCrossorigin:document.getElementById('quizeey-cmp')?.getAttribute('crossorigin'),
  overlays:document.getElementById('quizeey-adsense')?.getAttribute('data-overlays'),studyAnnotationExcluded:document.getElementById('main')?.classList.contains('google-anno-skip'),
  questionCardAds:document.querySelector('.question-card')?.querySelectorAll('ins.adsbygoogle,.google-auto-placed,iframe[src*="doubleclick"]').length,
  consent:window.googlefc?.getGoogleConsentModeValues?.(),gaLoader:!!document.getElementById('quizeey-ga4'),adsLoader:!!document.getElementById('quizeey-adsense'),
  slots:[...document.querySelectorAll('ins.adsbygoogle')].map(el=>({status:el.getAttribute('data-ad-status'),height:Math.round(el.getBoundingClientRect().height)})),
  pageViewEvents:(window.dataLayer??[]).filter(args=>args?.[0]==='event'&&args?.[1]==='page_view').length,
  horizontalOverflow:document.documentElement.scrollWidth>innerWidth}));
 report={checkedAt:new Date().toISOString(),status:observed.cmpCrossorigin===null&&observed.gaLoader&&observed.adsLoader&&observed.overlays==='collapsed-bottom'&&observed.studyAnnotationExcluded&&observed.questionCardAds===0&&responses.some(r=>r.expectedMeasurementId&&r.status===204)&&!errors.length?'passed':'needs-attention',
  scope:'Passive actual public production page and direct Google browser network. No relay, mocked responses, init-script changes, DNS overrides or pointer/keyboard input. Actual GA4 dashboard receipt and real-device ad/control usability remain owner field checks.',observed,interactionVerification:'Not automated with live ads; use synthetic ads for interaction regression.',responses,failures,browserErrors:errors};
}catch(error){
 const out=fileURLToPath(new URL('../../.modernization/live-cutover-browser',import.meta.url));fs.mkdirSync(out,{recursive:true});if(page)await page.screenshot({path:path.join(out,'direct-google-failure.png')}).catch(()=>{});
 report={checkedAt:new Date().toISOString(),status:'needs-attention',error:error.message.slice(0,1600),observed,responses,failures,browserErrors:errors};}
finally{await context.close();await browser.close();}
fs.writeFileSync(fileURLToPath(new URL('../../docs/modernization/live-google-direct-evidence.json',import.meta.url)),JSON.stringify(report,null,2)+'\n');console.log(JSON.stringify(report));
if(report.status!=='passed')process.exitCode=1;
