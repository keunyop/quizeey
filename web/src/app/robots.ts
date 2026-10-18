import type { MetadataRoute } from 'next';
import { environment } from '@/lib/environment';
export default function robots():MetadataRoute.Robots{
  const env=environment(process.env);
  return env.stage==='production'&&!env.protectedReview?{
    rules:{userAgent:'*',allow:'/',disallow:['/admin','/en/admin','/api/']},sitemap:env.origin+'/sitemap.xml',
  }:{rules:{userAgent:'*',disallow:'/'}};
}
