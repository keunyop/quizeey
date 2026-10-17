# 레거시 API 보존 계약

근거: WebRestController, DTO, 서비스, `static/js/app/test.js`, main.js와 [public-read-api.json](public-read-api.json). 실제 배포 커밋/외부 `/app` 소비자는 미확인이다. 소스에서 읽기만 수행함을 확인한 `/tests`, `/versions`, `/question`을 각 1회 직렬 POST 조회해 모두 200을 확인했다. 쓰기 API·광고 요청은 0이다.

| Method/path | 요청 → 응답 | 새 런타임 방침 |
| --- | --- | --- |
| POST /question | testId, verNbr(0=전체), questId nullable → questId/testId/verNbr/verName/questNbr/questTxt/explanation/reference/multiAnswer/examples | bounded batch 기반 어댑터; exact ID·시험 문맥 검사 |
| POST /versions | testId → [{verId,verNm,verNbr}] | 키/정렬을 실제 응답 fixture로 검증 후 유지 |
| POST /tests | languageCd → [{testId,testNm,url}] | 언어·URL 계약 유지 |
| POST /questionStats | questId → {questId,correct,inCorrect} | 읽기 유지; 없는 통계는 기존 DTO 기본값 검증 |
| POST /explanations | questId → [{userNm,explanation,createdDate}] | 승인된 레거시 해설만 공개; datetime 포맷 yyyy-MM-dd HH:mm:ss의 원본 timezone 확인 |
| POST /updateQuestionStats | questId, correct → void | 단일 writer 이후 원자적 집계, idempotency 어댑터; 중복 증가 방지 |
| POST /addExplanation | questId,userNm,explanation → void | 일반 가입 없이 서버 검증·pending moderation으로 변환; 구 클라이언트 응답/상태코드 검증 필요 |
| POST /addQuestion, /addExample | 생성 DTO → Long | 공개 쓰기 유지 금지, 관리자 인증·권한 필요 |
| GET /addTestBatch, /addTestBatchGType, /addVersionBatch, /addVersionBatchGType, /clearCache | 생성/캐시 변경 | 감사 호출 금지; 공개 새 런타임으로 복사 금지 |
| POST /reportWrongAnswer | JS 호출, controller에 없음 | 실제 배포/외부 처리 확인; 성공을 가장하지 않음 |

실제 `/question` 표본에서 JSON `multiAnswer`/choice `answer` boolean과 exmpId/testId/verNbr/questNbr/exmpNbr/exmpTxt를 확인했다. 표본은 testId5/version2/question751/choice4개이며 운영 전체 수량·ID 범위를 증명하지 않는다. `/versions` 표본은 3개, 한국어 `/tests`는 181개다. `/tests.url`은 선행 `/`와 locale prefix 없는 상대 slug다. 이 확인으로 로컬 어댑터의 full path 응답을 수정했다. 원본 질문 본문은 Git ignore 대상 private 폴더에만 있으며 공개 보고에는 shape/count/hash만 남긴다. Java Long은 JS 안전 정수 범위를 넘을 수 있으므로 이전 내부 ID는 문자열로 유지하고 wire 형식은 실제 전체 데이터 범위를 보고 결정한다.

로컬 fixture 어댑터로 POST question/versions/tests/questionStats/explanations를 구현했다. 기존 JS의 testId/questId 문자열과 verNbr 문자열·빈 선택값(전체=0)을 수용한다. `languageCd`는 레거시 kr/en이다. 숫자 wire IDs는 JS safe integer 범위에서만 출력한다. `/tests`는 synthetic content가 있는 시험만 반환하여 충돌하는 legacy ID의 운영 DB URL을 추측하지 않는다. 운영 응답/DB mapping이 확인되기 전 fixture의 버전 ID·조회 목록·초기 통계·빈 사용자 해설은 production으로 사용하지 않는다. old write API/배치/관리 API는 새 환경에서 수락하지 않으며 운영 전환 때 정식 read-only/호환 어댑터의 응답 계약을 검증해야 한다.

현 서비스는 questId 직접 조회 시 testId 일치 검사 없이 가져오고 choices를 매번 섞는다. 새 서비스는 잘못된/타 시험 ID에서 임의 문제로 대체하지 않는다. 잘못된 query는 400, 유효한 형식이지만 없는/다른 문맥 ID는 404로 처리한다. 이는 안전성 계약에 따른 의도된 변경이며 과거 배포의 오류 status와 동일하다고 주장하지 않는다.

구 호스팅과 구 탭의 쓰기는 전환 시 함께 동결해야 한다. DB 이중 쓰기 금지. 어댑터가 완성되고 소비자 검증이 끝나기 전 생산 트래픽을 새 앱으로 옮기지 않는다.
