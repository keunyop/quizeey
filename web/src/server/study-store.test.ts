import { describe,it,expect } from 'vitest';
import fs from 'node:fs';
import os from 'node:os';
import path from 'node:path';
import { createHash } from 'node:crypto';
import { coreStudyStore,loadLocalStudyStore,type CorePayload } from './study-store';
import { environment } from '@/lib/environment';

function fixture():CorePayload{
  const questions=Array.from({length:25},(_,i)=>({question_id:String(9007199254740993n+BigInt(i)),version_id:i<23?'11':'12',number:i+1,body:'Synthetic <CTRL>',explanation:null,reference:i?'':null,multiple_answers:false}));
  return {schema:1,tables:{
    exams:[{exam_id:'5',name_ko:'Synthetic',name_en:null,legacy_slug:'sqlp-developer',priority:1}],
    versions:[{version_id:'11',exam_id:'5',number:1,name:'First'},{version_id:'12',exam_id:'5',number:2,name:'Second'}],
    questions,choices:questions.flatMap((q,i)=>[0,1].map(n=>({choice_id:String(10000000000000000n+BigInt(i*2+n)),question_id:q.question_id,number:n+1,body:'Synthetic choice',correct:n===0}))),
    legacy_counters:[{question_id:questions[0].question_id,correct:9,incorrect:3}]
  },pendingExplanationCounts:{[questions[0].question_id]:2}};
}
describe('verified private study reader',()=>{
  it('resolves direct IDs before the 20-item limit and retains all versions and bigint strings',()=>{
    const data=fixture();const store=coreStudyStore(data,'hash');const last=data.tables.questions[22];
    expect(store.questions('5','ko',1)).toHaveLength(20);
    expect(store.questions('5','ko',1,last.question_id)[0]).toMatchObject({id:last.question_id,questionNumber:23,reference:'',explanation:null});
    expect(store.versions('5','ko').map(v=>v.id).sort()).toEqual(['11','12']);
    expect(store.questions('5','ko',2,last.question_id)).toEqual([]);
    expect(store.questions('1','ko',1,last.question_id)).toEqual([]);
    expect(store.questions('5','ko',0,'999')).toEqual([]);
    expect(store.counter(data.tables.questions[0].question_id)).toEqual({correct:9,inCorrect:3});
    expect(store.pendingExplanations(data.tables.questions[0].question_id)).toBe(2);
    const ko=store.questions('5','ko',1,last.question_id)[0];const en=store.questions('5','en',1,last.question_id)[0];
    expect(ko.locale).toBe('ko');expect(en.locale).toBe('en');expect(ko).not.toBe(en);
  });
  it('rejects duplicates, orphans, ambiguous positions, wrong answer sets and invalid counters',()=>{
    for(const kind of ['duplicate','orphan','position','answers','counter']){
      const data=fixture();
      if(kind==='duplicate')data.tables.questions.push({...data.tables.questions[0]});
      if(kind==='orphan')data.tables.choices[0].question_id='999';
      if(kind==='position')data.tables.choices[1].number=1;
      if(kind==='answers')data.tables.choices[0].correct=false;
      if(kind==='counter')data.tables.legacy_counters[0].correct=-1;
      expect(()=>coreStudyStore(data,'hash')).toThrow();
    }
  });
  it('continues through bounded batches without overlap or changing original question IDs',()=>{
    const store=coreStudyStore(fixture(),'hash');
    const first=store.questions('5','ko',1);const second=store.questions('5','ko',1,undefined,2);
    expect(first).toHaveLength(20);expect(second).toHaveLength(3);
    expect(new Set([...first,...second].map(q=>q.id)).size).toBe(23);
    expect(second.map(q=>q.questionNumber)).toEqual([21,22,23]);
    expect(store.pagination('5','ko',1,2)).toEqual({page:2,total:23,pages:2});
    expect(store.questions('5','ko',1,undefined,3)).toEqual([]);
  });
  it('validates private file location and content hashes without exposing parse errors',()=>{
    const root=fs.mkdtempSync(path.join(os.tmpdir(),'quizeey-synthetic-reader-'));const file=path.join(root,'local-content.json');
    const manifest=path.join(root,'local-content-manifest.json');const payload=JSON.stringify(fixture());
    try{
      fs.writeFileSync(file,payload);fs.writeFileSync(manifest,JSON.stringify({status:'owner_approved_filtered_local_review',hostedUseAllowed:false,deletedQuestionCount:751,deletedQuestionIdSetSha256:'425654b55ad190dce415c853c95908521c6de0ed9e2860101d0ae8ac2730c6fd',contentSha256:createHash('sha256').update(payload).digest('hex')}));
      expect(loadLocalStudyStore(file,os.tmpdir()).questions('5','ko')).toHaveLength(20);
      expect(()=>loadLocalStudyStore(file,path.join(root,'unavailable'))).toThrow(/Private study content unavailable/);
      fs.writeFileSync(file,'PRIVATE INPUT SHOULD NEVER BE PRINTED');
      expect(()=>loadLocalStudyStore(file,os.tmpdir())).toThrow(/^Private study content unavailable/);
      expect(()=>loadLocalStudyStore('relative-file.json',os.tmpdir())).toThrow();
    }finally{fs.unlinkSync(file);fs.unlinkSync(manifest);fs.rmdirSync(root);}
  });
  it('requires authenticated local review and rejects hosted archive access',()=>{
    const env={QUIZEEY_CONTENT_SOURCE:'local-archive',QUIZEEY_LOCAL_CONTENT_FILE:'C:/private/local-content.json',QUIZEEY_PREVIEW_USER:'review',QUIZEEY_PREVIEW_PASSWORD:'a-strong-test-password-at-least-24-characters'};
    expect(environment(env)).toMatchObject({stage:'local',protectedReview:true,adsEnabled:false,analyticsEnabled:false});
    expect(()=>environment({...env,QUIZEEY_PREVIEW_PASSWORD:''})).toThrow();
    expect(()=>environment({...env,VERCEL_ENV:'preview'})).toThrow(/Hosted use is blocked/);
    expect(()=>environment({...env,VERCEL_ENV:'production'})).toThrow(/Production release blocked/);
    expect(()=>environment({...env,VERCEL:'1'})).toThrow(/Hosted use is blocked/);
  });
});
