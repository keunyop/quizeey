'use client';
import {createContext,useCallback,useContext,useEffect,useMemo,useRef,useState,useSyncExternalStore,type ReactNode} from 'react';
import {AdLifecycle,measure,PUBLISHER,AD_POLICY_VERSION,type EventName,type QuizPayload} from '@/lib/integrations';
import {googleConsent,type GoogleConsentValues} from '@/lib/google-consent';
import {analyticsLocation,analyticsReferrer} from '@/lib/google-analytics';

type FundingChoices={callbackQueue:Record<string,()=>void>[];getGoogleConsentModeValues?:()=>GoogleConsentValues;showRevocationMessage?:()=>void;usstatesoptout?:{overrideDnsLink?:boolean;getInitialUsStatesOptOutStatus?:()=>number;openConfirmationDialog?:(callback:(optedOut:boolean)=>void)=>void}};
declare global {interface Window{googlefc?:FundingChoices;dataLayer?:unknown[];gtag?:(...args:unknown[])=>void;adsbygoogle?:object[]}}
const scripts=new Map<string,Promise<void>>();
function loadScript(id:string,src:string,overlays?:'collapsed-bottom'){
  let promise=scripts.get(id);
  if(!promise){promise=new Promise<void>((resolve,reject)=>{const script=document.createElement('script');script.id=id;script.async=true;script.src=src;
    // Funding Choices has no Access-Control-Allow-Origin header and must use
    // classic script loading. Keep the documented anonymous mode for ad tags.
    if(id!=='quizeey-cmp')script.crossOrigin='anonymous';
    if(overlays)script.dataset.overlays=overlays;
    script.onload=()=>resolve();script.onerror=()=>reject(new Error('Integration blocked'));document.head.append(script);});scripts.set(id,promise);}
  return promise;
}
type AdKind='display'|'infeed';
const disabled:{ads:boolean;analytics:boolean;claimAd:(kind:AdKind)=>boolean;track:(event:EventName,payload:QuizPayload)=>boolean}={ads:false,analytics:false,claimAd:()=>false,track:()=>false};
const IntegrationContext=createContext(disabled);
export const useAnalytics=()=>useContext(IntegrationContext);
const subscribe=()=>()=>{};

export function Monetization({enabled,measurementId,cmpScriptUrl,pagePath,locale,children}:{enabled:boolean;measurementId?:string;cmpScriptUrl?:string;pagePath:string;locale:'ko'|'en';children:ReactNode}){
  const [consent,setConsent]=useState({ads:false,analytics:false});
  const [usApplicable,setUsApplicable]=useState(false);
  const [tagReady,setTagReady]=useState(false);
  const allowed=useRef(consent);const configured=useRef(false);const pageViewed=useRef('');
  // One request per placement for this document, including filter/consent remounts.
  const requestedAds=useRef(new Set<AdKind>());
  const claimAd=useCallback((kind:AdKind)=>{if(requestedAds.current.has(kind))return false;requestedAds.current.add(kind);return true;},[]);
  const live=useSyncExternalStore(subscribe,()=>enabled&&window.location.origin==='https://quizeey.com',()=>false);
  const track=useCallback((event:EventName,payload:QuizPayload)=>measure({stage:live?'production':'preview',consent:allowed.current.analytics,verified:!!measurementId&&configured.current},(name,data)=>window.gtag?.('event',name,{...data,ad_policy:AD_POLICY_VERSION,send_to:measurementId,page_location:analyticsLocation(pagePath,window.location.search)}),event,payload),[live,measurementId,pagePath]);
  useEffect(()=>{
    if(!live||!measurementId||!cmpScriptUrl)return;
    let active=true;
    window.dataLayer??=[];
    // Google tag's documented queue format uses an Arguments object.
    // eslint-disable-next-line prefer-rest-params
    window.gtag??=function(){window.dataLayer!.push(arguments);};
    window.gtag('consent','default',{ad_storage:'denied',analytics_storage:'denied',ad_user_data:'denied',ad_personalization:'denied'});
    const fc=window.googlefc??={callbackQueue:[]};fc.callbackQueue??=[];
    fc.usstatesoptout??={};fc.usstatesoptout.overrideDnsLink=true;
    let usStatus:number|undefined;
    const update=()=>{
      if(!active)return;
      let next={ads:false,analytics:false};
      try{next=googleConsent(fc.getGoogleConsentModeValues?.(),usStatus,typeof fc.usstatesoptout?.getInitialUsStatesOptOutStatus==='function');}catch{/* Fail closed when CMP is unavailable. */}
      allowed.current=next;setConsent(next);
      (window as unknown as Record<string,unknown>)['ga-disable-'+measurementId]=!next.analytics;
      window.gtag?.('consent','update',{ad_storage:next.ads?'granted':'denied',ad_user_data:next.ads?'granted':'denied',ad_personalization:next.ads?'granted':'denied',analytics_storage:next.analytics?'granted':'denied'});
    };
    fc.callbackQueue.push({CONSENT_MODE_DATA_READY:update},{CONSENT_DATA_READY:update},{INITIAL_US_STATES_OPT_OUT_DATA_READY:()=>{usStatus=fc.usstatesoptout?.getInitialUsStatesOptOutStatus?.();setUsApplicable(usStatus===2||usStatus===3);update();}});
    void loadScript('quizeey-cmp',cmpScriptUrl).catch(()=>{});
    return()=>{active=false;allowed.current={ads:false,analytics:false};};
  },[live,measurementId,cmpScriptUrl]);
  useEffect(()=>{
    if(!live||!consent.analytics||!measurementId)return;
    let active=true;
    void loadScript('quizeey-ga4','https://www.googletagmanager.com/gtag/js?id='+measurementId).then(()=>{
      if(!active||!allowed.current.analytics)return;
      const location=analyticsLocation(pagePath,window.location.search),referrer=analyticsReferrer(document.referrer);
      if(!configured.current){window.gtag?.('js',new Date());window.gtag?.('config',measurementId,{send_page_view:false,allow_google_signals:false,allow_ad_personalization_signals:false,page_location:location,page_referrer:referrer});configured.current=true;}
      setTagReady(true);
      if(pageViewed.current===pagePath)return;
      pageViewed.current=pagePath;
      // Do not send arbitrary URL queries, form text, guest identities or answer text.
      window.gtag?.('event','page_view',{send_to:measurementId,page_location:location,page_referrer:referrer,page_title:document.title,ad_policy:AD_POLICY_VERSION});
    }).catch(()=>{});
    return()=>{active=false;};
  },[live,consent.analytics,measurementId,pagePath]);
  function privacy(us=false){
    allowed.current={ads:false,analytics:false};setConsent(allowed.current);
    if(measurementId)(window as unknown as Record<string,unknown>)['ga-disable-'+measurementId]=true;
    window.gtag?.('consent','update',{ad_storage:'denied',analytics_storage:'denied',ad_user_data:'denied',ad_personalization:'denied'});
    // A reload after changing preferences clears existing ad frames and re-evaluates
    // both CMP APIs. Never infer a new consent grant from a button click.
    if(us)window.googlefc?.usstatesoptout?.openConfirmationDialog?.(()=>window.location.reload());
    else window.googlefc?.showRevocationMessage?.();
  }
  const value=useMemo(()=>({ads:live&&consent.ads,analytics:live&&consent.analytics&&tagReady,track,claimAd}),[live,consent,tagReady,track,claimAd]);
  return <IntegrationContext value={value}>{children}{live&&<div className="privacy-controls"><button className="text-button" onClick={()=>privacy()}>{locale==='ko'?'개인정보 설정':'Privacy choices'}</button>{usApplicable&&<button className="text-button" onClick={()=>privacy(true)}>{locale==='ko'?'개인정보 판매·공유 거부':'Do not sell or share my personal information'}</button>}</div>}</IntegrationContext>;
}

export function AdSlot({kind,locale,eligible=true}:{kind:AdKind;locale:'ko'|'en';eligible?:boolean}){
  const {ads,claimAd}=useContext(IntegrationContext);
  const node=useRef<HTMLModElement>(null);
  const attempted=useRef(new WeakSet<HTMLElement>());
  const [failed,setFailed]=useState(false);
  useEffect(()=>{
    const policy={stage:'production' as const,consent:ads&&eligible,verified:true};
    if(!ads||!eligible||!node.current||failed)return;
    const element=node.current;
    // Each effect owns its in-flight work. A later consent grant/filter reset
    // cannot revive a canceled request for a detached slot.
    const lifecycle=new AdLifecycle<HTMLElement>(policy,{
      loadScript:publisher=>loadScript('quizeey-adsense','https://pagead2.googlesyndication.com/pagead/js/adsbygoogle.js?client='+publisher,'collapsed-bottom'),
      reserve:(slot,height)=>{slot.style.minHeight=height+'px';},
      initialize:slot=>{if(slot.isConnected)(window.adsbygoogle??=[]).push({});},
    });
    const observer=new IntersectionObserver(entries=>{if(!entries.some(entry=>entry.isIntersecting))return;observer.disconnect();if(attempted.current.has(element))return;attempted.current.add(element);if(!claimAd(kind)){setFailed(true);return;}void lifecycle.mount(element,kind==='display'?'1033140566':'8990988805',250).then(ok=>{if(!ok&&element.isConnected)setFailed(true);});},{rootMargin:'200px'});
    const mutations=new MutationObserver(()=>{if(element.dataset.adStatus==='unfilled')setFailed(true);});mutations.observe(element,{attributes:true,attributeFilter:['data-ad-status']});
    observer.observe(element);
    return()=>{observer.disconnect();mutations.disconnect();lifecycle.updatePolicy({...policy,consent:false});};
  },[ads,kind,failed,eligible,claimAd]);
  if(!ads||!eligible||failed)return null;
  return <aside className="ad-placement" aria-label={locale==='ko'?'광고':'Advertisement'}><span>{locale==='ko'?'광고':'Advertisement'}</span><ins ref={node} className="adsbygoogle" style={{display:'block',minHeight:250}} data-ad-client={PUBLISHER} data-ad-slot={kind==='display'?'1033140566':'8990988805'} data-ad-format={kind==='display'?'auto':'fluid'} data-full-width-responsive={kind==='display'?'true':undefined} data-ad-layout-key={kind==='infeed'?'-f9+5v+4m-d8+7b':undefined}/></aside>;
}
