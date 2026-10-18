import { afterEach,expect,it,vi } from 'vitest';
vi.mock('server-only',()=>({}));
import { loadStudyStore } from './study-loader';

const config={QUIZEEY_ENV:'preview',QUIZEEY_PREVIEW_USER:'review',QUIZEEY_PREVIEW_PASSWORD:'x'.repeat(24),
  QUIZEEY_CONTENT_SOURCE:'supabase',QUIZEEY_SUPABASE_URL:'https://tfkhnrbshvyfmrzxqfmq.supabase.co',
  QUIZEEY_SUPABASE_SECRET_KEY:'sb_secret_mock',QUIZEEY_CONTENT_DATASET_SHA256:'88ed4da320cf3bbd40d65f1aa6de7ba6b81a09f5aa6bbcef1e3860ca58ccb42f'};
function payload(){return {schema:1,tables:{
  exams:Array.from({length:181},(_,i)=>({exam_id:String(i+1),name_ko:'Synthetic',name_en:null,legacy_slug:'synthetic',priority:i})),
  versions:[{version_id:'11',exam_id:'5',number:1,name:'First'},{version_id:'12',exam_id:'5',number:2,name:'Second'}],
  questions:[{question_id:'9007199254740993',version_id:'11',number:23,body:'Synthetic <CTRL>',explanation:null,reference:'',multiple_answers:false}],
  choices:[{choice_id:'10000000000000001',question_id:'9007199254740993',number:1,body:'Correct',correct:true}],
  legacy_counters:[{question_id:'9007199254740993',correct:9,incorrect:3}],
},pendingExplanationCounts:{}};}
const json=(data:unknown,status=200)=>new Response(JSON.stringify(data),{status,headers:{'Content-Type':'application/json'}});
afterEach(()=>vi.unstubAllGlobals());
it('binds protected hosted content to the exact dataset and project without fixture fallback',async()=>{
  const fetcher=vi.fn();vi.stubGlobal('fetch',fetcher);
  for(const change of [{QUIZEEY_ENV:'local'},{VERCEL_ENV:'production'},{QUIZEEY_SUPABASE_SECRET_KEY:'sb_publishable_mock'},
    {QUIZEEY_SUPABASE_URL:'https://other.supabase.co'},{QUIZEEY_CONTENT_DATASET_SHA256:'other'}]){
    await expect(loadStudyStore({}, {...config,...change})).rejects.toThrow();
  }
  expect(fetcher).not.toHaveBeenCalled();
});
it('preserves direct bigint IDs, all versions, NULL/empty values and counters across locales',async()=>{
  const fetcher=vi.fn().mockResolvedValue(json(payload()));vi.stubGlobal('fetch',fetcher);
  const store=await loadStudyStore({examId:'5',questionId:'9007199254740993'},config);
  expect(store.source).toBe('supabase');
  expect(store.questions('5','en',0,'9007199254740993')[0]).toMatchObject({id:'9007199254740993',questionNumber:23,explanation:null,reference:''});
  expect(store.questions('1','ko',0,'9007199254740993')).toEqual([]);
  expect(store.versions('5','ko')).toHaveLength(2);
  expect(store.counter('9007199254740993')).toEqual({correct:9,inCorrect:3});
  expect(store.pendingExplanations('9007199254740993')).toBe(true);
  const [url,init]=fetcher.mock.calls[0];
  expect(url).toBe(config.QUIZEEY_SUPABASE_URL+'/rest/v1/rpc/quizeey_study_context');
  expect(JSON.parse(init.body)).toEqual({p_exam_id:'5',p_question_id:'9007199254740993',p_version:0,p_random:false});
  expect(init).toMatchObject({cache:'no-store',redirect:'error'});
});
it('rejects malformed relations, oversized batches and private provider errors',async()=>{
  const fetcher=vi.fn();vi.stubGlobal('fetch',fetcher);
  const missing=payload();missing.tables.exams.pop();
  const tooMany=payload();tooMany.tables.questions=Array.from({length:21},()=>({...tooMany.tables.questions[0]}));
  const broken=payload();broken.tables.choices[0].correct=false;
  for(const data of [missing,tooMany,broken]){
    fetcher.mockResolvedValueOnce(json(data));
    await expect(loadStudyStore({examId:'5'},config)).rejects.toThrow('Study content unavailable');
  }
  fetcher.mockResolvedValueOnce(json({message:'private content/credential'},503));
  await expect(loadStudyStore({examId:'5'},config)).rejects.toThrow('Study content unavailable');
  expect(fetcher).toHaveBeenCalledTimes(4);
});
it('loads a later page via the bounded RPC and rejects missing or inconsistent pagination',async()=>{
  const data={...payload(),pagination:{page:2,total:21}};
  const fetcher=vi.fn().mockResolvedValue(json(data));vi.stubGlobal('fetch',fetcher);
  const store=await loadStudyStore({examId:'5',page:2,version:1},config);
  expect(store.pagination('5','en',1,2)).toEqual({page:2,total:21,pages:2});
  expect(store.questions('5','en',1,undefined,2)).toHaveLength(1);
  expect(fetcher.mock.calls[0][0]).toContain('/rpc/quizeey_study_page');
  expect(JSON.parse(fetcher.mock.calls[0][1].body)).toEqual({p_exam_id:'5',p_version:1,p_page:2});
  for(const change of [{pagination:undefined},{pagination:{page:1,total:21}},{pagination:{page:2,total:40}}]){
    fetcher.mockResolvedValueOnce(json({...data,...change}));
    await expect(loadStudyStore({examId:'5',page:2},config)).rejects.toThrow('Study content unavailable');
  }
});
