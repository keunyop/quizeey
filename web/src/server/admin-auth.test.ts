import { afterEach,expect,it,vi } from 'vitest';
import { adminConfiguration,adminCookieName,AdminAuthError,readAdminToken,verifyAdminToken } from './admin-auth';
const id='00000000-0000-4000-8000-000000000101';
const local={QUIZEEY_ENV:'local',QUIZEEY_ADMIN_AUTH_PROVIDER:'fixture',QUIZEEY_LOCAL_FORUM_DATABASE_URL:'postgresql://quizeey_server@127.0.0.1:55432/quizeey_fixture',QUIZEEY_AUTH_FIXTURE_URL:'http://127.0.0.1:55433',QUIZEEY_ADMIN_USER_IDS:id};
afterEach(()=>{vi.unstubAllEnvs();vi.unstubAllGlobals();});
it('defaults to disabled and permits a fixture only on the exact isolated local targets',()=>{
  expect(adminConfiguration({})).toBeNull();expect(adminConfiguration(local)?.ids).toEqual([id]);
  for(const change of [{VERCEL_ENV:'development'},{QUIZEEY_ENV:'preview',QUIZEEY_PREVIEW_USER:'a',QUIZEEY_PREVIEW_PASSWORD:'x'.repeat(24)},{QUIZEEY_AUTH_FIXTURE_URL:'http://localhost:55433'},{QUIZEEY_LOCAL_FORUM_DATABASE_URL:'postgresql://localhost/existing'},{QUIZEEY_ADMIN_USER_IDS:''}])expect(()=>adminConfiguration({...local,...change})).toThrow();
});
it('binds real Auth to the identified Quizeey project and rejects privileged keys',()=>{
  const supabase={QUIZEEY_ADMIN_AUTH_PROVIDER:'supabase',QUIZEEY_SUPABASE_URL:'https://tfkhnrbshvyfmrzxqfmq.supabase.co',QUIZEEY_SUPABASE_PUBLISHABLE_KEY:'sb_publishable_fixture',QUIZEEY_ADMIN_USER_IDS:id};
  expect(adminConfiguration(supabase)?.url).toBe(supabase.QUIZEEY_SUPABASE_URL);
  expect(()=>adminConfiguration({...supabase,QUIZEEY_SUPABASE_URL:'https://other.supabase.co'})).toThrow(AdminAuthError);
  for(const key of ['sb_secret_forbidden','wrong','x.'+Buffer.from(JSON.stringify({role:'service_role'})).toString('base64url')+'.y'])expect(()=>adminConfiguration({...supabase,QUIZEEY_SUPABASE_PUBLISHABLE_KEY:key})).toThrow(AdminAuthError);
});
it('rejects absent, duplicate and malformed session cookies',()=>{
  for(const cookie of ['',`${adminCookieName}=a; ${adminCookieName}=b`,`${adminCookieName}=a%0d`,`${adminCookieName}=${'a'.repeat(8193)}`])expect(readAdminToken(new Request('https://quizeey.com',{headers:{cookie}}))).toBeUndefined();
  expect(readAdminToken(new Request('https://quizeey.com',{headers:{cookie:`other=x; ${adminCookieName}=a.b.c`}}))).toBe('a.b.c');
});
it('checks the provider on every request and denies metadata roles, anonymous users and revoked tokens',async()=>{
  for(const [key,value] of Object.entries(local))vi.stubEnv(key,value);
  vi.stubEnv('VERCEL_ENV',undefined);
  const provider=vi.fn().mockImplementation(async()=>new Response(JSON.stringify({id,role:'authenticated',is_anonymous:false,user_metadata:{role:'admin'}}),{headers:{'Content-Type':'application/json'}}));
  vi.stubGlobal('fetch',provider);
  expect(await verifyAdminToken('a.b.c')).toEqual({id});expect(await verifyAdminToken('a.b.c')).toEqual({id});expect(provider).toHaveBeenCalledTimes(2);
  expect(provider.mock.calls[0][0]).toBe('http://127.0.0.1:55433/auth/v1/user');
  expect(provider.mock.calls[0][1]).toMatchObject({cache:'no-store'});
  for(const user of [{id:'00000000-0000-4000-8000-000000000102',user_metadata:{role:'admin'}},{id,is_anonymous:true}]){
    provider.mockResolvedValueOnce(new Response(JSON.stringify(user),{headers:{'Content-Type':'application/json'}}));
    await expect(verifyAdminToken('a.b.c')).rejects.toMatchObject({status:403});
  }
  provider.mockResolvedValueOnce(new Response(JSON.stringify({message:'Invalid token'}),{status:401,headers:{'Content-Type':'application/json'}}));
  await expect(verifyAdminToken('a.b.c')).rejects.toMatchObject({status:401});
});
