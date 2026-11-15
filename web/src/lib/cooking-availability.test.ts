import { expect, it } from 'vitest';
import source from '../../fixtures/legacy-contract.json' with { type: 'json' };
import { authoredQuestions, authoredSetSummaries } from './authored-practice';
import { findRoute, legacy, legacyPageRedirect, routesForExam } from './contracts';
import { koreanCookingPath, unavailableCookingExams } from './cooking-availability';
import { canonicalPath, pageStructuredData, publicSitemap, searchMetadata } from './seo';
import { lastSetCookie, sessionCookie } from './practice-session';

it('replaces only the four incorrect cooking identities with informational routes', () => {
  for (const [path, name] of Object.entries(unavailableCookingExams)) {
    expect(source.routes.find(route => route.path === path)?.testId).toBe('14');
    const route = findRoute(path)!;
    expect(route.testId).toBeNull();
    expect(route.title).toBe(`${name} 문제 제공 안내 - Quizeey`);
    expect(route.description).toContain('현재 제공하지 않습니다');
    expect(route.links).toEqual([]);
    expect(legacy.routes.some(candidate => candidate.links.some(link => link.href.split('?')[0] === path))).toBe(false);
  }
  expect(findRoute(koreanCookingPath)).toEqual(source.routes.find(route => route.path === koreanCookingPath));
  expect(routesForExam('14', 'ko').map(route => route.path)).toEqual([koreanCookingPath]);
  expect(legacyPageRedirect('/test', new URLSearchParams('testId=14&verNbr=202611')))
    .toBe(`${koreanCookingPath}?verNbr=202611`);
  expect(sessionCookie('ko', '14', 202611)).toBe('quizeey_session_ko_14_202611');
  expect(lastSetCookie('ko', '14')).toBe('quizeey_last_set_ko_14');
  expect(authoredQuestions('14', 'ko', 202611).length).toBeGreaterThan(0);
});

it('excludes base and derived cooking notice URLs from production indexing and sitemap', () => {
  const origin = 'https://quizeey.com';
  const sitemap = publicSitemap(origin).map(entry => entry.url);
  const queries = [new URLSearchParams(), new URLSearchParams('questId=1&testId=14&count=40')];
  for (const set of authoredSetSummaries('14', 'ko')) {
    for (let page = 1; page <= Math.ceil(set.count / 20); page++) {
      queries.push(new URLSearchParams({ verNbr: String(set.version), ...(page > 1 ? { page: String(page) } : {}) }));
    }
  }
  for (const path of Object.keys(unavailableCookingExams)) {
    expect(sitemap.some(url => url.startsWith(origin + path))).toBe(false);
    for (const query of queries) {
      const route = findRoute(path)!;
      const metadata = searchMetadata(path, query, route, origin, true);
      expect(metadata.robots).toEqual({ index: false, follow: true });
      expect(metadata.alternates?.canonical).toBe(origin + path);
      expect(canonicalPath(path, query)).toBe(path);
      expect(JSON.stringify(pageStructuredData(path, query, route, origin))).not.toContain('LearningResource');
    }
  }
  expect(sitemap).toContain(origin + koreanCookingPath);
  expect(sitemap).toContain(`${origin}${koreanCookingPath}?verNbr=202611`);
  expect(searchMetadata(koreanCookingPath, new URLSearchParams(), findRoute(koreanCookingPath)!, origin, true).robots)
    .toEqual({ index: true, follow: true });
});
