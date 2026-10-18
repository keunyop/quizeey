# 실제 문항 보호 preview의 반출 범위

2026-10-17. 사용자 선택은 샘플 preview를 기다리지 않고 실제 문항 버전을 보는 것이다. **owner가 이 문서 범위의 실제 문항 업로드 + 보호 preview 배포를 명시적으로 승인했으며 실행 중이다.** 기존 A+B 승인은 빈 schema/Auth 변경에만 적용했고, 이번 콘텐츠 승인은 별도로 받았다. 완료 상태는 session-handoff.md와 실행 증거를 확인한다.

대상은 Supabase quizeey `tfkhnrbshvyfmrzxqfmq`/us-west-2의 비공개 `quizeey_content`, 처리·열람 서버는 Vercel `prj_0SVBqfgurtvZErmpMJl01BJkUKOd`의 보호 preview다. 운영 도메인·DNS·EC2 MySQL writer는 유지한다. Vercel에는 코드만 배포하며 실제 문항을 소스/Git/정적 bundle로 올리지 않는다. 원문은 Supabase에 저장하고 보호된 서버 요청에서 필요한 범위만 읽는다.

| 테이블 | 행수 | 포함 범위 |
| --- | --- | --- |
| exams | 181 | 원본 ID, 한/영 시험명, slug, 순서, UTC timestamps |
| versions | 330 | 원본 ID, 시험 관계, 회차/이름, UTC timestamps |
| questions | 26,733 | 원본 ID, 버전 관계, 번호, 본문/기본 해설/reference, 복수 정답 표시, UTC timestamps |
| choices | 107,516 | 원본 ID, 문항 관계, 번호, 본문/정답, UTC timestamps |
| legacy_counters | 25,870 | 문항 ID, 기존 정답/오답 집계, UTC timestamps |
| 합계 | 160,630 | 시험 콘텐츠5테이블만 |

입력은 소유자 전용 로컬 `new-service-dataset.json`. SHA256 `88ed4da320cf3bbd40d65f1aa6de7ba6b81a09f5aa6bbcef1e3860ca58ccb42f`.751문항 제외 ID 집합 SHA256 `425654b55ad190dce415c853c95908521c6de0ed9e2860101d0ae8ac2730c6fd`를 고정한다. [publication-candidate-evidence.json](publication-candidate-evidence.json), [content-rehearsal-evidence.json](content-rehearsal-evidence.json)의 관계/정답/ID/UTC·replay/restore 검증을 입력 gate로 사용한다.

이번 업로드에서 별도 사용자 해설2,183개·작성자 이름·guest ownership은 제외한다. 원본6테이블167,205행 전체, raw/typed archive, 비밀번호/설정/PEM, 소유자 로컬 backup도 제외한다. 원본 MySQL과 원본 backup은 삭제하지 않는다. 실제 콘텐츠의 production 공개·번역·학습 데이터 사용·다른 서비스 전송은 승인 범위가 아니다.

업로드 전 로컬 해시/행수/관계·정답을 재검증하고 테이블 순서대로 명시적 원본 ID upsert를 한다. 각 batch는 transaction과 checkpoint를 사용한다. 실패하면 앱을 열지 않고 읽기 전용 count/hash를 확인해 동일 입력의 idempotent replay만 허용한다. 모든 적재가 끝날 때까지 content는 table/sequence 직접 권한과 anon/authenticated 접근을 차단한다. Git·콘솔·채팅에 문항/작성자 원문을 출력하지 않는다.

처리 후 exact rows/UTC/ID/정답 집합·sequence/FK·전체 값 해시를 대사한다. 새 server-only bounded reader RPC는 service credential만 허용한다. public wrapper는 invoker, 구현은 unexposed private definer이며 실제 본문을 HTTP에 주기 전에 기존 learningHtml을 적용한다. legacy 사용자 해설 API는 native 이전 대기로 응답하고 사용자 글을 빈 공개 게시물로 위장하지 않는다.

Vercel protected preview에는 server-only URL/publishable/secret 키와 정확한 콘텐츠 hash를 preview scope로만 설정한다. secret key는 owner가 Dashboard에서 직접 넣으며 채팅에 보내지 않는다. preview 요청·클라이언트 bundle·로그·캐시 경계·단일/복수 채점·새로고침 복원을 확인한 뒤 링크를 제공한다. 미인가 요청의 실제 문항 차단을 먼저 확인한다. 원본/파생 파일 업로드 금지의 예외는 위 Supabase 저장과 지정 Vercel 서버 처리에만 한정한다.

새 유료 리소스를 만들지 않고 기존 Pro DB/preview 사용량만 쓴다. 실제 usage 비용은 확인하며0원을 보장하지 않는다. runtime/admin key provisioning·가입 차단·backup/권한 검증이 끝나지 않으면 실제 preview를 공개하지 않는다. 콘텐츠나 글을 삭제하는 rollback은 실행하지 않고 접근을 닫아 보존한다.
