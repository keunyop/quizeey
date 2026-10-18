// Public production browser verification; no mocked app data or DNS overrides.
import fs from 'node:fs';
import path from 'node:path';
import assert from 'node:assert/strict';
import {fileURLToPath} from 'node:url';
import {chromium,expect} from '../../web/node_modules/@playwright/test/index.mjs';
const root=fileURLToPath(new URL('../../',import.meta.url));
const out=path.join(root,'.modernization/live-cutover-browser');fs.mkdirSync(out,{recursive:true});
const checks=[],errors=[],failures=[],google=[];
const browser=await chromium.launch({channel:'msedge',headless:true});
let context;
try{
 context=await browser.newContext({viewport:{width:1365,height:900},locale:'ko-KR'});
 const page=await context.newPage();
 page.on('pageerror',error=>errors.push(error.message.slice(0,240)));
 page.on('requestfailed',r=>failures.push({host:new URL(r.url()).hostname,error:r.failure()?.errorText}));
 page.on('response',r=>{const u=new URL(r.url());if(/google|doubleclick/.test(u.hostname))google.push({host:u.hostname,path:u.pathname,status:r.status()});});
 let response=await page.goto('https://quizeey.com/',{waitUntil:'domcontentloaded',timeout:30000});
 assert.equal(response.status(),200);await expect(page.locator('link[rel="canonical"]')).toHaveAttribute('href','https://quizeey.com/');
 checks.push('Public home and canonical');
 await page.screenshot({path:path.join(out,'desktop-home.png')});
 await page.goto('https://quizeey.com/industrial-engineer-electric-work',{waitUntil:'domcontentloaded'});
 await expect(page.locator('#question-content')).toBeVisible();
 await expect(page.locator('.choice input')).not.toHaveCount(0);
 const initial=await page.locator('#question-content').textContent();
 await page.locator('.choice input').first().check();
 await page.getByRole('button',{name:'정답 확인',exact:true}).click();
 await expect(page.locator('.answer-feedback')).toBeVisible();checks.push('Real question selection and grading');
 await page.reload({waitUntil:'domcontentloaded'});await expect(page.locator('.answer-feedback')).toBeVisible();
 assert.equal(await page.locator('#question-content').textContent(),initial);checks.push('Browser progress restored after refresh');
 await page.getByRole('button',{name:'다음',exact:true}).click();
 await expect.poll(()=>page.locator('#question-content').textContent()).not.toBe(initial);checks.push('Next question');
 assert.equal(await page.locator('.forum').count(),0);checks.push('Deferred forum hidden');
 await page.setViewportSize({width:390,height:844});
 await expect(page.locator('#question-content')).toBeVisible();
 assert.equal(await page.evaluate(()=>document.documentElement.scrollWidth>window.innerWidth),false);checks.push('390px layout without horizontal overflow');
 await page.screenshot({path:path.join(out,'mobile-practice.png')});
 await page.waitForTimeout(4000);
 const consent=await page.evaluate(()=>({available:typeof window.googlefc?.getGoogleConsentModeValues==='function',values:window.googlefc?.getGoogleConsentModeValues?.(),hasGa:typeof window.gtag==='function',gaLoader:!!document.querySelector('script[src*="googletagmanager.com/gtag/js"]'),adsLoader:!!document.querySelector('script[src*="pagead2.googlesyndication.com/pagead/js/adsbygoogle.js"]')}));
 const report={checkedAt:new Date().toISOString(),status:errors.length?'needs-attention':'passed',scope:'Actual public DNS and unmodified production pages in a fresh Edge browser; actual data and scripts, no application mocks, DNS overrides or ad clicks. Screenshots remain ignored locally. Google network failures are recorded separately from app flow.',checks,browserErrors:errors,networkFailures:failures,googleResponses:google,consent};
 fs.writeFileSync(path.join(root,'docs/modernization/live-browser-evidence.json'),JSON.stringify(report,null,2)+'\n');console.log(JSON.stringify(report));
 if(report.status!=='passed')process.exitCode=1;
}catch(error){const report={checkedAt:new Date().toISOString(),status:'needs-attention',error:error.message.slice(0,400),checks,browserErrors:errors,networkFailures:failures,googleResponses:google};fs.writeFileSync(path.join(root,'docs/modernization/live-browser-evidence.json'),JSON.stringify(report,null,2)+'\n');console.log(JSON.stringify(report));process.exitCode=1;}
finally{if(context)await context.close();await browser.close();}
