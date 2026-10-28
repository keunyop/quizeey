import { expect, it } from 'vitest';
import { authoredSetSummary } from './authored-practice';
import { findRoute } from './contracts';
import { publicSitemap } from './seo';
import { studyGuideMetadata, studyGuidePath, studyGuides } from './study-guides';

it('connects every guide to available English practice and official learning resources', () => {
  for (const guide of studyGuides) {
    for (const item of guide.exams) {
      const exam = findRoute(item.path);
      expect(exam?.locale, item.path).toBe('en');
      expect(exam?.testId, item.path).toBeTruthy();
      expect(authoredSetSummary(exam!.testId!, 'en')?.count, item.path).toBeGreaterThan(0);
    }
    expect(guide.resources.every(resource => new URL(resource.url).protocol === 'https:')).toBe(true);
  }
});

it('publishes canonical guide URLs with reciprocal English alternates and protects fixture metadata', () => {
  const origin = 'https://quizeey.com';
  const sitemap = publicSitemap(origin);
  for (const guide of [undefined, ...studyGuides]) {
    const url = origin + studyGuidePath(guide?.slug);
    const metadata = studyGuideMetadata(origin, true, guide);
    const entry = sitemap.find(item => item.url === url);
    expect(metadata.alternates?.canonical).toBe(url);
    expect(metadata.alternates?.languages).toEqual(entry?.alternates?.languages);
    expect(Object.values(metadata.alternates!.languages!)).toEqual([url, url, url]);
    expect(metadata.robots).toEqual({ index: true, follow: true });
    const fixture = studyGuideMetadata(origin, false, guide);
    expect(fixture.robots).toEqual({ index: false, follow: false });
    expect(fixture.alternates).toBeUndefined();
    expect(fixture.openGraph).not.toHaveProperty('url');
  }
});
