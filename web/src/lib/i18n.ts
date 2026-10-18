import type { Locale } from "./contracts";

export const messages = {
  ko: {
    search: "자격증 검색", practice: "학습 시작", version: "버전", all: "전체",
    grade: "정답 확인", correct: "정답입니다.", incorrect: "오답입니다.",
    explanation: "해설", next: "다음", previous: "이전", skip: "건너뛰기",
    multiple: "복수 선택", single: "하나 선택", bookmark: "북마크", bookmarked: "북마크 해제",
    complete: "학습 완료", restart: "다시 풀기", resume: "이어서 풀기", mistakes: "오답 복습",
    noMistakes: "복습할 오답이 없습니다.", anonymous: "익명", discussion: "토론",
    unavailable: "문제 자료를 불러올 수 없습니다. 시험 목록에서 다른 시험을 선택해 주세요.",
    storageError: "이 브라우저에 진행 상황을 저장할 수 없습니다.",
    main: "본문으로 이동", home: "시험 목록", select: "보기를 선택해 주세요.",
  },
  en: {
    search: "Search exams", practice: "Start practice", version: "Version", all: "All",
    grade: "Check answer", correct: "Correct.", incorrect: "Incorrect.",
    explanation: "Explanation", next: "Next", previous: "Previous", skip: "Skip",
    multiple: "Select all that apply", single: "Select one", bookmark: "Bookmark", bookmarked: "Remove bookmark",
    complete: "Practice complete", restart: "Try again", resume: "Resume", mistakes: "Review mistakes",
    noMistakes: "No mistakes to review.", anonymous: "Anonymous", discussion: "Discussion",
    unavailable: "Question data is unavailable. Choose another exam from the exam list.",
    storageError: "Progress cannot be saved in this browser.",
    main: "Skip to content", home: "Exams", select: "Select an answer.",
  },
} satisfies Record<Locale, Record<string, string>>;
