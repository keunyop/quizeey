import type { MetadataRoute } from "next";

function xml(value: string) {
  return value.replaceAll("&", "&amp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;")
    .replaceAll('"', "&quot;").replaceAll("'", "&apos;");
}

// Next 16.4 interpolates sitemap URLs directly into XML text and attributes.
// Escape at this serialization boundary; canonical URLs elsewhere stay raw URLs.
export function sitemapXmlEntries(entries: MetadataRoute.Sitemap): MetadataRoute.Sitemap {
  return entries.map(entry => ({
    ...entry,
    url: xml(entry.url),
    ...(entry.alternates?.languages ? { alternates: {
      ...entry.alternates,
      languages: Object.fromEntries(Object.entries(entry.alternates.languages).flatMap(([language, url]) =>
        url === undefined ? [] : [[language, xml(url)]])),
    } } : {}),
  }));
}
