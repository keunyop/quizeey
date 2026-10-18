import {expect,it} from 'vitest';
import {googleConsent} from './google-consent';
const consent={adStoragePurposeConsentStatus:1,adUserDataPurposeConsentStatus:1,adPersonalizationPurposeConsentStatus:1,analyticsStoragePurposeConsentStatus:1};
it('blocks unknown, denied, unconfigured and US opt-out states',()=>{
  for(const us of [undefined,0,3])expect(googleConsent(consent,us)).toEqual({ads:false,analytics:false});
  expect(googleConsent(undefined,1)).toEqual({ads:false,analytics:false});
  for(const status of [0,2,4,undefined])expect(googleConsent({...consent,analyticsStoragePurposeConsentStatus:status},1).analytics).toBe(false);
});
it('allows only explicitly granted or inapplicable purposes and separates ads from analytics',()=>{
  expect(googleConsent(consent,2)).toEqual({ads:true,analytics:true});
  expect(googleConsent({...consent,adPersonalizationPurposeConsentStatus:3},1).ads).toBe(true);
  expect(googleConsent({...consent,adStoragePurposeConsentStatus:2},1)).toEqual({ads:false,analytics:true});
  expect(googleConsent({...consent,analyticsStoragePurposeConsentStatus:2},1)).toEqual({ads:true,analytics:false});
});
it('uses explicit EU purpose decisions when the actual publisher exposes no US API',()=>{
  expect(googleConsent(consent,undefined,false)).toEqual({ads:true,analytics:true});
  expect(googleConsent({...consent,analyticsStoragePurposeConsentStatus:2},undefined,false)).toEqual({ads:true,analytics:false});
  expect(googleConsent(undefined,undefined,false)).toEqual({ads:false,analytics:false});
  for(const us of [0,3])expect(googleConsent(consent,us,false)).toEqual({ads:false,analytics:false});
  expect(googleConsent(consent,undefined,true)).toEqual({ads:false,analytics:false});
});
