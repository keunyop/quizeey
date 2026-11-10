# 구현과 확인 경계

2026-11-09 코드·문서·읽기 API 조사. 구형 문서의 최신/미배포 표현은 당시 상태이며 현재 운영 상태를 뜻하지 않는다.

| 영역 | 확인된 사실과 한계 |
| --- | --- |
| 스택 | [package.json](../../web/package.json): Node24, Next16.4.2, React19.3.1, TS6, Tailwind4, Supabase JS/PostgreSQL |
| 구조 | web 앱/공개 콘텐츠, supabase migration/검증, tools/content 제작 도구, docs/modernization 전환 이력, docs/seo 기존 글/조사 |
| 배포 | [vercel.json](../../web/vercel.json) master Git 배포/개발 branch 자동배포 차단/cleanup cron 선언. 이번 배포 없음. cron 성공 여부 미확인 |
| 검증 | [local-workflow.ts](../../web/scripts/local-workflow.ts) fixture/운영 변수 제거/자동dotenv 거부/광고 비활성. [CI](../../.github/workflows/modernization.yml)는 DB/Auth fixture 구성, push는 modernization/** 조건 |
| 콘텐츠 DB | exams→versions→questions→choices, choice.correct, nullable explanation/reference. 현재 schema·집계 조회 성공. 문항 locale/번역 테이블 없음 |
| 자체 제작 | [authored-practice.ts](../../web/src/lib/authored-practice.ts): 첫 choice 정답, 표시 회전, 한글 포함으로 언어 추론. 개별 난이도/검수자/검수상태 필드 부족 |
| 로컬 콘텐츠 | 10월+11월 2,201레코드(한글포함734/그외1,467), 공유 시험배정 포함2,534. 완전동일 본문중복0/빈해설0은 사실성 검수가 아님. 운영DB와 중복 제거한 총수 아님 |
| 카탈로그 | [exam-catalog.json](../../web/src/data/exam-catalog.json) 209개; locale en24/all5/ko1/미명시179. 국가별 사용자·콘텐츠 분포와 다름 |
| 학습 | 검색/분야/정렬/즐겨찾기→회차/개수/랜덤→답제출/해설→오답/미응답/북마크 복습, 브라우저 자동저장·재개 구현 |
| 신고 | private visitor_submissions(피드백/오답), forum_reports(댓글), moderation_audit(이력). open/resolved만 저장하므로 세부 처리 단계는 비공개 운영기록 병행 |
| 관리자 | 서버 세션/allowlist/ID로그인/Origin/재전송키/속도제한, 승인/숨김/삭제/잠금/해결/다시열기 구현. 이번 실제 로그인 E2E 미검증 |
| 복구 | [rollback-runbook](../modernization/rollback-runbook.md) 및 로컬 dump/restore 코드. 운영 backup/PITR/보존기간/RPO/RTO·최근 복원 성공 미확인 |
| 관측 | Vercel 로그 접근 성공, 7일은 보존 제한. 일반503과 error boundary 공백은 코드 관찰, 실제 장애 발생 증거 아님 |
| SEO/광고 | canonical/hreflang/sitemap/robots/구조화 데이터, 문항직접URL noindex. 동의·origin guard, balanced_v1, 지연 슬롯. 현재 색인/CWV/광고계정 설정은 미확인 |

신규 기능 전에 기존 복습·기록·탐색을 재사용한다. 최근 SQLD/서브넷/클라우드/3D/G1 글은 이미 작성 이력이 있으므로 같은 의도의 글을 중복 생성하지 않는다.
