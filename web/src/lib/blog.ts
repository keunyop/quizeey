import type { Metadata, MetadataRoute } from 'next';

import type { Locale } from './contracts';

export type BlogPost = { slug: string; path: string; title: string; description: string; date: string; modified: string; category: string; practicePath: string; locale: Locale };

export const blogPost: BlogPost = {
  slug: 'sqld-cbt-study-guide', path: '/blog/sqld-cbt-study-guide', locale: 'ko', modified: '2026-11-02',
  title: 'SQLD 기출문제 CBT 공부법: 풀이·해설·오답 복습 3단계',
  description: 'SQLD 기출문제 CBT를 풀 때 답만 외우지 않는 3단계 복습법. COUNT와 NULL 예제로 정답의 근거를 확인하고, 무료 SQLD 문제풀이로 바로 연습하세요.',
  date: '2026-11-02',
  category: 'SQLD · 문제풀이 가이드',
  practicePath: '/sqlp-developer',
};
export const blogPath = '/blog';
export const blogPostPath = `${blogPath}/${blogPost.slug}`;
export const blogIndex = { title: 'Quizeey 블로그: 예제로 배우는 자격증 공부', description: 'CCNA 서브넷 계산, SQLD, 3D프린터운용기능사 등 헷갈리는 자격증 개념을 예제와 확인 문제로 정리하고 Quizeey 문제풀이로 연습하세요.' };

export const ccnaPost: BlogPost = {
  slug: 'ccna-ipv4-subnetting-gateway', path: '/blog/ccna-ipv4-subnetting-gateway', locale: 'ko',
  title: 'CCNA IPv4 서브넷 계산: 주소 범위로 게이트웨이 설정 점검하기',
  description: 'CCNA 200-301 IPv4 서브네팅을 /26·/23·/28 예제로 계산하세요. 네트워크·브로드캐스트·호스트 범위를 찾고 게이트웨이 주소와 마스크를 점검합니다.',
  date: '2026-11-11', modified: '2026-11-11', category: 'CCNA 200-301 · IPv4 서브네팅',
  practicePath: '/ccna-200-301?verNbr=202610',
};

export const printingPost: BlogPost = {
  slug: '3d-printer-operation-written-test', path: '/blog/3d-printer-operation-written-test', locale: 'ko',
  title: '3D프린터운용기능사 필기: 레이어 높이·서포트·인필 5문제',
  description: '3D프린터운용기능사 필기의 레이어 수 계산, 서포트 판단, 인필 설정을 5문제로 연습하세요. 핵심 원리를 익힌 뒤 무료 문제풀이로 확인할 수 있습니다.',
  date: '2026-11-05', modified: '2026-11-05', category: '3D프린터운용기능사 · 개념 연습', practicePath: '/craftsman-3D-printer-operation',
};

export const subnetPost: BlogPost = {
  slug: 'ipv4-subnetting-practice', path: '/en/blog/ipv4-subnetting-practice', locale: 'en',
  title: 'IPv4 Subnetting Practice: Find the Network, Broadcast and Host Range',
  description: 'Solve /26, /27 and /20 subnetting examples step by step. Check your network address, broadcast and usable hosts, then practise with Network+ questions.',
  date: '2026-11-02', modified: '2026-11-02', category: 'Networking · Worked examples', practicePath: '/en/comptia-n10-009',
};
export const cloudPost: BlogPost = {
  slug: 'iaas-paas-saas-shared-responsibility', path: '/en/blog/iaas-paas-saas-shared-responsibility', locale: 'en',
  title: 'IaaS vs PaaS vs SaaS: Shared Responsibility Practice',
  description: 'Who patches the OS, fixes the code or manages user access? Work through three cloud responsibility scenarios, then practise with AZ-900 questions and explanations.',
  date: '2026-11-04', modified: '2026-11-04', category: 'Cloud fundamentals · Worked examples', practicePath: '/en/az-900',
};
export const roadSignsPost: BlogPost = {
  slug: 'ontario-g1-road-signs-shapes-colours', path: '/en/blog/ontario-g1-road-signs-shapes-colours', locale: 'en',
  title: 'Ontario G1 Road Signs: Shapes, Colours and 5 Practice Questions',
  description: 'Learn Ontario road sign shapes and colours, separate stop from yield, and try five explained questions before practising with the G1 study set.',
  date: '2026-11-08', modified: '2026-11-08', category: 'Ontario G1 · Road sign practice', practicePath: '/en/ontario-g1',
};
export const blogPosts = [ccnaPost, roadSignsPost, printingPost, cloudPost, subnetPost, blogPost];
const englishIndex = { title: 'Quizeey Blog: Certification Concepts with Worked Examples', description: 'Understand a concept, work through an example and check your reasoning with practice questions.' };
export function blogIndexPath(locale: Locale) { return locale === 'en' ? '/en/blog' : blogPath; }
export function blogIndexCopy(locale: Locale) { return locale === 'en' ? englishIndex : blogIndex; }
export function findBlogPost(slug: string, locale: Locale) { return blogPosts.find(post => post.slug === slug && post.locale === locale); }

export function blogMetadata(origin: string, publicProduction: boolean, post?: BlogPost, locale: Locale = 'ko'): Metadata {
  locale = post?.locale ?? locale;
  const copy = post ?? blogIndexCopy(locale);
  const url = origin + (post?.path ?? blogIndexPath(locale));
  return {
    title: { absolute: post ? `${copy.title} | Quizeey` : copy.title }, description: copy.description,
    robots: { index: publicProduction, follow: publicProduction },
    ...(publicProduction ? { alternates: { canonical: url } } : {}),
    openGraph: { title: copy.title, description: copy.description, siteName: 'Quizeey', locale: locale === 'en' ? (post?.slug === cloudPost.slug ? 'en_US' : 'en_CA') : 'ko_KR',
      ...(publicProduction ? { url } : {}),
      ...(post ? { type: 'article', publishedTime: post.date, modifiedTime: post.modified } : { type: 'website' }),
    },
    twitter: { card: 'summary', title: copy.title, description: copy.description },
  };
}

export function blogSitemap(origin: string): MetadataRoute.Sitemap {
  const indexEntries = (['ko', 'en'] as const).map(locale => ({
    url: origin + blogIndexPath(locale),
    lastModified: blogPosts.filter(post => locale === 'ko' || post.locale === locale).map(post => post.modified).sort().at(-1)!,
  }));
  return [...indexEntries,
    ...blogPosts.map(post => ({ url: origin + post.path, lastModified: post.modified }))];
}

export function blogStructuredData(origin: string, post?: BlogPost, locale: Locale = 'ko') {
  locale = post?.locale ?? locale;
  const copy = post ?? blogIndexCopy(locale);
  const url = origin + (post?.path ?? blogIndexPath(locale));
  return {
    '@context': 'https://schema.org', '@graph': [
      { '@type': post ? 'BlogPosting' : 'CollectionPage', '@id': url + '#content', url,
        ...(post ? { headline: copy.title, datePublished: post.date, dateModified: post.modified,
          mainEntityOfPage: url, author: { '@type': 'Organization', name: 'Quizeey', url: origin + (locale === 'en' ? '/en/about' : '/about') },
          publisher: { '@type': 'Organization', name: 'Quizeey', url: origin },
        } : { name: copy.title }),
        description: copy.description, inLanguage: locale === 'en' ? 'en' : 'ko-KR', isAccessibleForFree: true,
        breadcrumb: { '@id': url + '#breadcrumb' },
      },
      { '@type': 'BreadcrumbList', '@id': url + '#breadcrumb', itemListElement: [
        { '@type': 'ListItem', position: 1, name: locale === 'en' ? 'Practice exams' : '홈', item: origin + (locale === 'en' ? '/en' : '/') },
        { '@type': 'ListItem', position: 2, name: locale === 'en' ? 'Blog' : '블로그', item: origin + blogIndexPath(locale) },
        ...(post ? [{ '@type': 'ListItem', position: 3, name: post.title, item: url }] : []),
      ] },
    ],
  };
}
