import catalog from '@/data/exam-catalog.json' with { type: 'json' };

// These aliases originally reused the Korean cooking exam. Require an explicit replacement.
const legacyCookingAliases: Readonly<Record<string, string>> = {
  '/craftsman-cook-western-food': '양식조리기능사',
  '/craftsman-cook-japanese-food': '일식조리기능사',
  '/craftsman-cook-chinese-food': '중식조리기능사',
  '/craftsman-cook-blowfish': '복어조리기능사',
};
const dedicatedPaths = new Set(catalog
  .filter(exam => exam.replacesLegacyRoute && exam.locale === 'ko')
  .map(exam => `/${exam.slug}`));

export const koreanCookingPath = '/craftsman-cook-korean-food';

export function unavailableCookingExam(path: string): string | undefined {
  return Object.hasOwn(legacyCookingAliases, path) && !dedicatedPaths.has(path) ? legacyCookingAliases[path] : undefined;
}

export function cookingAvailabilityDescription(name: string) {
  return `${name} 문제는 현재 제공하지 않습니다. 이전에 이 주소에 잘못 연결되었던 한식조리기능사 문제는 한식 시험 페이지에서 이용할 수 있습니다.`;
}
