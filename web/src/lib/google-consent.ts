export type GoogleConsentValues={adStoragePurposeConsentStatus?:number;adUserDataPurposeConsentStatus?:number;adPersonalizationPurposeConsentStatus?:number;analyticsStoragePurposeConsentStatus?:number};
// Google Funding Choices enums: granted=1, not applicable=3. Unknown, denied and
// not configured remain blocked. Configure support for all four purposes in CMP.
export function googleConsent(values:GoogleConsentValues|undefined,usStatus:number|undefined){
  const allowed=(value:number|undefined)=>value===1||value===3;
  const usAllowed=usStatus===1||usStatus===2;
  return {
    ads:usAllowed&&allowed(values?.adStoragePurposeConsentStatus)&&allowed(values?.adUserDataPurposeConsentStatus)&&allowed(values?.adPersonalizationPurposeConsentStatus),
    analytics:usAllowed&&allowed(values?.analyticsStoragePurposeConsentStatus),
  };
}
