import { expect, test } from "@playwright/test";
import contract from "../fixtures/legacy-contract.json" with { type: "json" };
import staticPages from '../fixtures/legacy-pages.json' with {type:'json'};
import { staticPage,learningHtml } from '../src/lib/content';
import { findRoute } from '../src/lib/contracts';
import { homeSearchCopy } from '../src/lib/seo';
import { siteCopy } from '../src/lib/site-copy';

test('verified catalog redirects retain question and set identities',async({request})=>{
  for(const [source,target]of [['/microsoft-az-500','/az-500'],['/@ccna-300-115','/ccnp-300-115']]){
    const response=await request.get(source+'?questId=9007199254740993&verNbr=1',{maxRedirects:0});
    expect(response.status()).toBe(308);
    expect(new URL(response.headers().location,response.url()).pathname).toBe(target);
    expect(new URL(response.headers().location,response.url()).search).toBe('?questId=9007199254740993&verNbr=1');
    expect((await request.get(source)).status()).toBe(200);
  }
});
test('preview search directives stay blocked and original verification/ads assets survive',async({request})=>{
  const robots=await request.get('/robots.txt');expect(robots.status()).toBe(200);expect(await robots.text()).toContain('Disallow: /');expect(robots.headers()['x-robots-tag']).toContain('noindex');
  const sitemap=await request.get('/sitemap.xml');expect(sitemap.status()).toBe(200);expect(await sitemap.text()).not.toContain('<loc>');
  const ads=await request.get('/ads.txt');expect((await ads.text()).trim()).toBe('google.com, pub-8362228066874729, DIRECT, f08c47fec0942fa0');
  expect((await request.get('/naver90f2a35cffe6ae01fc8515f4efe88a59.html')).status()).toBe(200);
});

test('technical placeholders remain visible and active markup stays absent in the browser',async({page})=>{
  const requests:string[]=[];page.on('request',request=>requests.push(request.url()));
  await page.setContent('<main>'+learningHtml('<p>Press <CTRL>; List<T extends Number>, <AMI-ID>.</p><pre><code><T></T></code></pre><script>window.quizeeyUnsafe=true</script><iframe src="https://evil.test/"></iframe><img src="//evil.test/a" onerror="window.quizeeyUnsafe=true">')+'</main>');
  await expect(page.locator('main')).toContainText('Press <CTRL>; List<T extends Number>, <AMI-ID>.');
  await expect(page.locator('code')).toHaveText('<T></T>');
  await expect(page.locator('main script, main iframe, main [onerror]')).toHaveCount(0);
  expect(await page.evaluate(()=>Object.hasOwn(window,'quizeeyUnsafe'))).toBe(false);
  expect(requests).toEqual([]);
});

test("all discovered controller entry routes render with localized home titles and approved exam titles", async ({ request }) => {
  for (const route of contract.routes) {
    const url = route.path.endsWith('/test') ? `${route.path}?testId=${route.locale==='en'?'1':'5'}` : route.path;
    const response = await request.get(url);
    expect(response.status(),url).toBe(200);
    const title=['/','/kr','/app','/en'].includes(route.path)?homeSearchCopy[route.locale as 'ko'|'en'].title:
      route.path==='/en/az-900'?'Free AZ-900 Practice Questions with Answers | Azure Fundamentals - Quizeey':siteCopy[route.path as keyof typeof siteCopy]?.title ?? route.title;
    if (title && !route.path.endsWith('/test')) expect(await response.text(),url).toContain(`<title>${title.replaceAll('&','&amp;').replaceAll('<','&lt;').replaceAll('>','&gt;')}</title>`);
  }
});

test('localized about and privacy copy and internal exam links render on the server',async({page,request})=>{
  for(const path of [...new Set([...Object.keys(staticPages), ...Object.keys(siteCopy)])]){
    const response=await request.get(path);expect(response.status()).toBe(200);
    expect(await response.text()).toContain(staticPage(path)!.html);
  }
  await page.goto('/privacy');
  await expect(page.getByRole('heading',{name:'개인정보처리방침',exact:true})).toBeVisible();
  await expect(page.locator('.static-copy')).toContainText('학습 기록과 브라우저 저장');
  await expect(page.locator('.static-copy script, .static-copy ins, .static-copy form')).toHaveCount(0);
  await page.goto('/about');
  await expect(page.locator('.static-copy')).toContainText('무료 학습 사이트');
  await expect(page.locator('.static-copy a[href="/sqlp-developer"]')).toBeVisible();
  await page.goto('/en/about');
  await expect(page.locator('html')).toHaveAttribute('lang','en');
  await expect(page.locator('.static-copy')).toContainText('independent of exam providers');
});
test("legacy POST read contracts keep boolean wire names and stable IDs", async ({ request }) => {
  const response = await request.post('/question',{data:{testId:5,verNbr:0,questId:900000002}});
  expect(response.status()).toBe(200);
  const body = await response.json();
  expect(body).toMatchObject({questId:900000002,testId:5,multiAnswer:true});
  expect(body.examples.filter((c:{answer:boolean})=>c.answer).map((c:{exmpId:number})=>c.exmpId)).toEqual([910000004,910000005]);
  expect((await request.post('/question',{data:{testId:1,questId:900000002}})).status()).toBe(404);
  expect((await request.post('/question',{data:{testId:5,questId:'wrong'}})).status()).toBe(400);
  expect((await request.post('/question',{data:{testId:'5',verNbr:'',questId:'900000002'}})).status()).toBe(200);
  expect((await request.post('/question',{data:{testId:'5',verNbr:'1',questId:'900000002'}})).status()).toBe(200);
  expect((await (await request.post('/versions',{data:{testId:5}})).json()).map((v:{verNbr:number})=>v.verNbr).sort()).toEqual([1,2,202610]);
  const english = await (await request.post('/tests',{data:{languageCd:'en'}})).json();
  expect(english.every((exam:{url:string;testId:number})=>!exam.url.startsWith('/')&&findRoute('/en/'+exam.url)?.testId===String(exam.testId))).toBe(true);
  const korean=await (await request.post('/tests',{data:{languageCd:'kr'}})).json();
  expect(korean.find((exam:{testId:number})=>exam.testId===5).url).toBe('sqlp-developer');
  expect((await request.post('/tests',{data:{languageCd:'invalid'}})).status()).toBe(400);
  const deferred = await request.post('/explanations',{data:{questId:'900000002'}});
  expect(deferred.status()).toBe(200);
  expect(await deferred.json()).toEqual([]);
  expect((await request.post('/explanations',{data:{questId:'999999999'}})).status()).toBe(404);
  expect(await (await request.get('/ads.txt')).text()).toContain('pub-8362228066874729');
  expect((await request.get('/naver90f2a35cffe6ae01fc8515f4efe88a59.html')).status()).toBe(200);
});
