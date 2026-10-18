import type { Question } from "./quiz";

// Original synthetic compatibility fixtures. Never authorized as production archive content.
export const fixtureVersion = "synthetic-v1";
export const questions: Question[] = [
  {
    id: "900000001", testId: "5", locale: "ko", version: 1, versionName: "SQL 기본",
    text: "<p>다음 SQL의 실행 결과는 무엇인가요?</p><pre><code>SELECT COUNT(*) FROM sample;</code></pre><table><caption>sample</caption><thead><tr><th scope=\"col\">id</th></tr></thead><tbody><tr><td>1</td></tr><tr><td>2</td></tr></tbody></table>",
    explanation: "<p>COUNT(*)는 모든 행의 수를 반환하므로 결과는 2입니다.</p>", preserveOrder: false,
    choices: [{ id: "910000001", text: "1", correct: false, position: 1 }, { id: "910000002", text: "2", correct: true, position: 2 }, { id: "910000003", text: "NULL", correct: false, position: 3 }],
  },
  {
    id: "900000002", testId: "5", locale: "ko", version: 1, versionName: "SQL 기본",
    text: "<p>관계형 데이터베이스에 대한 올바른 설명을 모두 선택하세요.</p><img src=\"/fixtures/relation.svg\" alt=\"id 열과 name 열을 가진 두 행의 테이블\" width=\"400\" height=\"160\">",
    explanation: "<p>기본 키는 행을 고유하게 식별합니다. 외래 키는 테이블 사이의 참조 무결성을 유지합니다.</p>", preserveOrder: true,
    choices: [{ id: "910000004", text: "기본 키는 행을 고유하게 식별한다.", correct: true, position: 1 }, { id: "910000005", text: "외래 키는 참조 무결성을 유지한다.", correct: true, position: 2 }, { id: "910000006", text: "모든 열은 기본 키여야 한다.", correct: false, position: 3 }],
  },
  {
    id: "900000003", testId: "5", locale: "ko", version: 2, versionName: "SQL 조건",
    text: "<p>SQL에서 NULL을 검사하는 조건은 무엇인가요?</p>", explanation: "<p>NULL 검사는 IS NULL 조건을 사용합니다.</p>", preserveOrder: false,
    choices: [{ id: "910000007", text: "value = NULL", correct: false, position: 1 }, { id: "910000008", text: "value IS NULL", correct: true, position: 2 }],
  },
  {
    id: "900000004", testId: "1", locale: "en", version: 1, versionName: "Cloud fundamentals",
    text: "<p>Which practice protects an application secret?</p>", explanation: "<p>Keep secrets on the server and grant only the permissions required.</p>", preserveOrder: false,
    choices: [{ id: "910000009", text: "Include it in a public JavaScript bundle.", correct: false, position: 1 }, { id: "910000010", text: "Keep it in a server-side secret store.", correct: true, position: 2 }],
  },
];

export function getQuestions(testId: string, locale: "ko" | "en", version = 0) {
  return questions.filter((q) => q.testId === testId && q.locale === locale && (!version || q.version === version)).slice(0, 20);
}
