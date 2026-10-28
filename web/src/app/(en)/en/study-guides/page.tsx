import { StudyGuideView } from '@/components/StudyGuides';
import { environment } from '@/lib/environment';
import { studyGuideMetadata } from '@/lib/study-guides';

export function generateMetadata() {
  const env = environment(process.env);
  return studyGuideMetadata(env.origin, env.stage === 'production' && !env.protectedReview);
}

export default function Page() {
  return <StudyGuideView />;
}
