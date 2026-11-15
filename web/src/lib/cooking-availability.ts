// These legacy URLs pointed at the Korean cooking exam. No independently
// verified question set exists for the exams named by these four routes.
export const unavailableCookingExams: Readonly<Record<string, string>> = {
  '/craftsman-cook-western-food': '양식조리기능사',
  '/craftsman-cook-japanese-food': '일식조리기능사',
  '/craftsman-cook-chinese-food': '중식조리기능사',
  '/craftsman-cook-blowfish': '복어조리기능사',
};

export const koreanCookingPath = '/craftsman-cook-korean-food';

export function unavailableCookingExam(path: string): string | undefined {
  return Object.hasOwn(unavailableCookingExams, path) ? unavailableCookingExams[path] : undefined;
}

export function cookingAvailabilityDescription(name: string) {
  return `${name} 문제는 현재 제공하지 않습니다. 이전에 이 주소에 잘못 연결되었던 한식조리기능사 문제는 한식 시험 페이지에서 이용할 수 있습니다.`;
}
