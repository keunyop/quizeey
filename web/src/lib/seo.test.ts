import {expect,it} from 'vitest';
import {canonicalPath,seoAlternates,publicSitemap,searchCopy,searchMetadata,pageStructuredData,serializeStructuredData} from './seo';
import {findRoute} from './contracts';
it('preserves content identity and pages while consolidating aliases and tracking parameters',()=>{
  expect(canonicalPath('/kr/sqlp-developer',new URLSearchParams('utm_source=test&verNbr=2&page=2'))).toBe('/sqlp-developer?verNbr=2&page=2');
  expect(canonicalPath('/test',new URLSearchParams('testId=5&questId=9007199254740993'))).toBe('/sqlp-developer?questId=9007199254740993');
  expect(canonicalPath('/app',new URLSearchParams())).toBe('/');
  expect(canonicalPath('/en/aws-certified-developer-associate',new URLSearchParams('verNbr=0&page=1'))).toBe('/en/aws-certified-developer-associate');
});
it('ignores practice selectors on home and static pages without excluding their content from search',()=>{
  const origin = 'https://quizeey.com';
  const query = new URLSearchParams('page=2&verNbr=1&utm_source=gsc');
  for (const [path, target] of [['/', '/'], ['/kr', '/'], ['/app', '/'], ['/en', '/en'], ['/about', '/about'], ['/privacy', '/privacy']]) {
    const route = findRoute(path)!;
    expect(canonicalPath(path, query)).toBe(target);
    const metadata = searchMetadata(path, query, route, origin, true);
    expect(metadata.robots).toEqual({index:true, follow:true});
    expect(metadata.alternates?.canonical).toBe(origin + target);
    expect(metadata.openGraph).toMatchObject({url:origin + target});
    expect(pageStructuredData(path, query, route, origin)['@graph'][1]).toMatchObject({url:origin + target});
    expect(searchMetadata(path, query, route, origin, false).robots).toEqual({index:false, follow:false});
  }
});
it('publishes only verified equivalents and unique canonical sitemap URLs',()=>{
  const origin='https://quizeey.com';
  const homes={ko:origin+'/','ko-KR':origin+'/',en:origin+'/en','en-US':origin+'/en','en-CA':origin+'/en','x-default':origin+'/'};
  expect(seoAlternates('/',new URLSearchParams(),origin)?.languages).toEqual(homes);
  expect(seoAlternates('/en',new URLSearchParams(),origin)?.languages).toEqual(homes);
  expect(seoAlternates('/sqlp-developer',new URLSearchParams(),origin)?.languages).toEqual({ko:origin+'/sqlp-developer','ko-KR':origin+'/sqlp-developer'});
  const map=publicSitemap(origin);
  expect(map.length).toBeGreaterThan(180);
  expect(new Set(map.map(r=>r.url)).size).toBe(map.length);
  expect(map.every(r=>!r.url.includes('/kr')&&!r.url.endsWith('/test')&&!r.url.endsWith('/app')&&!r.lastModified)).toBe(true);
  for(const entry of map){
    const languages=entry.alternates?.languages;
    expect(languages).toBeDefined();
    expect(Object.values(languages!)).toContain(entry.url);
    for(const alternate of Object.values(languages!)){
      const target=map.find(r=>r.url===alternate);
      expect(target,alternate).toBeDefined();
      expect(target?.alternates?.languages).toEqual(languages);
    }
  }
});

it('targets both North American markets without inventing translated question or page identities',()=>{
  const origin='https://quizeey.com',path='/en/aws-certified-developer-associate';
  const languages=seoAlternates(path,new URLSearchParams(),origin)?.languages;
  expect(languages).toMatchObject({en:origin+path,'en-US':origin+path,'en-CA':origin+path,ko:origin+'/aws-certified-developer-associate','ko-KR':origin+'/aws-certified-developer-associate'});
  for(const query of ['verNbr=202610','page=2','questId=9007199254740993']){
    const url=origin+path+'?'+query;
    expect(seoAlternates(path,new URLSearchParams(query),origin)).toEqual({canonical:url,languages:{en:url,'en-US':url,'en-CA':url}});
  }
  const authored='/en/servsafe-food-handler';
  expect(findRoute(authored)).toBeDefined();
  expect(seoAlternates(authored,new URLSearchParams(),origin)?.languages).toEqual({en:origin+authored,'en-US':origin+authored,'en-CA':origin+authored});
});

it('provides localized, page-specific search copy without unsupported pass guarantees',()=>{
  const ko=findRoute('/sqlp-developer')!,en=findRoute('/en/aws-certified-developer-associate')!;
  expect(searchCopy('/',new URLSearchParams(),findRoute('/')!).description).toContain('CBT 시험');
  expect(searchCopy('/en',new URLSearchParams(),findRoute('/en')!)).toMatchObject({title:expect.stringContaining('Practice Tests'),description:expect.stringContaining('Canadian citizenship')});
  expect(searchCopy(ko.path,new URLSearchParams(),ko).description).toContain('SQLD');
  expect(searchCopy(en.path,new URLSearchParams(),en).description).not.toMatch(/pass.*easily|exam dumps/i);
  const page=searchCopy(en.path,new URLSearchParams('page=2&verNbr=202610'),en);
  expect(page.title).toContain('Set 2026-10 · Page 2');
  expect(page.description).toContain('Page 2');
  expect(searchCopy(ko.path,new URLSearchParams('page=2'),ko).title).toContain('2페이지');
});

it('keeps the English AZ-900 search title on authored sets and leaves Korean titles unchanged', () => {
  const en = findRoute('/en/az-900')!, ko = findRoute('/az-900')!;
  const title = 'Free AZ-900 Practice Questions with Answers | Azure Fundamentals - Quizeey';
  expect(searchCopy(en.path, new URLSearchParams(), en).title).toBe(title);
  expect(searchCopy(en.path, new URLSearchParams('verNbr=202610&page=2'), en).title)
    .toBe(title.replace(' - Quizeey', ' · Set 2026-10 · Page 2 - Quizeey'));
  expect(searchCopy(ko.path, new URLSearchParams(), ko).title).toBe(ko.title);
  expect(searchCopy(ko.path, new URLSearchParams('verNbr=202610'), ko).title)
    .toBe('Microsoft Azure Fundamentals(AZ-900) 연습문제 · 2026-10 회차 - Quizeey');
  expect(searchCopy(en.path, new URLSearchParams(), { ...en, testId: '1' }).title).toBe(en.title);
});

it('includes every authored set page without inventing archive pages or direct-question index entries',()=>{
  const origin='https://quizeey.com';
  const urls=publicSitemap(origin).map(entry=>entry.url);
  expect(urls).toContain(origin+'/sqlp-developer?verNbr=202610');
  expect(urls).toContain(origin+'/sqlp-developer?verNbr=202610&page=2');
  expect(urls).toContain(origin+'/sqlp-developer?verNbr=202610&page=3');
  expect(urls).not.toContain(origin+'/sqlp-developer?verNbr=202610&page=4');
  expect(urls).toContain(origin+'/en/comptia-sy0-501?verNbr=202610&page=3');
  expect(urls).not.toContain(origin+'/en/comptia-sy0-501?verNbr=202610&page=4');
  expect(urls.every(url=>!url.includes('questId=')&&!url.includes('verNbr=1'))).toBe(true);
  const exam=findRoute('/sqlp-developer')!;
  expect(searchCopy(exam.path,new URLSearchParams('verNbr=202610'),exam)).toMatchObject({
    title:expect.stringContaining('2026-10'),description:expect.stringContaining('43개'),
  });
  expect(searchCopy(exam.path,new URLSearchParams('verNbr=202610'),exam).description).not.toContain('자체 제작');
  expect(searchCopy(exam.path,new URLSearchParams('verNbr=202610'),exam).title).toContain('연습문제');
  expect(pageStructuredData(exam.path,new URLSearchParams('verNbr=202610'),exam,origin)['@graph'][1]).toMatchObject({
    mainEntity:{'@type':['CreativeWork','LearningResource'],inLanguage:['ko'],isAccessibleForFree:true},
  });
});

it('opens only public production pages for indexing and keeps canonical identities in social cards',()=>{
  const origin='https://quizeey.com',exam=findRoute('/en/aws-certified-developer-associate')!;
  const metadata=searchMetadata(exam.path,new URLSearchParams('utm_source=test&page=2'),exam,origin,true);
  expect(metadata.robots).toEqual({index:true,follow:true});
  expect(metadata.alternates?.canonical).toBe(origin+exam.path+'?page=2');
  expect(metadata.openGraph).toMatchObject({locale:'en_US',alternateLocale:['en_CA'],url:metadata.alternates?.canonical});
  expect(metadata.twitter).toMatchObject({card:'summary',title:expect.stringContaining('Page 2')});
  expect(searchMetadata(exam.path,new URLSearchParams('questId=9007199254740993'),exam,origin,true).robots).toEqual({index:false,follow:true});
  const blocked=searchMetadata(exam.path,new URLSearchParams(),exam,origin,false);
  expect(blocked.robots).toEqual({index:false,follow:false});
  expect(blocked.alternates).toBeUndefined();
  expect(searchMetadata('/sqlp-developer',new URLSearchParams(),findRoute('/sqlp-developer')!,origin,true).openGraph).toMatchObject({locale:'ko_KR',alternateLocale:[]});
});

it('describes the site and visible exam hierarchy with script-safe structured data',()=>{
  const origin='https://quizeey.com',exam=findRoute('/en/aws-certified-developer-associate')!;
  const data=pageStructuredData(exam.path,new URLSearchParams('page=2'),exam,origin);
  expect(data['@graph'][0]).toMatchObject({'@type':'WebSite',name:'Quizeey',inLanguage:['ko-KR','en-US','en-CA']});
  expect(data['@graph'][1]).toMatchObject({'@type':'WebPage',url:origin+exam.path+'?page=2',inLanguage:['en-US','en-CA']});
  expect(data['@graph'][2]).toMatchObject({'@type':'BreadcrumbList',itemListElement:[{position:1,item:origin+'/en'},{position:2,item:origin+exam.path+'?page=2'}]});
  const home=pageStructuredData('/',new URLSearchParams(),findRoute('/')!,origin);
  expect(home['@graph']).toHaveLength(2);
  expect(home['@graph'][1]).toMatchObject({'@type':'CollectionPage',inLanguage:'ko-KR'});
  const unsafe=pageStructuredData(exam.path,new URLSearchParams(),{...exam,title:'</script><script>alert(1)</script>'},origin);
  const serialized=serializeStructuredData(unsafe);
  expect(serialized).not.toContain('<');
  expect(JSON.parse(serialized)).toEqual(unsafe);
});
