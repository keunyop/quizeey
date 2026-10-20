'use client';
import { useCallback,useEffect,useState } from 'react';
import type { Locale } from '@/lib/contracts';
import { adminMessages } from '@/lib/admin-messages';
import type { ModerationAction,QueueItem,QueueKind,QueueState } from '@/server/admin-database';
import { AdminDashboard } from './AdminDashboard';

export function AdminConsole({locale}:{locale:Locale}) {
  const m=adminMessages[locale];
  const [session,setSession]=useState<'loading'|'signed-out'|'signed-in'|'unavailable'>('loading');
  const [email,setEmail]=useState('');const [password,setPassword]=useState('');
  const [kind,setKind]=useState<QueueKind>('posts');const [state,setState]=useState<QueueState>('pending');
  const [items,setItems]=useState<QueueItem[]>([]);const [cursor,setCursor]=useState<string|null>(null);
  const [busy,setBusy]=useState(false);const [notice,setNotice]=useState('');const [revision,refresh]=useState(0);
  const expire=useCallback(()=>{setSession('signed-out');setItems([]);setCursor(null);},[]);
  useEffect(()=>{
    let active=true;
    fetch('/api/admin/session',{cache:'no-store'}).then((r)=>{if(active)setSession(r.ok?'signed-in':r.status===503?'unavailable':'signed-out');}).catch(()=>{if(active)setSession('unavailable');});
    return ()=>{active=false;};
  },[]);
  useEffect(()=>{
    if(session!=='signed-in')return;
    let active=true;
    fetch('/api/admin/queue?'+new URLSearchParams({kind,state}),{cache:'no-store'}).then(async(r)=>{
      if(r.status===401||r.status===403){if(active){setSession('signed-out');setItems([]);setCursor(null);}return;}
      if(!r.ok)throw new Error();
      const data=await r.json();if(active){setItems(data.items);setCursor(data.nextCursor);}
    }).catch(()=>{if(active)setNotice(m.error);});
    return ()=>{active=false;};
  },[session,kind,state,revision,m.error]);

  async function login(event:React.FormEvent) {
    event.preventDefault();setBusy(true);setNotice('');
    try {
      const r=await fetch('/api/admin/login',{method:'POST',headers:{'Content-Type':'application/json'},body:JSON.stringify(email.includes('@')?{email,password}:{username:email,password})});await r.json();
      setPassword('');if(r.ok)setSession('signed-in');else setNotice(r.status===503?m.unavailable:m.denied);
    }catch{setNotice(m.error);}finally{setBusy(false);}
  }
  async function act(action:ModerationAction,id:string) {
    if(action==='delete'&&!window.confirm(m.confirm))return;
    setBusy(true);setNotice('');
    try {
      const r=await fetch('/api/admin/moderate',{method:'POST',headers:{'Content-Type':'application/json','Idempotency-Key':crypto.randomUUID()},body:JSON.stringify({action,id})});await r.json();
      if(r.status===401||r.status===403){setSession('signed-out');setItems([]);setNotice(m.denied);}
      else {setNotice(r.ok?m.saved:r.status===409?m.stale:m.error);refresh((v)=>v+1);}
    }catch{setNotice(m.error);}finally{setBusy(false);}
  }
  async function more() {
    if(!cursor)return;setBusy(true);
    try{const r=await fetch('/api/admin/queue?'+new URLSearchParams({kind,state,cursor}),{cache:'no-store'});if(r.status===401||r.status===403){setSession('signed-out');setItems([]);setCursor(null);setNotice(m.denied);return;}if(!r.ok)throw new Error();const data=await r.json();setItems((old)=>[...old,...data.items]);setCursor(data.nextCursor);}
    catch{setNotice(m.error);}finally{setBusy(false);}
  }
  async function logout() {
    setBusy(true);setNotice('');
    try {const response=await fetch('/api/admin/logout',{method:'POST'});if(!response.ok)throw new Error();setSession('signed-out');setItems([]);setCursor(null);setPassword('');}
    catch {setNotice(m.error);}finally {setBusy(false);}
  }
  return <main className='container admin-console'>
    <a href={locale==='en'?'/en':'/'}>{m.home}</a><h1>{m.title}</h1>
    {session==='unavailable'&&<p role='status'>{m.unavailable}</p>}
    {session==='signed-out'&&<form className='forum-form' onSubmit={login}>
      <label htmlFor='admin-email'>{m.email}</label><input id='admin-email' name='username' type='text' autoComplete='username' required value={email} onChange={(e)=>setEmail(e.target.value)}/>
      <label htmlFor='admin-password'>{m.password}</label><input id='admin-password' name='password' type='password' autoComplete='current-password' required value={password} onChange={(e)=>setPassword(e.target.value)}/>
      <button className='primary' disabled={busy}>{busy?m.busy:m.signIn}</button>
    </form>}
    {session==='signed-in'&&<>
      <div className='actions'>
        <button disabled={busy} onClick={logout}>{m.signOut}</button>
        <button onClick={()=>refresh((v)=>v+1)}>{m.refresh}</button>
      </div>
      <AdminDashboard locale={locale} revision={revision} onExpired={expire}/>
      <h2>{locale==='ko'?'댓글 관리':'Comment moderation'}</h2>
      <div className='actions' aria-label={locale==='en'?'Review queues':'검토 목록'}>{(['posts','revisions','reports'] as const).map((k)=><button key={k} aria-pressed={kind===k} onClick={()=>{setKind(k);setItems([]);setCursor(null);}}>{m[k]}</button>)}</div>
      {kind==='posts'&&<div className='actions'>{(['pending','approved','hidden'] as const).map((s)=><button key={s} aria-pressed={state===s} onClick={()=>{setState(s);setItems([]);setCursor(null);}}>{m[s]}</button>)}</div>}
      {!items.length&&<p>{m.empty}</p>}
      {items.map((item)=><article className='review-item panel' key={item.id}>
        <h2>{item.title}</h2><p className='small muted'>{item.display_name||m.anonymous}</p>
        {item.reason&&<p className='forum-body'>{item.reason}</p>}
        {item.published_body&&<details><summary>{m.published}</summary><p className='forum-body'>{item.published_body}</p></details>}
        <p className='forum-body'>{item.body}</p>
        <div className='actions'>
          {kind==='posts'&&<>
            {item.visibility!=='approved'&&<button disabled={busy} onClick={()=>act('approve',item.id)}>{m.approve}</button>}
            {item.visibility!=='hidden'&&<button disabled={busy} onClick={()=>act('hide',item.id)}>{m.hide}</button>}
            <button disabled={busy} onClick={()=>act('delete',item.id)}>{m.delete}</button>
            <button disabled={busy} onClick={()=>act(item.locked?'unlock':'lock',item.topic_id)}>{item.locked?m.unlock:m.lock}</button>
          </>}
          {kind==='revisions'&&<><button disabled={busy} onClick={()=>act('approve_revision',item.id)}>{m.approve_revision}</button><button disabled={busy} onClick={()=>act('reject_revision',item.id)}>{m.reject_revision}</button></>}
          {kind==='reports'&&<><button disabled={busy} onClick={()=>act('hide',item.post_id!)}>{m.hide}</button><button disabled={busy} onClick={()=>act('resolve_report',item.id)}>{m.resolve_report}</button></>}
        </div>
      </article>)}
      {cursor&&<button disabled={busy} onClick={more}>{m.more}</button>}
    </>}
    <p role='status'>{notice}</p>
  </main>;
}
