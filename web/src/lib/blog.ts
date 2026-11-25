import type { Metadata, MetadataRoute } from 'next';

import type { Locale } from './contracts';

export type BlogPost = { slug: string; path: string; title: string; description: string; date: string; modified: string; category: string; practicePath: string; locale: Locale };

export const blogPost: BlogPost = {
  slug: 'sqld-cbt-study-guide', path: '/blog/sqld-cbt-study-guide', locale: 'ko', modified: '2026-11-16',
  title: 'SQLD 기출문제 CBT 공부법: 풀이·해설·오답 복습 3단계',
  description: 'SQLD 기출문제 CBT를 풀 때 답만 외우지 않는 3단계 복습법. COUNT와 NULL 예제로 정답의 근거를 확인하고, 무료 SQLD 문제풀이로 바로 연습하세요.',
  date: '2026-11-02',
  category: 'SQLD · 문제풀이 가이드',
  practicePath: '/sqlp-developer',
};
export const blogPath = '/blog';
export const baristaMilkSteamingPost: BlogPost = {
  slug: 'barista-2-milk-steaming-microfoam', path: '/blog/barista-2-milk-steaming-microfoam', locale: 'ko',
  title: '바리스타 2급 우유 스티밍에서 큰 기포가 생길 때',
  description: '우유 스티밍의 공기 주입과 회전을 구분하고 큰 기포나 부족한 부피의 원인을 확인 문제 세 개로 익힙니다.',
  date: '2026-11-25', modified: '2026-11-25', category: '바리스타 2급 · 우유 스티밍',
  practicePath: '/barista-2?verNbr=202611',
};
export const sqldNotInPost: BlogPost = {
  slug: 'sqld-not-in-null-not-exists', path: '/blog/sqld-not-in-null-not-exists', locale: 'ko',
  title: 'SQLD NOT IN과 NULL: NOT EXISTS로 바꾸기 전에 확인할 것',
  description: '제외 목록에 NULL이 있으면 왜 0행일까요? TRUE·FALSE·UNKNOWN을 표로 판정하고, 상관 NOT EXISTS와 왼쪽 NULL·빈 서브쿼리의 차이를 세 원본 문제로 확인하세요.',
  date: '2026-11-24', modified: '2026-11-24', category: 'SQLD · NOT IN과 상관 서브쿼리',
  practicePath: '/sqlp-developer?verNbr=202611',
};
export const cookingYieldPost: BlogPost = {
  slug: 'korean-cooking-edible-yield-purchase-weight', path: '/blog/korean-cooking-edible-yield-purchase-weight', locale: 'ko',
  title: '한식조리기능사 가식부 수율: 구입량을 곱할 때와 나눌 때',
  description: '구입량과 손질 후 가식부량을 구분하고 30인분에 필요한 구입량을 역산합니다. 수율·손실률·인분 계산을 원본 세 문제로 확인하고 한식조리 11월 연습으로 이어가세요.',
  date: '2026-11-23', modified: '2026-11-23', category: '한식조리기능사 · 가식부 수율 계산',
  practicePath: '/craftsman-cook-korean-food?verNbr=202611',
};
export const baristaStoragePost: BlogPost = {
  slug: 'barista-2-coffee-storage-freshness', path: '/blog/barista-2-coffee-storage-freshness', locale: 'ko',
  title: '바리스타 2급 원두 보관: 밀폐·차광·분쇄 시점 판단하기',
  description: '같은 원두를 둔 세 장소를 비교하며 밀폐·차광·보관 위치를 함께 판단합니다. 분쇄 시점과 디개싱·산화를 원본 세 문제로 구분하고 바리스타 2급 11월 연습으로 이어가세요.',
  date: '2026-11-22', modified: '2026-11-22', category: '바리스타 2급 · 원두 보관과 분쇄',
  practicePath: '/barista-2?verNbr=202611',
};
export const sqldUnionPost: BlogPost = {
  slug: 'sqld-union-all-duplicate-null', path: '/blog/sqld-union-all-duplicate-null', locale: 'ko',
  title: 'SQLD UNION과 UNION ALL 차이: 중복 행·NULL로 결과 세기',
  description: '같은 여섯 입력 행이 UNION ALL에서는 6행, UNION에서는 3행이 되는 이유를 계산합니다. 선택한 열과 NULL 중복 판정을 세 원본 문제로 확인하고 SQLD 11월 연습으로 이어가세요.',
  date: '2026-11-21', modified: '2026-11-21', category: 'SQLD · UNION과 NULL',
  practicePath: '/sqlp-developer?verNbr=202611',
};
export const printingFirstLayerPost: BlogPost = {
  slug: '3d-printer-first-layer-warping', path: '/blog/3d-printer-first-layer-warping', locale: 'ko',
  title: '3D프린터 첫 층이 안 붙을 때: 노즐 간격·워핑·브림 구분하기',
  description: '첫 선부터 안 붙는 현상과 출력 중 모서리 들뜸을 구분해 보세요. 노즐 간격·워핑·브림의 역할을 원본 세 문제로 확인하고 3D프린터운용기능사 11월 연습으로 이어갑니다.',
  date: '2026-11-20', modified: '2026-11-20', category: '3D프린터운용기능사 · 첫 층과 워핑',
  practicePath: '/craftsman-3D-printer-operation?verNbr=202611',
};
export const ccnaTroubleshootingPost: BlogPost = {
  slug: 'ccna-ipv4-mask-troubleshooting', path: '/blog/ccna-ipv4-mask-troubleshooting', locale: 'ko',
  title: 'CCNA 서브넷 마스크가 다르면? IPv4 설정 점검 순서',
  description: '서로 다른 /26·/24 마스크를 쓰는 두 장비의 판단을 양쪽에서 계산합니다. 주소 범위와 실제 통신을 구분하고 IPv4 설정·경로를 점검한 뒤 한국어 원본 5문제로 연습하세요.',
  date: '2026-11-19', modified: '2026-11-19', category: 'CCNA 200-301 · IPv4 설정 점검',
  practicePath: '/ccna-200-301?verNbr=202611',
};
export const cookingInfectionPost: BlogPost = {
  slug: 'korean-cooking-infection-routes', path: '/blog/korean-cooking-infection-routes', locale: 'ko',
  title: '한식조리기능사 감염병: 경구 감염과 침·비말 전파 구분하기',
  description: '장티푸스·세균성이질·폴리오와 유행성이하선염의 전파 경로를 비교하고, 직접 만든 세 문제로 분변-경구 감염과 침·비말의 단서를 구분해 보세요.',
  date: '2026-11-18', modified: '2026-11-18', category: '한식조리기능사 · 감염병 전파 경로',
  practicePath: '/craftsman-cook-korean-food?verNbr=202610',
};
export const blogPostPath = `${blogPath}/${blogPost.slug}`;
export const blogIndex = { title: 'Quizeey 블로그: 예제로 배우는 자격증 공부', description: '한식조리기능사 위생 판단, CCNA 서브넷 계산, SQLD 등 헷갈리는 자격증 개념을 예제로 정리하고 Quizeey 문제풀이로 연습하세요.' };
export const sqldHavingPost: BlogPost = {
  slug: 'sqld-where-having-group-by', path: '/blog/sqld-where-having-group-by', locale: 'ko',
  title: 'SQLD WHERE와 HAVING 차이: 집계 전 행과 집계 후 그룹 구분하기',
  description: '결제 완료 주문만 모아 팀별 합계를 구할 때 WHERE와 HAVING을 어디에 써야 할까요? 원본 표와 SQL 예제로 결과 차이를 계산하고 SQLD 연습문제로 확인하세요.',
  date: '2026-11-16', modified: '2026-11-16', category: 'SQLD · GROUP BY와 HAVING',
  practicePath: '/sqlp-developer?verNbr=202611',
};

export const sqldLeftJoinPost: BlogPost = {
  slug: 'sqld-left-join-on-where', path: '/blog/sqld-left-join-on-where', locale: 'ko',
  title: 'SQLD LEFT JOIN: ON과 WHERE에 조건을 두면 결과가 달라지는 이유',
  description: '회원과 주문 예제로 LEFT JOIN의 ON과 WHERE 조건 차이를 3행과 1행 결과로 비교합니다. 미매칭 NULL 행과 결제 완료 주문을 구분한 뒤 SQLD 11월 원본 연습문제를 풀어 보세요.',
  date: '2026-11-17', modified: '2026-11-17', category: 'SQLD · LEFT JOIN 조건',
  practicePath: '/sqlp-developer?verNbr=202611',
};

export const makeupHygienePost: BlogPost = {
  slug: 'makeup-eye-cosmetics-hygiene', path: '/blog/makeup-eye-cosmetics-hygiene', locale: 'ko',
  title: '메이크업 필기 위생: 마스카라·테스터·손씻기 판단 연습',
  description: '마른 마스카라에 물을 넣어도 될까요? 눈 화장품 테스터와 손씻기 사례로 손·도구·제품의 위생을 구분하고 미용사(메이크업) 기초 3문제로 확인하세요.',
  date: '2026-11-15', modified: '2026-11-15', category: '미용사(메이크업) · 위생 기초',
  practicePath: '/make-up-artist?verNbr=202610',
};

export const baristaExtractionPost: BlogPost = {
  slug: 'barista-2-espresso-ratio-grind', path: '/blog/barista-2-espresso-ratio-grind', locale: 'ko',
  title: '바리스타 2급 필기: 에스프레소 추출 비율 1:2와 분쇄도 판단',
  description: '원두 18 g에 음료 36 g이면 왜 1:2일까요? 추출 비율 계산과 분쇄도·채널링을 구분하는 원본 예제를 익히고 바리스타 2급 연습문제로 확인하세요.',
  date: '2026-11-14', modified: '2026-11-14', category: '바리스타 2급 · 추출 개념',
  practicePath: '/barista-2?verNbr=202611',
};

export const sqlpPlanPost: BlogPost = {
  slug: 'sqlp-explain-index-seq-scan', path: '/blog/sqlp-explain-index-seq-scan', locale: 'ko',
  title: 'SQLP 실행계획 읽기: 인덱스가 있어도 Seq Scan이 나오는 이유',
  description: 'SQLP 학습을 위한 원본 PostgreSQL 실행계획 사례. 전체 조회, lower() 검색, 다중 열 인덱스의 앞 열 조건을 점검하고 11월 SQLP 문제로 이어가세요.',
  date: '2026-11-13', modified: '2026-11-13', category: 'SQLP · 실행계획과 인덱스',
  practicePath: '/sqlp-professional?verNbr=202611',
};

export const koreanCookingPost: BlogPost = {
  slug: 'korean-cooking-food-safety-cross-contamination', path: '/blog/korean-cooking-food-safety-cross-contamination', locale: 'ko',
  title: '한식조리기능사 필기: 교차오염·보관온도 사례로 익히기',
  description: '한식조리기능사 필기 식품위생을 생닭·오이무침 조리 사례로 익히세요. 교차오염, 손씻기, 냉장 보관 판단을 원본 확인 문제로 연습합니다.',
  date: '2026-11-12', modified: '2026-11-12', category: '한식조리기능사 · 식품위생',
  practicePath: '/craftsman-cook-korean-food',
};

export const ccnaPost: BlogPost = {
  slug: 'ccna-ipv4-subnetting-gateway', path: '/blog/ccna-ipv4-subnetting-gateway', locale: 'ko',
  title: 'CCNA IPv4 서브넷 계산: 주소 범위로 게이트웨이 설정 점검하기',
  description: 'CCNA 200-301 IPv4 서브네팅을 /26·/23·/28 예제로 계산하세요. 네트워크·브로드캐스트·호스트 범위를 찾고 게이트웨이 주소와 마스크를 점검합니다.',
  date: '2026-11-11', modified: '2026-11-19', category: 'CCNA 200-301 · IPv4 서브네팅',
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
export const blogPosts = [baristaMilkSteamingPost, sqldNotInPost, cookingYieldPost, baristaStoragePost, sqldUnionPost, printingFirstLayerPost, ccnaTroubleshootingPost, cookingInfectionPost, sqldLeftJoinPost, sqldHavingPost, makeupHygienePost, baristaExtractionPost, sqlpPlanPost, koreanCookingPost, ccnaPost, roadSignsPost, printingPost, cloudPost, subnetPost, blogPost];
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
