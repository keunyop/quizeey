import {expect,it} from 'vitest';
import {environment} from './environment';
const release={VERCEL_ENV:'production',QUIZEEY_RELEASE_READY:'true',QUIZEEY_CONTENT_SOURCE:'supabase',QUIZEEY_ADS_VERIFIED:'true',QUIZEEY_GA4_MEASUREMENT_ID:'G-TESTONLY123',QUIZEEY_CMP_SCRIPT_URL:'https://fundingchoicesmessages.google.com/i/pub-8362228066874729?ers=1',QUIZEEY_PREVIEW_USER:'review',QUIZEEY_PREVIEW_PASSWORD:'x'.repeat(24),QUIZEEY_SUPABASE_URL:'https://tfkhnrbshvyfmrzxqfmq.supabase.co',QUIZEEY_SUPABASE_SECRET_KEY:'sb_secret_mock',QUIZEEY_CONTENT_DATASET_SHA256:'88ed4da320cf3bbd40d65f1aa6de7ba6b81a09f5aa6bbcef1e3860ca58ccb42f'};
it('requires existing measurement, consent, exact project/dataset and protected candidate configuration',()=>{
  expect(environment(release)).toMatchObject({stage:'production',adsEnabled:true,analyticsEnabled:true});
  for(const key of ['QUIZEEY_RELEASE_READY','QUIZEEY_ADS_VERIFIED','QUIZEEY_GA4_MEASUREMENT_ID','QUIZEEY_CMP_SCRIPT_URL','QUIZEEY_PREVIEW_PASSWORD','QUIZEEY_SUPABASE_SECRET_KEY','QUIZEEY_CONTENT_DATASET_SHA256'])expect(()=>environment({...release,[key]:undefined})).toThrow();
  for(const change of [{QUIZEEY_CANONICAL_ORIGIN:'https://other.com'},{QUIZEEY_GA4_MEASUREMENT_ID:'UA-66061566-2'},{QUIZEEY_CMP_SCRIPT_URL:'https://unverified.test/script.js'},{QUIZEEY_CONTENT_SOURCE:'fixture'}])expect(()=>environment({...release,...change})).toThrow();
});
it('never enables live integrations in previews, even when production flags are present',()=>{
  expect(environment({...release,VERCEL_ENV:'preview'})).toMatchObject({stage:'preview',adsEnabled:false,analyticsEnabled:false,protectedReview:true});
});
it('allows an explicit protected production review without opening release or live integrations',()=>{
  const review={...release,QUIZEEY_PRODUCTION_REVIEW:'true',QUIZEEY_RELEASE_READY:'false',QUIZEEY_ADS_VERIFIED:'false',QUIZEEY_CMP_SCRIPT_URL:undefined};
  expect(environment(review)).toMatchObject({stage:'production',productionReview:true,protectedReview:true,adsEnabled:false,analyticsEnabled:false});
  expect(()=>environment({...review,QUIZEEY_PRODUCTION_REVIEW:undefined})).toThrow();
  expect(()=>environment({...review,QUIZEEY_RELEASE_READY:'true'})).toThrow();
  for(const key of ['QUIZEEY_PREVIEW_PASSWORD','QUIZEEY_SUPABASE_SECRET_KEY','QUIZEEY_GA4_MEASUREMENT_ID'])expect(()=>environment({...review,[key]:undefined})).toThrow();
});
