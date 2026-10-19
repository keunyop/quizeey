export type Choice = { id: string; text: string; correct: boolean; position: number };
export type Question = {
  id: string; testId: string; locale: "ko" | "en"; version: number; versionName: string;
  text: string; explanation: string|null; choices: Choice[]; preserveOrder: boolean;
  questionNumber?: number; reference?: string | null; authored?: boolean;
};
export function grade(question: Question, selected: string[]): boolean {
  const ids = new Set(selected);
  if (ids.size !== selected.length || !ids.size) return false;
  if (selected.some((id) => !question.choices.some((choice) => choice.id === id))) return false;
  const correct = question.choices.filter((choice) => choice.correct).map((choice) => choice.id);
  return correct.length > 0 && correct.length === ids.size && correct.every((id) => ids.has(id));
}
export function shuffleChoices(question: Question, random = Math.random): Question {
  if (question.preserveOrder) return { ...question, choices: [...question.choices].sort((a, b) => a.position - b.position) };
  const choices = [...question.choices];
  for (let i = choices.length - 1; i > 0; i--) {
    const j = Math.floor(random() * (i + 1));
    [choices[i], choices[j]] = [choices[j], choices[i]];
  }
  return { ...question, choices };
}
