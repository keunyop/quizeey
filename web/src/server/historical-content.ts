import { expect } from 'vitest';
import content from '@/data/practice-2026-10.json' with { type: 'json' };
import corrections from '../../content/approved-corrections.json' with { type: 'json' };
import { authoredQuestionId } from '@/lib/authored-practice';

type Item = { prompt: string; choices: string[]; explanation: string; source?: string };
type Group = { topic: string; examIds: string[]; source: string; questions: Item[] };

/** Compare older release snapshots after explicitly restoring only approved later corrections. */
export function historicalOctoberGroups(count: number): Group[] {
  const groups: Group[] = structuredClone(content.groups.slice(0, count));
  for (const correction of corrections.corrections) {
    const index = groups.findIndex(group => group.topic === correction.topic);
    if (index < 0) continue;
    const group = groups[index];
    const current = group.questions[correction.questionIndex];
    expect(group.examIds).toContain(correction.examId);
    expect(current, correction.questionId).toBeDefined();
    expect({ prompt: current.prompt, explanation: current.explanation, source: current.source }).toEqual(correction.current);
    const preceding = groups.slice(0, index).filter(item => item.examIds.includes(correction.examId))
      .reduce((total, item) => total + item.questions.length, 0);
    expect(authoredQuestionId(correction.examId, preceding + correction.questionIndex)).toBe(correction.questionId);
    group.questions[correction.questionIndex] = { ...current, ...correction.previous, source: undefined };
  }
  return groups;
}
