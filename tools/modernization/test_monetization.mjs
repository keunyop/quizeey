// Tests actual components with synthetic questions. ALL browser requests are
// intercepted; this never loads live Google code or clicks a real advertisement.
import fs from 'node:fs';
import path from 'node:path';
import assert from 'node:assert/strict';
import {fileURLToPath} from 'node:url';
import {build} from '../../web/node_modules/vite/dist/node/index.js';
import {chromium,expect} from '../../web/node_modules/@playwright/test/index.mjs';
const root=fileURLToPath(new URL('../../',import.meta.url));
const out=path.join(root,'.modernization/monetization-browser');
await build({root:path.join(root,'web'),configFile:false,publicDir:false,logLevel:'error',define:{'process.env.NODE_ENV':JSON.stringify('development')},resolve:{alias:{'@':path.join(root,'web/src')}},oxc:{jsx:{runtime:'automatic'}},build:{outDir:out,emptyOutDir:false,lib:{entry:path.join(root,'web/e2e/monetization-harness.tsx'),name:'MonetizationTest',formats:['iife'],fileName:()=> 'harness.js'}}});
const js=fs.readFileSync(path.join(out,'harness.js'),'utf8');
const css=fs.readFileSync(path.join(root,'web/src/app/globals.css'),'utf8').replace('@import "tailwindcss";','');
const browser=await chromium.launch({channel:process.env.PLAYWRIGHT_CHANNEL??(process.platform==='win32'?'msedge':undefined),headless:true});
const results=[];
try{
 for(const mode of ['filled','unfilled','blocked']){
  const context=await browser.newContext({viewport:{width:390,height:844}});
  const page=await context.newPage();const errors=[];const external=[];const counts={cmp:0,ads:0,ga:0};
  const cmpCorsAttributes=[];
  page.on('pageerror',error=>errors.push(error.message));
  await page.route('**/*',async route=>{
   const url=new URL(route.request().url());
   if(url.hostname==='quizeey.com')return route.fulfill({contentType:'text/html',body:`<!doctype html><html lang="ko"><head><meta charset="utf-8"><style>${css}</style><title>Synthetic test</title></head><body><div id="root"></div><script>${js}</script></body></html>`});
   if(url.hostname==='fundingchoicesmessages.google.com'){
    // The real CMP endpoint intentionally has no ACAO header. Route fulfillment
    // bypasses CORS and omits Sec-Fetch-Mode, so check the browser's script
    // element: a crossorigin attribute would require the missing ACAO header.
    cmpCorsAttributes.push(await page.locator('#quizeey-cmp').getAttribute('crossorigin'));
    counts.cmp++;return route.fulfill({contentType:'application/javascript',body:`window.__testConsent=undefined;window.__testUs=undefined;googlefc.getGoogleConsentModeValues=()=>window.__testConsent;googlefc.usstatesoptout.getInitialUsStatesOptOutStatus=()=>window.__testUs;window.__signal=()=>googlefc.callbackQueue.forEach(item=>Object.values(item).forEach(fn=>fn()));googlefc.showRevocationMessage=()=>{window.__revoked=true;};`});
   }
   if(url.hostname==='www.googletagmanager.com'){counts.ga++;return route.fulfill({contentType:'application/javascript',body:'window.__testGaLoaded=true;'});}
   if(url.hostname==='pagead2.googlesyndication.com'){
    counts.ads++;if(mode==='blocked')return route.abort();
    return route.fulfill({contentType:'application/javascript',body:`window.adsbygoogle={push:()=>{window.__adInitializations=(window.__adInitializations||0)+1;document.querySelector('ins.adsbygoogle').dataset.adStatus='${mode}';}};`});
   }
   external.push(url.origin);return route.abort();
  });
  await page.goto('https://quizeey.com/sqlp-developer');
  await page.waitForFunction(()=>typeof window.__signal==='function',{},{timeout:10000}).catch(error=>{throw new Error(JSON.stringify({failure:error.message,errors,counts}));});
  await expect(page.locator('.ad-placement')).toHaveCount(0);
  assert.deepEqual(counts,{cmp:1,ads:0,ga:0});
  assert.deepEqual(cmpCorsAttributes,[null],'CMP must load without requiring a CORS response header');
  await page.evaluate(()=>{window.__testUs=1;window.__testConsent={adStoragePurposeConsentStatus:2,adUserDataPurposeConsentStatus:2,adPersonalizationPurposeConsentStatus:2,analyticsStoragePurposeConsentStatus:2};window.__signal();});
  await expect(page.locator('.adsbygoogle')).toHaveCount(0);assert.equal(counts.ga,0);
  await page.evaluate(()=>{window.__testConsent={adStoragePurposeConsentStatus:1,adUserDataPurposeConsentStatus:1,adPersonalizationPurposeConsentStatus:1,analyticsStoragePurposeConsentStatus:1};window.__signal();});
  await page.waitForFunction(()=>window.__testGaLoaded===true);
  await page.evaluate(()=>window.scrollTo(0,document.body.scrollHeight));
  await expect.poll(()=>counts.ads).toBe(1);
  await expect(page.locator('#quizeey-adsense')).toHaveAttribute('data-overlays','collapsed-bottom');
  if(mode==='filled'){
   await page.waitForFunction(()=>window.__adInitializations===1);
   const bounds=await page.evaluate(()=>({ad:document.querySelector('.ad-placement').getBoundingClientRect().top,buttons:document.querySelector('.practice-controls').getBoundingClientRect().bottom,overflow:document.documentElement.scrollWidth>innerWidth}));
   assert.ok(bounds.ad-bounds.buttons>=48);assert.equal(bounds.overflow,false);
   await page.setViewportSize({width:1600,height:1000});
   const wide=await page.evaluate(()=>({ad:document.querySelector('.ad-placement').getBoundingClientRect().toJSON(),question:document.querySelector('.question-card').getBoundingClientRect().toJSON(),overflow:document.documentElement.scrollWidth>innerWidth}));
   assert.ok(wide.ad.left-wide.question.right>=48);assert.ok(wide.ad.right<=1600);assert.equal(wide.overflow,false);
   await page.setViewportSize({width:320,height:844});
  }else await expect(page.locator('.ad-placement')).toHaveCount(0);
  await page.locator('input[value="910000002"]').check();
  await page.getByRole('button',{name:'정답 확인',exact:true}).click();
  await expect(page.getByText('정답입니다.',{exact:true})).toBeVisible();
  await page.getByRole('button',{name:'다음',exact:true}).click();
  await expect(page.getByText('복수 선택',{exact:true})).toBeVisible();
  assert.equal(counts.ads,1);assert.equal(counts.ga,1);
  const events=await page.evaluate(()=>window.dataLayer.map(args=>Array.from(args)).filter(args=>args[0]==='event').map(args=>({name:args[1],payload:args[2]})));
  assert.equal(events.filter(event=>event.name==='page_view').length,1);
  assert.equal(events.filter(event=>event.name==='answer_submit').length,1);
  assert.ok(events.some(event=>event.name==='question_start'));
  assert.ok(events.every(event=>!JSON.stringify(event.payload).includes('Synthetic <CTRL>')));
  await page.evaluate(()=>{window.__testUs=3;window.__signal();});
  await expect(page.locator('.ad-placement')).toHaveCount(0);
  assert.deepEqual(external,[]);assert.deepEqual(errors,[]);
  results.push({mode,status:'passed',scriptRequests:counts,realNetworkRequests:0});
  console.log(JSON.stringify(results.at(-1)));
  await context.close();
 }
 fs.writeFileSync(path.join(root,'docs/modernization/monetization-browser-evidence.json'),JSON.stringify({checkedAt:new Date().toISOString(),scope:'Actual React components in isolated synthetic harness; mock CMP, GA4 and AdSense only. Does not certify account configuration or live ad delivery.',results},null,2)+'\n');
 console.log(JSON.stringify(results));
}finally{await browser.close();}
