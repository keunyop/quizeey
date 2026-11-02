import { BlogView } from '@/components/Blog';
import { blogMetadata } from '@/lib/blog';
import { environment } from '@/lib/environment';

export function generateMetadata() {
  const env = environment(process.env);
  return blogMetadata(env.origin, env.stage === 'production' && !env.protectedReview);
}

export default function Page() { return <BlogView />; }
