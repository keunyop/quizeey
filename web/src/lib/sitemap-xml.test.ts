import { expect, it } from "vitest";
import { resolveSitemap } from "next/dist/build/webpack/loaders/metadata/resolve-route-data.js";
import { publicSitemap } from "./seo";
import { sitemapXmlEntries } from "./sitemap-xml";

it("escapes paginated canonical and alternate URLs in the installed Next.js XML serializer", () => {
  const entries = publicSitemap("https://quizeey.com");
  const serialized = resolveSitemap(sitemapXmlEntries(entries));
  expect(serialized).not.toMatch(/&(?!amp;|lt;|gt;|quot;|apos;)/);
  expect(serialized).toContain("?verNbr=202610&amp;page=2");
  expect(serialized).not.toContain("&amp;amp;");
  const locations = [...serialized.matchAll(/<loc>([^<]+)<\/loc>/g)].map(match => match[1].replaceAll("&amp;", "&"));
  const alternates = [...serialized.matchAll(/<xhtml:link[^>]+href="([^"]+)"/g)].map(match => match[1].replaceAll("&amp;", "&"));
  expect(locations).toEqual(entries.map(entry => entry.url));
  expect(alternates).toEqual(entries.flatMap(entry => Object.values(entry.alternates?.languages ?? {})));
  expect(entries.some(entry => entry.url.includes("&amp;"))).toBe(false);
});

it("escapes both XML text and attribute delimiters without mutating inputs or the blocked sitemap", () => {
  const url = 'https://example.test/?a=1&b="<x>\'';
  const entries = [{ url, alternates: { languages: { en: url } } }];
  const escaped = sitemapXmlEntries(entries);
  expect(escaped[0].url).toBe("https://example.test/?a=1&amp;b=&quot;&lt;x&gt;&apos;");
  expect(escaped[0].alternates?.languages?.en).toBe(escaped[0].url);
  expect(entries[0].url).toBe(url);
  expect(sitemapXmlEntries([])).toEqual([]);
});
