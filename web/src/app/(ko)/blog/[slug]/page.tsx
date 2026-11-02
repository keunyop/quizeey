import { notFound } from 'next/navigation';
import { BlogView } from '@/components/Blog';
import { blogMetadata, blogPost } from '@/lib/blog';
import { environment } from '@/lib/environment';

type Props = { params: Promise<{ slug: string }> };

export async function generateMetadata({ params }: Props) {
  if ((await params).slug !== blogPost.slug) notFound();
  const env = environment(process.env);
  return blogMetadata(env.origin, env.stage === 'production' && !env.protectedReview, true);
}

export default async function Page({ params }: Props) {
  if ((await params).slug !== blogPost.slug) notFound();
  return <BlogView article />;
}
