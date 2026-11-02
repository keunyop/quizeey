import { describe, expect, it } from 'vitest';
import { blogMetadata, blogPost, blogPostPath, blogSitemap, blogStructuredData } from './blog';
import { publicSitemap } from './seo';

describe('blog search publishing', () => {
  it('publishes canonical Korean articles without advertising missing translations', () => {
    const origin = 'https://quizeey.com';
    const metadata = blogMetadata(origin, true, true);
    expect(metadata.alternates).toEqual({ canonical: origin + blogPostPath, languages: { ko: origin + blogPostPath, 'ko-KR': origin + blogPostPath } });
    expect(metadata.robots).toEqual({ index: true, follow: true });
    expect(publicSitemap(origin)).toEqual(expect.arrayContaining(blogSitemap(origin)));
    expect(blogSitemap(origin).every(entry => entry.lastModified === blogPost.date)).toBe(true);
    const data = blogStructuredData(origin, true)['@graph'];
    expect(data[0]).toMatchObject({ '@type': 'BlogPosting', headline: blogPost.title, inLanguage: 'ko-KR', mainEntityOfPage: origin + blogPostPath });
    expect(data[1]).toMatchObject({ itemListElement: [expect.anything(), expect.anything(), { '@type': 'ListItem', position: 3, name: blogPost.title, item: origin + blogPostPath }] });
  });
  it('keeps local and protected builds out of search', () => {
    for (const article of [false, true]) {
      const metadata = blogMetadata('https://quizeey.com', false, article);
      expect(metadata.robots).toEqual({ index: false, follow: false });
      expect(metadata.alternates).toBeUndefined();
    }
  });
});
