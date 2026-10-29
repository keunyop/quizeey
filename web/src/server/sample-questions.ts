import { createHash } from 'node:crypto';
import type { Question } from '@/lib/quiz';

// Match PostgreSQL's rank so archived and authored questions share one lottery.
export function sampleQuestions(questions: Question[], count: number, seed: string) {
  return questions.map(question => ({ question, rank: createHash('md5').update(`${seed}:${question.id}`).digest('hex') }))
    .sort((a, b) => a.rank.localeCompare(b.rank) || a.question.id.localeCompare(b.question.id))
    .slice(0, count).map(item => item.question);
}
