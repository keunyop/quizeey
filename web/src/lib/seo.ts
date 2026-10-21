import type { Metadata, MetadataRoute } from 'next';
import { findRoute,legacy,parseQuery,routesForExam,type LegacyRoute,type Locale } from './contracts';
import { examName } from './exam-catalog';
import { authoredSetSummary, authoredVersion, authoredVersionName } from './authored-practice';

export const searchMarkets = {
  ko: { languages: ['ko', 'ko-KR'], openGraph: 'ko_KR', alternateOpenGraph: [] },
  en: { languages: ['en', 'en-US', 'en-CA'], openGraph: 'en_US', alternateOpenGraph: ['en_CA'] },
} as const;

export const homeSearchCopy = {
  ko: {
    title: 'Quizeey - 자격증 시험 기출문제 CBT 문제은행',
    description: 'SQLD, 정보처리기사, 전기기사 등 한국 자격증 시험을 준비하세요. Quizeey에서 한국어 기출문제와 연습문제를 풀고, 정답 확인과 오답 복습으로 CBT 시험에 대비할 수 있습니다.',
  },
  en: {
    title: 'Free Certification Practice Questions & Exam Prep | Quizeey',
    description: 'Free certification practice questions for learners in the United States and Canada. Study AWS, Azure, Cisco and more in English with Quizeey.',
  },
} as const;

export function searchCopy(path: string, query: URLSearchParams, exam: LegacyRoute) {
  const locale = exam.locale as Locale;
  const base = canonicalPath(path, query).split('?')[0];
  if (base === '/' || base === '/en') return homeSearchCopy[locale];
  let title = exam.title || `${examName(exam)} - Quizeey`;
  let description = exam.description || undefined;
  if (exam.testId) {
    const input = parseQuery(query, path.endsWith('/test'));
    const name = examName(exam);
    description = locale === 'ko'
      ? `${name} 기출문제와 연습문제를 Quizeey에서 풀어보세요. 한국어 CBT 문제 풀이, 정답 확인, 오답 복습으로 ${name} 시험을 준비할 수 있습니다.`
      : `Prepare for ${name} with free English practice questions on Quizeey. Check your answers, review mistakes and build your exam knowledge at your own pace.`;
    if (exam.template === 'authored-practice' && exam.description) description = exam.description;
    const authored = authoredSetSummary(exam.testId, locale);
    if (input.verNbr === authoredVersion && authored) {
      title = `${name} ${locale === 'ko' ? '연습문제' : 'Practice Questions'} - Quizeey`;
      description = locale === 'ko'
        ? `${name} ${authoredVersionName} 회차: 정답과 해설이 있는 자체 제작 연습문제 ${authored.count}개. 공식 기출 회차와 구분되는 학습 자료입니다.`
        : `${name}, ${authoredVersionName}: ${authored.count} original practice questions with answers and explanations. Independent study material.`;
      if (authored.scope) description += ` ${authored.scope}`;
    }
    const versionLabel = input.verNbr === authoredVersion ? authoredVersionName : String(input.verNbr);
    const qualifiers = locale === 'ko'
      ? [input.verNbr ? `${versionLabel} 회차` : '', input.page > 1 ? `${input.page}페이지` : '']
      : [input.verNbr ? `Set ${versionLabel}` : '', input.page > 1 ? `Page ${input.page}` : ''];
    const detail = qualifiers.filter(Boolean).join(' · ');
    if (detail) {
      title = `${title.replace(/\s*[-|]\s*Quizeey\s*$/i, '')} · ${detail} - Quizeey`;
      description += ` (${detail})`;
    }
  }
  return { title, description };
}

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
  const route=findRoute(base);
  const languages:Record<string,string>={};
  const add=(locale:Locale,url:string)=>{
    for(const language of searchMarkets[locale].languages)languages[language]=url;
  };
  if(base==='/'||base==='/en'){
    add('ko',origin+'/');add('en',origin+'/en');languages['x-default']=origin+'/';
  }
  else {
    if(route)add(route.locale as Locale,origin+canonical);
    const ko=base.startsWith('/en/')?base.slice(3):base;
    const a=findRoute(ko),b=findRoute('/en'+ko);
    // Shared exam identity and identical slug are required; titles are not translations.
    // Set, question and pagination identities are not verified across languages.
    if(!suffix&&a?.testId&&a.testId===b?.testId){add('ko',origin+ko);add('en',origin+'/en'+ko);}
  }
  return {canonical:origin+canonical,...(Object.keys(languages).length?{languages}:{})};
}

export function searchMetadata(path: string, query: URLSearchParams, exam: LegacyRoute, origin: string, publicProduction: boolean): Metadata {
  const { title, description } = searchCopy(path, query, exam);
  const market = searchMarkets[exam.locale as Locale];
  const input = parseQuery(query, path.endsWith('/test'));
  return {
    title: { absolute: title }, description,
    // Direct questions remain excluded until their publication policy is verified.
    robots: { index: publicProduction && !input.questId, follow: publicProduction },
    ...(publicProduction ? { alternates: seoAlternates(path, query, origin) } : {}),
    openGraph: {
      title, description, locale: market.openGraph, alternateLocale: [...market.alternateOpenGraph],
      ...(publicProduction ? { url: origin + canonicalPath(path, query) } : {}),
      siteName: 'Quizeey', type: 'website',
    },
    twitter: { card: 'summary', title, description },
  };
}

export function pageStructuredData(path: string, query: URLSearchParams, exam: LegacyRoute, origin: string) {
  const locale = exam.locale as Locale;
  const home = locale === 'en' ? '/en' : '/';
  const url = origin + canonicalPath(path, query);
  const isHome = canonicalPath(path, query).split('?')[0] === home;
  const copy = searchCopy(path, query, exam);
  const input = parseQuery(query, path.endsWith('/test'));
  const authored = exam.testId && input.verNbr === authoredVersion && !input.questId ? authoredSetSummary(exam.testId, locale) : undefined;
  const website = {
    '@type': 'WebSite', '@id': origin + '/#website', url: origin + '/', name: 'Quizeey',
    inLanguage: ['ko-KR', 'en-US', 'en-CA'],
  };
  const breadcrumb = {
    '@type': 'BreadcrumbList', '@id': url + '#breadcrumb',
    itemListElement: [
      { '@type': 'ListItem', position: 1, name: locale === 'ko' ? '자격증 기출문제' : 'Practice exams', item: origin + home },
      { '@type': 'ListItem', position: 2, name: examName(exam), item: url },
    ],
  };
  return {
    '@context': 'https://schema.org',
    '@graph': [website, {
      '@type': isHome ? 'CollectionPage' : 'WebPage', '@id': url + '#webpage', url,
      name: copy.title, description: copy.description,
      inLanguage: locale === 'ko' ? 'ko-KR' : ['en-US', 'en-CA'],
      isPartOf: { '@id': website['@id'] },
      ...(authored ? { mainEntity: {
        '@type': ['CreativeWork', 'LearningResource'], name: `${examName(exam)} · ${authored.name}`,
        url, description: copy.description, inLanguage: authored.languages,
        learningResourceType: 'Practice questions', educationalUse: 'Self-study', isAccessibleForFree: true,
      } } : {}),
      ...(!isHome && exam.testId ? { breadcrumb: { '@id': breadcrumb['@id'] } } : {}),
    }, ...(!isHome && exam.testId ? [breadcrumb] : [])],
  };
}

export function serializeStructuredData(data: ReturnType<typeof pageStructuredData>) {
  return JSON.stringify(data).replace(/</g, '\\u003c');
}
export function publicSitemap(origin:string):MetadataRoute.Sitemap{
  const routes = legacy.routes.filter(r=>!['/kr','/app'].includes(r.path)&&!r.path.startsWith('/kr/')&&!r.path.endsWith('/test'));
  return routes.flatMap(route => {
    const queries = [new URLSearchParams()];
    const set = route.testId ? authoredSetSummary(route.testId, route.locale as Locale) : undefined;
    if (set) {
      for (let page = 1; page <= Math.ceil(set.count / 20); page++) {
        queries.push(new URLSearchParams({ verNbr: String(set.version), ...(page > 1 ? { page: String(page) } : {}) }));
      }
    }
    return queries.map(query => ({
      url: origin + canonicalPath(route.path, query),
      alternates: { languages: seoAlternates(route.path, query, origin)?.languages as Record<string,string> | undefined },
    }));
  });
}
