import { environment } from '@/lib/environment';
import { publicSitemap } from '@/lib/seo';
import { sitemapXmlEntries } from '@/lib/sitemap-xml';
export default function sitemap(){
  const env=environment(process.env);
  return env.stage==='production'&&!env.protectedReview?sitemapXmlEntries(publicSitemap(env.origin)):[];
}
