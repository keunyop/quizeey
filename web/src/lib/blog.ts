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
export const blogIndex = { title: 'Quizeey 블로그: 예제로 배우는 자격증 공부', description: '헷갈리는 자격증 개념을 짧은 예제와 확인 문제로 정리하세요. 이해한 개념은 Quizeey 문제풀이로 바로 연습할 수 있습니다.' };

export const subnetPost: BlogPost = {
  slug: 'ipv4-subnetting-practice', path: '/en/blog/ipv4-subnetting-practice', locale: 'en',
  title: 'IPv4 Subnetting Practice: Find the Network, Broadcast and Host Range',
  description: 'Solve /26, /27 and /20 subnetting examples step by step. Check your network address, broadcast and usable hosts, then practise with Network+ questions.',
  date: '2026-11-02', modified: '2026-11-02', category: 'Networking · Worked examples', practicePath: '/en/comptia-n10-009',
};
export const blogPosts = [subnetPost, blogPost];
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
    openGraph: { title: copy.title, description: copy.description, siteName: 'Quizeey', locale: locale === 'en' ? 'en_CA' : 'ko_KR',
      ...(publicProduction ? { url } : {}),
      ...(post ? { type: 'article', publishedTime: post.date, modifiedTime: post.modified } : { type: 'website' }),
    },
    twitter: { card: 'summary', title: copy.title, description: copy.description },
  };
}

export function blogSitemap(origin: string): MetadataRoute.Sitemap {
  const latest = blogPosts.map(post => post.modified).sort().at(-1)!;
  return [...['/blog', '/en/blog'].map(path => ({ url: origin + path, lastModified: latest })),
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
