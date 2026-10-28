import { notFound } from 'next/navigation';
import { StudyGuideView } from '@/components/StudyGuides';
import { environment } from '@/lib/environment';
import { findStudyGuide, studyGuideMetadata } from '@/lib/study-guides';

type Props = { params: Promise<{ slug: string }> };

export async function generateMetadata({ params }: Props) {
  const guide = findStudyGuide((await params).slug);
  if (!guide) notFound();
  const env = environment(process.env);
  return studyGuideMetadata(env.origin, env.stage === 'production' && !env.protectedReview, guide);
}

export default async function Page({ params }: Props) {
  const guide = findStudyGuide((await params).slug);
  if (!guide) notFound();
  return <StudyGuideView guide={guide} />;
}
