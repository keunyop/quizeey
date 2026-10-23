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
// Only this throwaway bundle substitutes the origin check. Production code has
// no test bypass, and browser navigation stays on loopback with every request mocked.
await build({root:path.join(root,'web'),configFile:false,publicDir:false,logLevel:'error',define:{'process.env.NODE_ENV':JSON.stringify('development'),'window.location.origin':JSON.stringify('https://quizeey.com')},resolve:{alias:{'@':path.join(root,'web/src')}},oxc:{jsx:{runtime:'automatic'}},build:{outDir:out,emptyOutDir:false,lib:{entry:path.join(root,'web/e2e/monetization-harness.tsx'),name:'MonetizationTest',formats:['iife'],fileName:()=> 'harness.js'}}});
const js=fs.readFileSync(path.join(out,'harness.js'),'utf8');
const css=fs.readFileSync(path.join(root,'web/src/app/globals.css'),'utf8').replace('@import "tailwindcss";','');
const browser=await chromium.launch({channel:process.env.PLAYWRIGHT_CHANNEL??(process.platform==='win32'?'msedge':undefined),headless:true});
const results=[];
try{
 for(const scenario of [
  {mode:'filled',path:'/sqlp-developer'},
  {mode:'unfilled',path:'/sqlp-developer'},
  {mode:'blocked',path:'/sqlp-developer'},
  {mode:'filled',path:'/'},
  {mode:'filled',path:'/?short'},
  {mode:'delayed',path:'/'},
 ]){
  const {mode}=scenario;const catalog=scenario.path.startsWith('/?')||scenario.path==='/';
  const context=await browser.newContext({viewport:{width:390,height:catalog?600:844},serviceWorkers:'block'});
  const page=await context.newPage();const errors=[];const external=[];const counts={cmp:0,ads:0,ga:0};
  let releaseAd;const adReady=new Promise(resolve=>{releaseAd=resolve;});
  const cmpCorsAttributes=[];
  page.on('pageerror',error=>errors.push(error.message));
  await page.route('**/*',async route=>{
   const url=new URL(route.request().url());
   if(url.origin==='http://127.0.0.1:3100'){
    if(url.pathname==='/fixtures/relation.svg')return route.fulfill({contentType:'image/svg+xml',body:fs.readFileSync(path.join(root,'web/public/fixtures/relation.svg'))});
    return route.fulfill({contentType:'text/html',body:`<!doctype html><html lang="ko"><head><meta charset="utf-8"><style>${css}</style><title>Synthetic test</title></head><body><div id="root"></div><script>${js}</script></body></html>`});
   }
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
    if(mode==='delayed')await adReady;
    return route.fulfill({contentType:'application/javascript',body:`window.__adScriptLoaded=true;window.adsbygoogle={push:()=>{window.__adInitializations=(window.__adInitializations||0)+1;document.querySelector('ins.adsbygoogle').dataset.adStatus='${mode==='delayed'?'filled':mode}';}};`});
   }
   external.push(url.origin);return route.abort();
  });
  await page.goto('http://127.0.0.1:3100'+scenario.path);
  await page.waitForFunction(()=>typeof window.__signal==='function',{},{timeout:10000}).catch(error=>{throw new Error(JSON.stringify({failure:error.message,errors,counts}));});
  await expect(page.locator('.ad-placement')).toHaveCount(0);
  assert.deepEqual(counts,{cmp:1,ads:0,ga:0});
  assert.deepEqual(cmpCorsAttributes,[null],'CMP must load without requiring a CORS response header');
  await page.evaluate(()=>{window.__testUs=1;window.__testConsent={adStoragePurposeConsentStatus:2,adUserDataPurposeConsentStatus:2,adPersonalizationPurposeConsentStatus:2,analyticsStoragePurposeConsentStatus:2};window.__signal();});
  await expect(page.locator('.adsbygoogle')).toHaveCount(0);assert.equal(counts.ga,0);
  if(catalog&&!scenario.path.includes('?short'))await page.getByRole('searchbox').fill('no-matching-exam');
  await page.evaluate(()=>{window.__testConsent={adStoragePurposeConsentStatus:1,adUserDataPurposeConsentStatus:1,adPersonalizationPurposeConsentStatus:1,analyticsStoragePurposeConsentStatus:1};window.__signal();});
  await page.waitForFunction(()=>window.__testGaLoaded===true);
  if(catalog){
   if(scenario.path.includes('?short')){
    await expect(page.locator('.exam-card')).toHaveCount(6);
    await expect(page.locator('.ad-placement')).toHaveCount(0);
    assert.equal(counts.ads,0,'Short catalogs never request an ad');
   }else{
    // The ad is initially below the fold: focused searching must not request it.
    await page.getByRole('searchbox').fill('no-matching-exam');
    await expect(page.locator('.exam-card')).toHaveCount(0);
    await expect(page.locator('.ad-placement')).toHaveCount(0);
    assert.equal(counts.ads,0);
    await page.getByRole('searchbox').fill('SQLD');
    await expect(page.locator('.exam-card')).toHaveCount(1);
    await expect(page.locator('.ad-placement')).toHaveCount(0);
    await page.getByRole('searchbox').fill('');
    await page.getByRole('button',{name:/^즐겨찾기/}).click();
    await expect(page.locator('.ad-placement')).toHaveCount(0);
    await page.getByRole('button',{name:'전체 시험',exact:true}).click();
    await page.locator('.category-filters button').nth(1).click();
    await expect(page.locator('.ad-placement')).toHaveCount(0);
    await page.locator('.category-filters button').first().click();
    await page.locator('.ad-placement').scrollIntoViewIfNeeded();
    await expect.poll(()=>counts.ads).toBe(1);
    if(mode!=='delayed')await page.waitForFunction(()=>window.__adInitializations===1);
    await expect(page.locator('#quizeey-adsense')).toHaveAttribute('data-overlays','collapsed-bottom');
    const bounds=await page.evaluate(()=>({ad:document.querySelector('.ad-placement').getBoundingClientRect().top,cards:document.querySelector('.exam-list').getBoundingClientRect().bottom}));
    assert.ok(bounds.ad-bounds.cards>=48);
    // Removing and restoring the catalog must not mint a new ad impression.
    await page.getByRole('searchbox').fill('SQLD');
    await expect(page.locator('.ad-placement')).toHaveCount(0);
    await page.getByRole('searchbox').fill('');
    await page.evaluate(()=>document.querySelector('.ad-placement')?.scrollIntoView());
    await expect(page.locator('.ad-placement')).toHaveCount(0);
    if(mode==='delayed'){releaseAd();await page.waitForFunction(()=>window.__adScriptLoaded===true);}
    assert.equal(await page.evaluate(()=>window.__adInitializations??0),mode==='delayed'?0:1);
    assert.equal(counts.ads,1);
   }
   assert.deepEqual(external,[]);assert.deepEqual(errors,[]);
   results.push({mode,path:scenario.path,documents:1,status:'passed',scriptRequests:counts,realNetworkRequests:0});
   console.log(JSON.stringify(results.at(-1)));await context.close();continue;
  }
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
  assert.equal(events.filter(event=>event.name==='practice_start').length,1);
  assert.ok(events.some(event=>event.name==='question_start'));
  assert.ok(events.every(event=>!JSON.stringify(event.payload).includes('Synthetic <CTRL>')));
  assert.ok(events.every(event=>event.payload.ad_policy==='balanced_v1'));
  // Reaching results with an unanswered question is not completion.
  await page.getByRole('button',{name:'건너뛰기',exact:true}).click();
  const eventCount=name=>page.evaluate(name=>window.dataLayer.map(args=>Array.from(args)).filter(args=>args[0]==='event'&&args[1]===name).length,name);
  await expect.poll(()=>eventCount('practice_result')).toBe(1);
  assert.equal(await eventCount('practice_complete'),0);
  await page.getByRole('button',{name:'다시 풀기',exact:true}).click();
  await page.locator('input[value="910000002"]').check();
  await page.getByRole('button',{name:'정답 확인',exact:true}).click();
  await page.getByRole('button',{name:'다음',exact:true}).click();
  await page.locator('input[value="910000004"]').check();
  await page.locator('input[value="910000005"]').check();
  await page.getByRole('button',{name:'정답 확인',exact:true}).click();
  await page.getByRole('button',{name:'다음',exact:true}).click();
  await expect.poll(()=>eventCount('practice_complete')).toBe(1);
  assert.equal(await eventCount('practice_start'),2);
  const completed=await page.evaluate(()=>window.dataLayer.map(args=>Array.from(args)).find(args=>args[1]==='practice_complete')[2]);
  assert.equal(completed.answered_count,2);assert.equal(completed.question_count,2);assert.equal(completed.practice_mode,'standard');
  assert.equal(counts.ads,1,'Restarting practice never refreshes an ad');
  await page.evaluate(()=>{window.__testUs=3;window.__signal();});
  await expect(page.locator('.ad-placement')).toHaveCount(0);
  await page.evaluate(()=>{window.__testUs=1;window.__signal();window.scrollTo(0,document.body.scrollHeight);});
  await expect(page.locator('.ad-placement')).toHaveCount(0);
  assert.equal(counts.ads,1,'Regranting consent must not refresh a placement');
  if(mode==='filled'){
   await page.reload();
   await page.waitForFunction(()=>typeof window.__signal==='function');
   await page.evaluate(()=>{window.__testUs=1;window.__testConsent={adStoragePurposeConsentStatus:1,adUserDataPurposeConsentStatus:1,adPersonalizationPurposeConsentStatus:1,analyticsStoragePurposeConsentStatus:1};window.__signal();});
   await page.waitForFunction(()=>window.__testGaLoaded===true);
   await expect.poll(()=>eventCount('practice_result')).toBe(1);
   assert.equal(await eventCount('practice_start'),0,'Restored results are not a new practice start');
   assert.equal(await eventCount('practice_complete'),0,'Restored results are not a new completion');
  }
  assert.deepEqual(external,[]);assert.deepEqual(errors,[]);
  results.push({mode,path:scenario.path,documents:mode==='filled'?2:1,status:'passed',scriptRequests:counts,realNetworkRequests:0});
  console.log(JSON.stringify(results.at(-1)));
  await context.close();
 }
 fs.writeFileSync(path.join(root,'docs/modernization/monetization-browser-evidence.json'),JSON.stringify({checkedAt:new Date().toISOString(),scope:'Actual React components in isolated synthetic harness; mock CMP, GA4 and AdSense only. Does not certify account configuration or live ad delivery.',results},null,2)+'\n');
 console.log(JSON.stringify(results));
}finally{await browser.close();}
