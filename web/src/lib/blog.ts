import type { Metadata, MetadataRoute } from 'next';

export const blogPost = {
  slug: 'sqld-cbt-study-guide',
  title: 'SQLD 기출문제 CBT 공부법: 풀이·해설·오답 복습 3단계',
  description: 'SQLD 기출문제 CBT를 풀 때 답만 외우지 않는 3단계 복습법. COUNT와 NULL 예제로 정답의 근거를 확인하고, 무료 SQLD 문제풀이로 바로 연습하세요.',
  date: '2026-11-02',
  category: 'SQLD · 문제풀이 가이드',
  practicePath: '/sqlp-developer',
} as const;
export const blogPath = '/blog';
export const blogPostPath = `${blogPath}/${blogPost.slug}`;
export const blogIndex = { title: 'Quizeey 블로그: 예제로 배우는 자격증 공부', description: '헷갈리는 자격증 개념을 짧은 예제와 확인 문제로 정리하세요. 이해한 개념은 Quizeey 문제풀이로 바로 연습할 수 있습니다.' };

export function blogMetadata(origin: string, publicProduction: boolean, article = false): Metadata {
  const copy = article ? blogPost : blogIndex;
  const url = origin + (article ? blogPostPath : blogPath);
  return {
    title: { absolute: article ? `${copy.title} | Quizeey` : copy.title }, description: copy.description,
    robots: { index: publicProduction, follow: publicProduction },
    ...(publicProduction ? { alternates: { canonical: url, languages: { ko: url, 'ko-KR': url } } } : {}),
    openGraph: { title: copy.title, description: copy.description, siteName: 'Quizeey', locale: 'ko_KR',
      ...(publicProduction ? { url } : {}),
      ...(article ? { type: 'article', publishedTime: blogPost.date, modifiedTime: blogPost.date } : { type: 'website' }),
    },
    twitter: { card: 'summary', title: copy.title, description: copy.description },
  };
}

export function blogSitemap(origin: string): MetadataRoute.Sitemap {
  return [blogPath, blogPostPath].map(path => ({ url: origin + path, lastModified: blogPost.date, alternates: { languages: { ko: origin + path, 'ko-KR': origin + path } } }));
}

export function blogStructuredData(origin: string, article: boolean) {
  const copy = article ? blogPost : blogIndex;
  const url = origin + (article ? blogPostPath : blogPath);
  return {
    '@context': 'https://schema.org', '@graph': [
      { '@type': article ? 'BlogPosting' : 'CollectionPage', '@id': url + '#content', url,
        ...(article ? { headline: copy.title, datePublished: blogPost.date, dateModified: blogPost.date,
          mainEntityOfPage: url, author: { '@type': 'Organization', name: 'Quizeey', url: origin + '/about' },
          publisher: { '@type': 'Organization', name: 'Quizeey', url: origin },
        } : { name: copy.title }),
        description: copy.description, inLanguage: 'ko-KR', isAccessibleForFree: true,
        ...(!article ? { breadcrumb: { '@id': url + '#breadcrumb' } } : {}),
      },
      { '@type': 'BreadcrumbList', '@id': url + '#breadcrumb', itemListElement: [
        { '@type': 'ListItem', position: 1, name: '홈', item: origin + '/' },
        { '@type': 'ListItem', position: 2, name: '블로그', item: origin + blogPath },
        ...(article ? [{ '@type': 'ListItem', position: 3, name: blogPost.title, item: url }] : []),
      ] },
    ],
  };
}
