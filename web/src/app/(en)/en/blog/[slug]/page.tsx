import { notFound } from 'next/navigation';
import { BlogView } from '@/components/Blog';
import { blogMetadata, findBlogPost } from '@/lib/blog';
import { environment } from '@/lib/environment';

type Props = { params: Promise<{ slug: string }> };
export async function generateMetadata({ params }: Props) {
  const post = findBlogPost((await params).slug, 'en');
  if (!post) notFound();
  const env = environment(process.env);
  return blogMetadata(env.origin, env.stage === 'production' && !env.protectedReview, post);
}
export default async function Page({ params }: Props) {
  const post = findBlogPost((await params).slug, 'en');
  if (!post) notFound();
  return <BlogView post={post} />;
}
