import { spawn } from 'node:child_process';
import { randomBytes } from 'node:crypto';
import { fileURLToPath } from 'node:url';
import { join } from 'node:path';
import assert from 'node:assert/strict';
import { createServer } from 'node:net';

const root=fileURLToPath(new URL('../../',import.meta.url));
// Refuse an occupied port before creating a child; never test an unrelated server.
await new Promise((resolve,reject)=>{const probe=createServer();probe.once('error',reject);probe.listen(3101,'127.0.0.1',()=>probe.close(resolve));});
const password=randomBytes(24).toString('hex'); // Temporary test credential: never written or printed.
const username='검토'; // UTF-8 Basic credentials are supported by the proxy challenge.
const server=spawn(process.execPath,[join(root,'web/node_modules/next/dist/bin/next'),'start','--hostname','127.0.0.1','--port','3101'],{
  cwd:join(root,'web'),windowsHide:true,stdio:'ignore',
  env:{...process.env,VERCEL_ENV:'preview',QUIZEEY_ENV:'local',QUIZEEY_CONTENT_SOURCE:'fixture',QUIZEEY_PREVIEW_USER:username,QUIZEEY_PREVIEW_PASSWORD:password,QUIZEEY_LOCAL_FORUM_DATABASE_URL:'',QUIZEEY_ADMIN_AUTH_PROVIDER:''},
});
const origin='http://127.0.0.1:3101';
try {
  let ready=false;
  for(let attempt=0;attempt<40;attempt++) {
    if(server.exitCode!==null) throw new Error('Preview server exited before readiness');
    try {const response=await fetch(origin); if(response.status===401){ready=true;break;}} catch {}
    await new Promise(resolve=>setTimeout(resolve,250));
  }
  assert.equal(ready,true,'Preview did not start protected');
  const denied=await fetch(origin,{headers:{Authorization:'Basic '+Buffer.from(username+':wrong').toString('base64')}});
  assert.equal(denied.status,401);
  assert.match(denied.headers.get('www-authenticate'),/charset="UTF-8"/);
  const authorization='Basic '+Buffer.from(username+':'+password).toString('base64');
  const authorized=await fetch(origin+'/sqlp-developer',{headers:{Authorization:authorization}});
  assert.equal(authorized.status,200);
  assert.match(authorized.headers.get('x-robots-tag'),/noindex/);
  const html=await authorized.text();
  assert.match(html,/SELECT COUNT/);
  assert.match(html,/미리보기 · 샘플 문항/);
  assert.doesNotMatch(html,/googlesyndication|googletagmanager|disqus\.com|adsbygoogle/);
  assert.equal(html.includes(password),false,'Preview credential appeared in HTML');
  const english=await fetch(origin+'/en/aws-certified-developer-associate',{headers:{Authorization:authorization}});
  assert.equal(english.status,200);
  assert.match(await english.text(),/Preview · Sample questions/);
  const admin=await fetch(origin+'/api/admin/session',{headers:{Authorization:authorization}});
  assert.equal(admin.status,503);assert.equal(admin.headers.get('set-cookie'),null);
  console.log('PASS: protected UTF-8 preview 401/200, noindex, server-rendered question, no live integrations; hosted admin denied.');
} finally {
  if(server.exitCode===null) {
    const exited=new Promise(resolve=>server.once('exit',resolve));
    server.kill();await exited;
  }
}
