import type { Metadata, MetadataRoute } from 'next';
import { findRoute,legacy,parseQuery,routesForExam } from './contracts';

export function canonicalPath(path:string,query:URLSearchParams){
  const input=parseQuery(query,path.endsWith('/test'));
  let canonical=['/','/kr','/app'].includes(path)?'/':path.startsWith('/kr/')?path.slice(3):path;
  if(path.endsWith('/test')&&input.testId)canonical=routesForExam(input.testId,path.startsWith('/en/')?'en':'ko').find(r=>!r.path.endsWith('/test'))?.path??canonical;
  const params=new URLSearchParams();
  if(input.questId)params.set('questId',input.questId);
  if(input.verNbr)params.set('verNbr',String(input.verNbr));
  if(!input.questId&&input.page>1)params.set('page',String(input.page));
  return canonical+(params.size?'?'+params:'');
}
export function seoAlternates(path:string,query:URLSearchParams,origin:string):Metadata['alternates']{
  const canonical=canonicalPath(path,query);
  const base=canonical.split('?')[0];const suffix=canonical.slice(base.length);
  let languages:Record<string,string>|undefined;
  if(base==='/'||base==='/en')languages={ko:origin+'/',en:origin+'/en','x-default':origin+'/'};
  else {
    const ko=base.startsWith('/en/')?base.slice(3):base;
    const a=findRoute(ko),b=findRoute('/en'+ko);
    // Shared exam identity and identical slug are required; titles are not translations.
    if(a?.testId&&a.testId===b?.testId)languages={ko:origin+ko+suffix,en:origin+'/en'+ko+suffix};
  }
  return {canonical:origin+canonical,...(languages?{languages}:{})};
}
export function publicSitemap(origin:string):MetadataRoute.Sitemap{
  return legacy.routes.filter(r=>!['/kr','/app'].includes(r.path)&&!r.path.startsWith('/kr/')&&!r.path.endsWith('/test'))
    .map(r=>({url:origin+r.path,alternates:{languages:seoAlternates(r.path,new URLSearchParams(),origin)?.languages as Record<string,string>|undefined}}));
}
