import { expect, it, vi } from 'vitest';
import { verifyProductionRead } from '../../scripts/preflight-production';

const config={VERCEL_ENV:'production',QUIZEEY_PRODUCTION_REVIEW:'true',QUIZEEY_CONTENT_SOURCE:'supabase',QUIZEEY_GA4_MEASUREMENT_ID:'G-TESTONLY123',QUIZEEY_PREVIEW_USER:'review',QUIZEEY_PREVIEW_PASSWORD:'x'.repeat(24),QUIZEEY_SUPABASE_URL:'https://tfkhnrbshvyfmrzxqfmq.supabase.co',QUIZEEY_SUPABASE_SECRET_KEY:'sb_secret_mock',QUIZEEY_CONTENT_DATASET_SHA256:'88ed4da320cf3bbd40d65f1aa6de7ba6b81a09f5aa6bbcef1e3860ca58ccb42f'};
function fixture(){return {schema:1,tables:{exams:Array.from({length:181},(_,i)=>({exam_id:String(i+1)})),versions:[{version_id:'11',exam_id:'140'}],questions:Array.from({length:20},(_,i)=>({question_id:String(i+1),version_id:'11',body:'Synthetic private text'})),choices:Array.from({length:40},(_,i)=>({choice_id:String(i+1)}))},pagination:{page:1,total:329}};}
const json=(value:unknown,status=200)=>new Response(JSON.stringify(value),{status});

it('skips local/preview preflights without network and requires exact verified production configuration',async()=>{
  const fetcher=vi.fn<typeof fetch>();
  expect(await verifyProductionRead({},fetcher)).toEqual({skipped:true});
  expect(await verifyProductionRead({QUIZEEY_ENV:'preview',QUIZEEY_PREVIEW_USER:'review',QUIZEEY_PREVIEW_PASSWORD:'x'.repeat(24)},fetcher)).toEqual({skipped:true});
  await expect(verifyProductionRead({...config,QUIZEEY_SUPABASE_URL:'https://wrong.supabase.co'},fetcher)).rejects.toThrow();
  expect(fetcher).not.toHaveBeenCalled();
});

it('checks an actual bounded read without returning content, credentials or personal data',async()=>{
  const fetcher=vi.fn<typeof fetch>().mockResolvedValue(json(fixture()));
  const result=await verifyProductionRead(config,fetcher);
  expect(result).toEqual({productionReadVerified:true,examCount:181,sampledQuestions:20,review:true});
  expect(JSON.stringify(result)).not.toMatch(/sb_secret|Synthetic private text/);
  const [url,options]=fetcher.mock.calls[0];expect(url).toBe(config.QUIZEEY_SUPABASE_URL+'/rest/v1/rpc/quizeey_study_page');
  expect(options).toMatchObject({method:'POST',cache:'no-store',redirect:'error'});
  expect(options?.body).toBe(JSON.stringify({p_exam_id:'140',p_version:0,p_page:1}));
  expect(options?.signal).toBeInstanceOf(AbortSignal);expect(fetcher).toHaveBeenCalledTimes(1);
});

it('redacts failed reads without retry and rejects inconsistent successful data',async()=>{
  const bad=fixture();bad.tables.versions[0].exam_id='141';
  for(const response of [json({message:'private provider detail sb_secret_mock'},401),json(bad),json({...fixture(),schema:2})]){
    const fetcher=vi.fn<typeof fetch>().mockResolvedValue(response);
    await expect(verifyProductionRead(config,fetcher)).rejects.toThrow('Production content preflight failed (credentials, provider details and content redacted).');
    expect(fetcher).toHaveBeenCalledTimes(1);
  }
});
