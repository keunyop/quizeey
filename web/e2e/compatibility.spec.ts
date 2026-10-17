import { expect, test } from "@playwright/test";
import contract from "../fixtures/legacy-contract.json" with { type: "json" };
import staticPages from '../fixtures/legacy-pages.json' with {type:'json'};
import { staticPage,learningHtml } from '../src/lib/content';

test('technical placeholders remain visible and active markup stays absent in the browser',async({page})=>{
  const requests:string[]=[];page.on('request',request=>requests.push(request.url()));
  await page.setContent('<main>'+learningHtml('<p>Press <CTRL>; List<T extends Number>, <AMI-ID>.</p><pre><code><T></T></code></pre><script>window.quizeeyUnsafe=true</script><iframe src="https://evil.test/"></iframe><img src="//evil.test/a" onerror="window.quizeeyUnsafe=true">')+'</main>');
  await expect(page.locator('main')).toContainText('Press <CTRL>; List<T extends Number>, <AMI-ID>.');
  await expect(page.locator('code')).toHaveText('<T></T>');
  await expect(page.locator('main script, main iframe, main [onerror]')).toHaveCount(0);
  expect(await page.evaluate(()=>Object.hasOwn(window,'quizeeyUnsafe'))).toBe(false);
  expect(requests).toEqual([]);
});

test("all discovered controller entry routes render and retain their original titles", async ({ request }) => {
  for (const route of contract.routes) {
    const url = route.path.endsWith('/test') ? `${route.path}?testId=${route.locale==='en'?'1':'5'}` : route.path;
    const response = await request.get(url);
    expect(response.status(),url).toBe(200);
    if (route.title && !route.path.endsWith('/test')) expect(await response.text(),url).toContain(`<title>${route.title.replaceAll('&','&amp;').replaceAll('<','&lt;').replaceAll('>','&gt;')}</title>`);
  }
});

test('static source copy, internal content and the existing local image survive server rendering',async({page,request})=>{
  for(const path of Object.keys(staticPages)){
    const response=await request.get(path);expect(response.status()).toBe(200);
    expect(await response.text()).toContain(staticPage(path)!.html);
  }
  await page.goto('/privacy');
  await expect(page.getByRole('heading',{name:'1. Owner and Data Controller',exact:true})).toBeVisible();
  await expect(page.locator('.static-copy')).toContainText('Changes to this privacy policy');
  await expect(page.locator('.static-copy script, .static-copy ins, .static-copy form')).toHaveCount(0);
  await page.goto('/about');
  const image=page.getByRole('img',{name:'AWS Certified Developer – Associate badge'});
  await expect(image).toBeVisible();expect(await image.evaluate((img)=>(img as HTMLImageElement).naturalWidth)).toBeGreaterThan(0);
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
  expect((await (await request.post('/versions',{data:{testId:5}})).json()).map((v:{verNbr:number})=>v.verNbr).sort()).toEqual([1,2]);
  const english = await (await request.post('/tests',{data:{languageCd:'en'}})).json();
  expect(english.every((exam:{url:string})=>!exam.url.startsWith('/')&&contract.routes.some((route)=>route.path==='/en/'+exam.url))).toBe(true);
  const korean=await (await request.post('/tests',{data:{languageCd:'kr'}})).json();
  expect(korean.find((exam:{testId:number})=>exam.testId===5).url).toBe('sqlp-developer');
  expect((await request.post('/tests',{data:{languageCd:'invalid'}})).status()).toBe(400);
  expect(await (await request.get('/ads.txt')).text()).toContain('pub-8362228066874729');
  expect((await request.get('/naver90f2a35cffe6ae01fc8515f4efe88a59.html')).status()).toBe(200);
});
