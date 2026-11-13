import { describe, expect, it } from 'vitest';
import { blogMetadata, blogPost, blogPostPath, blogPosts, findBlogPost, blogSitemap, blogStructuredData, printingPost, ccnaPost } from './blog';
import { publicSitemap } from './seo';

describe('blog search publishing', () => {
  it('keeps every article identity, language and editorial dates distinct', () => {
    expect(new Set(blogPosts.map(post => post.path)).size).toBe(blogPosts.length);
    for (const post of blogPosts) {
      const url = 'https://quizeey.com' + post.path;
      expect(blogMetadata('https://quizeey.com', true, post).alternates).toEqual({ canonical: url });
      expect(blogStructuredData('https://quizeey.com', post)['@graph'][0]).toMatchObject({ url, datePublished: post.date, dateModified: post.modified, inLanguage: post.locale === 'en' ? 'en' : 'ko-KR' });
      expect(findBlogPost(post.slug, post.locale)).toBe(post);
      expect(findBlogPost(post.slug, post.locale === 'en' ? 'ko' : 'en')).toBeUndefined();
    }
  });
  it('publishes canonical Korean articles without advertising missing translations', () => {
    const origin = 'https://quizeey.com';
    const metadata = blogMetadata(origin, true, blogPost);
    expect(metadata.alternates).toEqual({ canonical: origin + blogPostPath });
    expect(metadata.robots).toEqual({ index: true, follow: true });
    expect(publicSitemap(origin)).toEqual(expect.arrayContaining(blogSitemap(origin)));
    for (const post of blogPosts) expect(blogSitemap(origin)).toContainEqual({ url: origin + post.path, lastModified: post.modified });
    expect(blogSitemap(origin).find(entry => entry.url === origin + '/blog')?.lastModified).toBe('2026-11-12');
    expect(blogSitemap(origin).find(entry => entry.url === origin + '/en/blog')?.lastModified).toBe('2026-11-08');
    expect(findBlogPost(printingPost.slug, 'ko')).toBe(printingPost);
    expect(findBlogPost(printingPost.slug, 'en')).toBeUndefined();
    expect(findBlogPost(ccnaPost.slug, 'ko')).toBe(ccnaPost);
    expect(findBlogPost(ccnaPost.slug, 'en')).toBeUndefined();
    expect(ccnaPost.practicePath).toBe('/ccna-200-301?verNbr=202610');
    const data = blogStructuredData(origin, blogPost)['@graph'];
    expect(data[0]).toMatchObject({ '@type': 'BlogPosting', headline: blogPost.title, inLanguage: 'ko-KR', mainEntityOfPage: origin + blogPostPath });
    expect(data[1]).toMatchObject({ itemListElement: [expect.anything(), expect.anything(), { '@type': 'ListItem', position: 3, name: blogPost.title, item: origin + blogPostPath }] });
  });
  it('publishes the 3D printer article with complete production search metadata', () => {
    const origin = 'https://quizeey.com';
    const metadata = blogMetadata(origin, true, printingPost);
    expect(blogPosts).toContain(printingPost);
    expect(metadata).toMatchObject({
      title: { absolute: `${printingPost.title} | Quizeey` },
      description: printingPost.description,
      robots: { index: true, follow: true },
      alternates: { canonical: origin + printingPost.path },
      openGraph: {
        type: 'article',
        url: origin + printingPost.path,
        publishedTime: printingPost.date,
        modifiedTime: printingPost.modified,
      },
    });
    expect(blogStructuredData(origin, printingPost)['@graph']).toEqual(expect.arrayContaining([
      expect.objectContaining({
        '@type': 'BlogPosting',
        headline: printingPost.title,
        description: printingPost.description,
        datePublished: '2026-11-05',
        dateModified: '2026-11-05',
        mainEntityOfPage: origin + printingPost.path,
        inLanguage: 'ko-KR',
      }),
    ]));
  });
  it('keeps local and protected builds out of search', () => {
    for (const article of [undefined, blogPost]) {
      const metadata = blogMetadata('https://quizeey.com', false, article);
      expect(metadata.robots).toEqual({ index: false, follow: false });
      expect(metadata.alternates).toBeUndefined();
    }
  });
});
