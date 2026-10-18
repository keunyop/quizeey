import { environment } from '@/lib/environment';
import { publicSitemap } from '@/lib/seo';
export default function sitemap(){
  const env=environment(process.env);
  return env.stage==='production'&&!env.protectedReview?publicSitemap(env.origin):[];
}
