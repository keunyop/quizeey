import { expect,test,type APIRequestContext } from '@playwright/test';
import AxeBuilder from '@axe-core/playwright';
import pg from 'pg';

test.skip(process.env.QUIZEEY_AUTH_FIXTURE_URL!=='http://127.0.0.1:55433' || process.env.QUIZEEY_LOCAL_FORUM_DATABASE_URL!=='postgresql://quizeey_server@127.0.0.1:55432/quizeey_fixture','Explicit isolated DB and Auth doubles required');
const origin='http://127.0.0.1:3100';
async function fixture(query:string,values:unknown[]=[]){
  if(process.env.VERCEL_ENV || process.env.QUIZEEY_LOCAL_FORUM_DATABASE_URL!=='postgresql://quizeey_server@127.0.0.1:55432/quizeey_fixture')throw new Error('Isolated fixture only');
  const client=new pg.Client({connectionString:'postgresql://quizeey_fixture@127.0.0.1:55432/quizeey_fixture'});await client.connect();
  try{return await client.query(query,values);}finally{await client.end();}
}
async function post(request:APIRequestContext,path:string,data:Record<string,unknown>,key=crypto.randomUUID()){
  return request.post(origin+path,{headers:{Origin:origin,'Idempotency-Key':key},data});
}
test('verified admin session, pending review, revisions, reports, locking, audit and logout',async({browser,request})=>{
  test.setTimeout(90000);
  const guest=await browser.newContext();const admin=await browser.newContext();
  let topicId:string|undefined;let pageTopic:string|undefined;
  try{
    const countsBefore=(await (await request.get('http://127.0.0.1:55433/_fixture')).json()).counts;
    const visitor=await guest.newPage();await visitor.goto(origin+'/sqlp-developer');
    const created=await post(guest.request,'/api/forum',{action:'create',examId:'5',locale:'ko',title:'Authenticated moderator journey',body:'Original guest body'});
    expect(created.status()).toBe(202);const {postId,topicId:tid}=await created.json();topicId=tid;
    await fixture("update public.quizeey_posts set visibility='pending' where id=$1",[postId]);
    await fixture("update public.quizeey_topics set visibility='pending',approved_post_count=0 where id=$1",[tid]);
    expect((await (await request.get('http://127.0.0.1:55433/_fixture')).json()).counts).toEqual(countsBefore);
    expect((await guest.request.get(origin+'/api/admin/queue')).status()).toBe(401);
    expect((await post(guest.request,'/api/admin/moderate',{action:'approve',id:postId})).status()).toBe(401);
    expect((await guest.request.post(origin+'/api/admin/login',{headers:{Origin:'https://evil.invalid'},data:{email:'admin@quizeey.invalid',password:'fixture-password-only'}})).status()).toBe(403);
    expect((await post(guest.request,'/api/admin/login',{email:'admin@quizeey.invalid',password:'incorrect-fixture'})).status()).toBe(401);
    const ordinary=await post(guest.request,'/api/admin/login',{email:'ordinary@quizeey.invalid',password:'fixture-password-only'});
    expect(ordinary.status()).toBe(403);expect(ordinary.headers()['set-cookie']).toBeUndefined();
    const page=await admin.newPage();await page.goto(origin+'/en/admin');
    await page.getByLabel('ID or email',{exact:true}).fill('admin@quizeey.invalid');
    await page.getByLabel('Password',{exact:true}).fill('fixture-password-only');
    const loginResponse=page.waitForResponse((r)=>r.url().endsWith('/api/admin/login'));
    await page.getByRole('button',{name:'Sign in',exact:true}).click();
    const loggedIn=await loginResponse;expect(loggedIn.status()).toBe(200);expect(await loggedIn.json()).toEqual({authenticated:true});
    const cookie=(await admin.cookies()).find((c)=>c.name==='__Host-quizeey-admin')!;
    expect(cookie).toMatchObject({secure:true,httpOnly:true,sameSite:'Strict',path:'/'});
    expect(await page.evaluate(()=>document.cookie)).not.toContain('__Host-quizeey-admin');
    const article=page.locator('.review-item').filter({has:page.getByRole('heading',{name:'Authenticated moderator journey',exact:true})});
    await expect(article).toContainText('Original guest body');
    const queue=await admin.request.get(origin+'/api/admin/queue');
    expect(queue.headers()['cache-control']).toContain('no-store');expect(queue.headers()['x-robots-tag']).toContain('noindex');
    expect(await queue.text()).not.toMatch(/capability|verification_hash|access_token|abuse_hash|@quizeey/);
    expect((await admin.request.get(origin+'/api/admin/queue?cursor=bad')).status()).toBe(400);
    expect((await post(admin.request,'/api/admin/moderate',{action:'approve',id:postId,actorId:'00000000-0000-4000-8000-000000000102'})).status()).toBe(400);
    expect((await admin.request.post(origin+'/api/admin/moderate',{headers:{Origin:'https://evil.invalid'},data:{action:'approve',id:postId}})).status()).toBe(403);
    await article.getByRole('button',{name:'Approve',exact:true}).click();await expect(article).toHaveCount(0);
    const publicRead=()=>guest.request.get(origin+'/api/forum?testId=5&locale=ko');
    expect(await (await publicRead()).text()).toContain('Original guest body');
    await fixture("insert into quizeey_private.post_revisions(post_id,body) values($1,'Reviewed guest revision')",[postId]);
    expect(await (await publicRead()).text()).not.toContain('Reviewed guest revision');
    await page.getByRole('button',{name:'Revisions',exact:true}).click();await expect(article).toContainText('Reviewed guest revision');
    await article.getByRole('button',{name:'Approve revision',exact:true}).click();await expect(article).toHaveCount(0);
    expect(await (await publicRead()).text()).toContain('Reviewed guest revision');
    expect((await post(guest.request,'/api/forum',{action:'report',postId,reason:'Moderator report fixture'})).status()).toBe(202);
    await page.getByRole('button',{name:'Reports',exact:true}).click();await expect(article).toContainText('Moderator report fixture');
    await article.getByRole('button',{name:'Hide',exact:true}).click();await expect(article.getByRole('button',{name:'Resolve report',exact:true})).toBeEnabled();
    await expect.poll(async()=>await (await publicRead()).text()).not.toContain('Reviewed guest revision');
    await article.getByRole('button',{name:'Resolve report',exact:true}).click();await expect(article).toHaveCount(0);
    await page.getByRole('button',{name:'Posts',exact:true}).click();await page.getByRole('button',{name:'Hidden',exact:true}).click();
    await article.getByRole('button',{name:'Approve',exact:true}).click();await expect(article).toHaveCount(0);
    await page.getByRole('button',{name:'Published',exact:true}).click();await expect(article).toBeVisible();
    await article.getByRole('button',{name:'Lock replies',exact:true}).click();await expect(article.getByRole('button',{name:'Unlock replies',exact:true})).toBeVisible();
    expect((await post(guest.request,'/api/forum',{action:'reply',topicId:tid,parentId:postId,body:'Locked reply'})).status()).toBe(403);
    await article.getByRole('button',{name:'Unlock replies',exact:true}).click();await expect(article.getByRole('button',{name:'Lock replies',exact:true})).toBeVisible();
    const key=crypto.randomUUID();const hide={action:'hide',id:postId};
    expect((await post(admin.request,'/api/admin/moderate',hide,key)).status()).toBe(200);
    expect((await post(admin.request,'/api/admin/moderate',hide,key)).status()).toBe(200);
    expect((await post(admin.request,'/api/admin/moderate',{action:'approve',id:postId},key)).status()).toBe(409);
    const audit=await fixture('select actor_id,action,count(*)::int as count from quizeey_private.moderation_audit where request_id=$1 group by actor_id,action',[key]);
    expect(audit.rows).toEqual([{actor_id:'00000000-0000-4000-8000-000000000101',action:'hide',count:1}]);
    // A bounded keyset page with many pending posts, independent of browser ordering.
    pageTopic=(await fixture("insert into public.quizeey_topics(exam_id,locale,title) values('5','ko','Pagination fixture') returning id")).rows[0].id;
    await fixture("insert into public.quizeey_posts(topic_id,body) select $1,'Pagination fixture '||n from generate_series(1,25) n",[pageTopic]);
    const first=await (await admin.request.get(origin+'/api/admin/queue')).json();expect(first.items).toHaveLength(20);expect(first.nextCursor).toBeTruthy();
    const second=await (await admin.request.get(origin+'/api/admin/queue?cursor='+first.nextCursor)).json();expect(second.items.length).toBeGreaterThan(0);
    const ids=new Set(first.items.map((v:{id:string})=>v.id));expect(second.items.some((v:{id:string})=>ids.has(v.id))).toBe(false);
    expect((await new AxeBuilder({page}).analyze()).violations).toEqual([]);
    expect((await post(admin.request,'/api/admin/moderate',{action:'delete',id:postId})).status()).toBe(200);
    await page.getByRole('button',{name:'Sign out',exact:true}).click();await expect(page.getByLabel('Password',{exact:true})).toBeVisible();
    expect((await admin.cookies()).some((c)=>c.name==='__Host-quizeey-admin')).toBe(false);
    expect((await admin.request.get(origin+'/api/admin/queue')).status()).toBe(401);
    // Provider still accepts the JWT; only Quizeey's shared private revocation denies it.
    expect((await request.get('http://127.0.0.1:55433/auth/v1/user',{headers:{apikey:'local-fixture-publishable',Authorization:'Bearer '+cookie.value}})).status()).toBe(200);
    expect((await request.get(origin+'/api/admin/queue',{headers:{Cookie:'__Host-quizeey-admin='+cookie.value}})).status()).toBe(401);
  }finally{
    await guest.close();await admin.close();
    const topics=[topicId,pageTopic].filter(Boolean);
    try {
      for(const table of ['quizeey_private.post_owners','quizeey_private.post_revisions','quizeey_private.forum_reports'])await fixture('delete from '+table+' where post_id in (select id from public.quizeey_posts where topic_id=any($1::uuid[]))',[topics]);
      await fixture('delete from public.quizeey_posts where topic_id=any($1::uuid[])',[topics]);
      await fixture('delete from public.quizeey_topics where id=any($1::uuid[])',[topics]);
    }finally {await fixture("delete from quizeey_private.rate_windows where bucket like 'abuse:%' or bucket like 'admin-login:%'");}
  }
});
