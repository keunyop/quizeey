import { createClient } from "@supabase/supabase-js";
import { z } from "zod";
import { environment } from "@/lib/environment";
import { verifiedAdminAllowed } from "./guest-policy";
import { activeAdminSession } from './admin-session';

export const adminCookieName = "__Host-quizeey-admin";
export const adminCookieOptions = { httpOnly: true, secure: true, sameSite: "strict", path: "/" } as const;
export class AdminAuthError extends Error {
  constructor(readonly status: 401 | 403 | 503) { super("Admin authentication unavailable or denied"); }
}
export function adminConfiguration(input: Record<string,string|undefined> = process.env) {
  const stage=environment(input).stage;
  const provider=input.QUIZEEY_ADMIN_AUTH_PROVIDER;
  if (!provider) return null;
  const ids=z.array(z.uuid()).min(1).safeParse(input.QUIZEEY_ADMIN_USER_IDS?.split(",").map((id)=>id.trim()));
  if (!ids.success) throw new AdminAuthError(503);
  if (provider==='fixture') {
    if (stage!=='local' || input.VERCEL_ENV || input.QUIZEEY_LOCAL_FORUM_DATABASE_URL!=='postgresql://quizeey_server@127.0.0.1:55432/quizeey_fixture' || input.QUIZEEY_AUTH_FIXTURE_URL!=='http://127.0.0.1:55433') throw new AdminAuthError(503);
    return {url:input.QUIZEEY_AUTH_FIXTURE_URL,key:'local-fixture-publishable',ids:ids.data};
  }
  if (provider!=='supabase' || input.QUIZEEY_SUPABASE_URL!=='https://tfkhnrbshvyfmrzxqfmq.supabase.co') throw new AdminAuthError(503);
  const key=input.QUIZEEY_SUPABASE_PUBLISHABLE_KEY;
  if (!key || key.startsWith('sb_secret_')) throw new AdminAuthError(503);
  if (!key.startsWith('sb_publishable_')) {
    try { if (JSON.parse(Buffer.from(key.split('.')[1],'base64url').toString('utf8')).role!=='anon') throw new Error(); }
    catch { throw new AdminAuthError(503); }
  }
  return {url:input.QUIZEEY_SUPABASE_URL,key,ids:ids.data};
}
function client() {
  const config=adminConfiguration();
  if (!config) throw new AdminAuthError(503);
  // A fresh client per operation; never share a user session between server requests.
  return {config,supabase:createClient(config.url,config.key,{auth:{persistSession:false,autoRefreshToken:false,detectSessionInUrl:false},global:{fetch:(url,options)=>fetch(url,{...options,cache:'no-store',signal:AbortSignal.timeout(5000)})}})};
}
export function readAdminToken(request: Request) {
  const cookies=(request.headers.get('cookie')??'').split(';').map((v)=>v.trim()).filter((v)=>v.startsWith(adminCookieName+'='));
  if (cookies.length!==1) return undefined;
  const token=cookies[0].slice(adminCookieName.length+1);
  return token.length<=8192 && /^[A-Za-z0-9_.-]+$/.test(token) ? token : undefined;
}
export async function verifyAdminToken(token: string) {
  const {config,supabase}=client();
  const {data,error}=await supabase.auth.getUser(token);
  if (error || !data.user) throw new AdminAuthError(401);
  if (data.user.is_anonymous || !verifiedAdminAllowed(data.user.id,config.ids)) throw new AdminAuthError(403);
  return {id:data.user.id};
}
export async function requireAdmin(request: Request) {
  const token=readAdminToken(request);
  if (!token) throw new AdminAuthError(401);
  const actor=await activeAdminSession(token);
  if(!actor)throw new AdminAuthError(401);
  const user=await verifyAdminToken(token);
  if(user.id!==actor)throw new AdminAuthError(403);
  return user;
}
export async function signInAdmin(email: string,password: string) {
  const {supabase}=client();
  const {data,error}=await supabase.auth.signInWithPassword({email,password});
  if (error || !data.session || !data.user) throw new AdminAuthError(401);
  const user=await verifyAdminToken(data.session.access_token);
  if (user.id!==data.user.id) throw new AdminAuthError(401);
  return {id:user.id,token:data.session.access_token,maxAge:Math.max(1,Math.min(3600,(data.session.expires_at??0)-Math.floor(Date.now()/1000)))};
}
export async function signOutAdmin(token: string) {
  const {supabase}=client();
  await supabase.auth.admin.signOut(token,'local');
}
