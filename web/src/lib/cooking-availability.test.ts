import { expect, it, vi } from 'vitest';
import source from '../../fixtures/legacy-contract.json' with { type: 'json' };
import catalog from '@/data/exam-catalog.json' with { type: 'json' };
import { authoredQuestions } from './authored-practice';
import { findRoute, legacy, legacyPageRedirect, routesForExam } from './contracts';
import { koreanCookingPath } from './cooking-availability';
import { examCategory, matchesExam } from './exam-catalog';
import { pageStructuredData, publicSitemap, searchMetadata } from './seo';
import { lastSetCookie, sessionCookie } from './practice-session';

it('preserves the original Korean cooking route, IDs and session keys', () => {
  expect(findRoute(koreanCookingPath)).toEqual(source.routes.find(route => route.path === koreanCookingPath));
  expect(routesForExam('14', 'ko').map(route => route.path)).toEqual([koreanCookingPath]);
  expect(legacyPageRedirect('/test', new URLSearchParams('testId=14&verNbr=202611')))
    .toBe(`${koreanCookingPath}?verNbr=202611`);
  expect(sessionCookie('ko', '14', 202611)).toBe('quizeey_session_ko_14_202611');
  expect(lastSetCookie('ko', '14')).toBe('quizeey_last_set_ko_14');
  expect(authoredQuestions('14', 'ko', 202611).length).toBeGreaterThan(0);
});

it('lists and indexes each restored exam under its own identity and actual monthly set', () => {
  const origin = 'https://quizeey.com';
  const sitemap = publicSitemap(origin).map(entry => entry.url);
  for (const [path, testId, name] of [
    ['/craftsman-cook-western-food', '262', '양식조리기능사'],
    ['/craftsman-cook-japanese-food', '263', '일식조리기능사'],
    ['/craftsman-cook-chinese-food', '264', '중식조리기능사'],
    ['/craftsman-cook-blowfish', '265', '복어조리기능사'],
  ]) {
    expect(source.routes.find(route => route.path === path)?.testId).toBe('14');
    expect(legacy.routes.filter(route => route.path === path)).toHaveLength(1);
    const route = findRoute(path)!;
    expect(route).toMatchObject({ testId, title: `${name} 연습문제 - Quizeey`, template: 'authored-practice' });
    expect(examCategory(route)).toBe('service');
    expect(matchesExam(route, name)).toBe(true);
    expect(legacyPageRedirect('/test', new URLSearchParams(`testId=${testId}&verNbr=202611`))).toBe(`${path}?verNbr=202611`);
    expect(sitemap.filter(url => url.startsWith(origin + path))).toEqual([origin + path, `${origin}${path}?verNbr=202611`]);
    expect(searchMetadata(path, new URLSearchParams(), route, origin, true).robots).toEqual({ index: true, follow: true });
    expect(searchMetadata(path, new URLSearchParams('questId=1&verNbr=202611'), route, origin, true).robots).toEqual({ index: false, follow: true });
    expect(JSON.stringify(pageStructuredData(path, new URLSearchParams('verNbr=202611'), route, origin))).toContain('LearningResource');
  }
  expect(sitemap).toContain(origin + koreanCookingPath);
  expect(sitemap).toContain(`${origin}${koreanCookingPath}?verNbr=202611`);
});

it('keeps a former Korean alias out of discovery when its replacement catalog entry is absent', async () => {
  vi.resetModules();
  vi.doMock('@/data/exam-catalog.json', () => ({ default: catalog.filter(exam => exam.id !== '265') }));
  try {
    const path = '/craftsman-cook-blowfish';
    const origin = 'https://quizeey.com';
    const contracts = await import('./contracts');
    const seo = await import('./seo');
    const route = contracts.findRoute(path)!;
    expect(route).toMatchObject({ testId: null, title: '복어조리기능사 문제 제공 안내 - Quizeey', links: [] });
    expect(contracts.legacy.routes.some(candidate => candidate.links.some(link => link.href.split('?')[0] === path))).toBe(false);
    expect(seo.publicSitemap(origin).some(entry => entry.url.startsWith(origin + path))).toBe(false);
    const query = new URLSearchParams('questId=1&testId=14&verNbr=202611');
    expect(seo.canonicalPath(path, query)).toBe(path);
    expect(seo.searchMetadata(path, query, route, origin, true).robots).toEqual({ index: false, follow: true });
    expect(contracts.routesForExam('14', 'ko').map(candidate => candidate.path)).toEqual([koreanCookingPath]);
  } finally {
    vi.doUnmock('@/data/exam-catalog.json');
    vi.resetModules();
  }
});
