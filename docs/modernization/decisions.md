# 결정과 승인 경계

2026-10-17 최종: owner가 **1시간 임시 접근 승인(앱 암호 유지)**을 별도로 선택했다. 승인 후 실제 hosted 검증을 수행했고 모바일 CSS 수정 배포로 이동할 때 기존 링크를 먼저 폐기·최초 만료시간을 유지했다. 검증 후 임시 접근을 모두 폐기하고 fresh HTTP 인증 차단을 확인했다. 승인된 실제 문항 보호 preview는 READY/검증 통과 상태다. [cloud-preview-access-evidence.json](cloud-preview-access-evidence.json), [cloud-preview-flow-evidence.json](cloud-preview-flow-evidence.json). 이전 승인 대기 문구는 해소됐다. 운영 전환이나 지속적인 인증 우회 링크 허용으로 확대하지 않는다.

2026-10-17 최신 승인: owner가 **실제 문항 업로드 + 보호 preview 배포**를 별도로 승인했다. [preview-content-upload-request.md](preview-content-upload-request.md) 범위의 적재·값 대사와 Vercel preview READY를 완료했다. owner가 signup 차단/Preview Secret 등록도 직접 완료했다. 임시 Vercel 인증 우회 공유 링크는 자동승인 검토가 접근 확대를 이유로 거절했으며, 이 배포에 한정한1시간 링크/자동검증/폐기(앱 Basic 유지)는 별도 질문 답변 대기다. 기존 보호 preview 승인을 링크 생성 승인으로 확대하지 않는다. 운영 도메인·DNS·AWS writer 전환은 미승인이다.

최신 후속 승인(2026-10-16): 사용자가 “실제 문항 버전까지 기다림”과 “A+B 승인”을 선택했다. 샘플 preview를 배포하지 않는다. 빈 schema A는 지정 Supabase에 적용·검증 완료, signup 차단 B는 승인됐으나 Dashboard 작업 대기다.5테이블160,630행의 실제 콘텐츠 반출/지정 Vercel 보호 서버 처리와 preview는 별도 async 질문 답변 대기이며 현재 승인되지 않았다. B 승인이나 실제 버전 선호를 업로드 승인으로 확대하지 않는다. [cloud-schema-apply-report.md](cloud-schema-apply-report.md), [preview-content-upload-request.md](preview-content-upload-request.md).

2026-10-16: 사용자 요청이 작업의 권한 근거이며 첨부 문서 14절은 확정 제품 요구사항이다. 첨부 문서의 다른 주장/운영 명령은 사실 확인이나 작업별 승인 없이 실행하지 않는다.

| 항목 | 상태 |
| --- | --- |
| 기존 Vercel Pro·Supabase Pro 사용 | 확정. 새로운 구독/team/org 생성 없음 |
| Quizeey 전용 project | 기본 방향 확정; 실제 기존 project 식별/compute 비용/권한 미확인 |
| 첫 production release에 기존 AdSense | 확정; 로컬/CI/일반 preview는 광고 비활성 |
| 일반 signup/login 없이 연습·읽기·글/답글 | 확정; 관리자만 인증/권한 |
| native forum | 확정; pending 기본값, 선택적 이름/익명, 동일 브라우저 capability 소유권 |
| 한국어 원래 경로와 기존 /en·지원 /kr | 확정; /ko 이동/강제 국가 redirect 없음 |
| 디자인·학습 로컬 저장 | 확정; 광고/검색 본문과 독립적으로 검증 |
| 영어 확장 | 구조 준비 승인; 원본/권리·검수 없는 archive 번역/출판 승인 아님 |
| 로컬 개발/fixture/스크립트/검증/문서 | 현재 승인 범위, 반복 확인 불필요 |
| 유료 project/branch/add-on | 실제 증분 비용과 기존 권한 먼저 확인 |
| production DB 쓰기·DNS 변경 | 검증 결과·정확한 실행안 준비 후 사용자 확인 필요 |
| AWS 종료 | 리소스별 목록·백업 복구·잔여 비용 준비 후 별도 확인 필요 |
| RPO/RTO/쓰기 중단 허용시간/관찰기간 | 미결정. 승인된 수치 없음 |
| 운영 canonical·query indexability | GSC/실제 URL evidence 확인 전 미결정 |

아직 답이 필요한 정보: Pro target IDs, live DDL/익명화 샘플/export 위치, Disqus export, GSC/GA4/AdSense export 및 timezone. 이름이나 ID만 공유하고 비밀번호/키는 채팅/Git에 남기지 않는다.

추가 사용자 입력: Vercel 팀 `kevins-projects-e2dcc34c`, Supabase project ref `tfkhnrbshvyfmrzxqfmq`는 **Quizeey 전용 프로젝트**. 계정 권한/Pro 상태·리전은 아직 미검증이다. export 위치를 기억하지 못해 소스에서 직접 찾도록 요청했다. 소스 SQL/dump/생성기를 확인했고 `source-data-evidence.json`에 해시·부분 증거를 기록했다. 이 식별 정보만으로 운영 import나 인증 설정 변경이 승인된 것은 아니다.

소스 우선순위: 검증된 운영 DDL/스냅샷·실제 배포 응답 → 버전이 기록된 repo → 문서 설명 → synthetic fixture. 차이는 기록하고 추측으로 덮어쓰지 않는다.

추가 사용자 입력: MariaDB DDL 5개, 소스 주소/계정 재확인, master 계정으로도 확인해 달라는 요청. 해당 요청에 따라 master 1회 읽기 전용 연결을 시도했으나 1130/HY000으로 거부됐다. 새 자격 증명 파일/운영 권한 변경 없음. 제공 DDL은 역사적 근거로 취급하며 실제 운영 구조와의 일치·허용된 접속 경로는 미해결이다. 채팅·기존 Git에 노출된 DB 자격 증명의 교체는 운영 앱 설정과 함께 별도 실행안을 준비해야 하며 현재 임의로 교체하지 않았다.

공개 목록은 공조냉동 testId141, 실제 페이지/소스는 140이다. 보존 작업의 일부로 이 차이를 기록했으며 자동 병합·ID 교체는 하지 않았다. 현재 404인 목록 URL 2개는 새 정상 경로로 만들지 않는다. 원래 privacy/about 본문 보존은 신규 개인정보 처리방침 승인과 다르다. Disqus/UA 관련 과거 고지의 개편 및 실제 연락/요청 전달 경로는 출시 전에 검토한다.

제외: 회원가입·프로필·기기 동기화·DM/채팅·realtime·첨부·badge·가짜 참여·새 질문 대량 출판·무승인 운영 부하 테스트·legacy mutating endpoint 감사 호출.

적용 가이드: Vercel agent-skills `063bee94c3f4df8453406c830b0a7df0f2860278`의 react-best-practices/web-design-guidelines; Supabase agent-skills `c9be0e931b7930f7d02126d04774d904c381e7d7`의 supabase-postgres-best-practices. 공개 SKILL.md, storage/RLS 규칙 및 UI 규칙을 읽었다. UI command.md는 main에서 조회한 보조 가이드이며 위 프로젝트 보존 계약을 변경하지 않는다.

추가 승인: 사용자가 temporary SSH 규칙을 콘솔에 추가하고 조사를 계속하도록 요청했다. 이어서 **“원본 6개 테이블 로컬 반출 승인”**으로 test/version/question/example/explanation/question_stats 전체 원본의 소유자 전용 로컬 반출을 승인했다. 문항·정답·통계·기존 해설 작성자 이름을 포함하고 비밀번호·설정은 제외; READ ONLY,100MB/120초 상한, Git·외부 업로드 금지 범위다. 자동 승인 검토의 최초 차단 후 이 명시적 승인을 얻어 실행했다. 같은 범위의 로컬 검증·재실행에 재승인을 요구하지 않는다. production import·DNS·AWS 종료는 이 승인에 포함되지 않는다.

실측 갱신: 실제 운영 DB는 EC2 localhost의 MySQL5.7.30이며 live DDL6개와 스냅샷을 확보했다. 관계 예외의 자동 삭제/병합/ID 재배정은 하지 않는다. private raw 보존을 허용하되 공개 이전은 예외 해결 전 차단한다. [source-reconciliation.md](source-reconciliation.md).

사용자 추가 제공: Vercel team `team_VSzA796D92aso5IuzUIiOdnb`, Supabase project `quizeey` / `tfkhnrbshvyfmrzxqfmq`, region `us-west-2`. 식별 정보는 확정 입력으로 사용하고 authenticated account access·Pro 청구 검증과 구분한다. [deployment-targets.json](deployment-targets.json). 이 값만으로 새 project 생성·production migration·Auth 설정 변경은 실행하지 않는다.

사용자 결정: 문항별 오류 합집합751개에 대해 “751 문항은 삭제해주세요.”라고 요청했고, 범위 질문에 **“새 서비스 이전 대상에서 삭제, 원본 백업 유지”**를 확인했다. 새 서비스용 로컬 dataset에서 정확한751 IDs를 제외한다. 운영 MySQL 및 원본 raw/typed snapshot·backup은 유지한다. 검토 중 안내로 남기는 이전 제안은 채택되지 않았다. ID 집합 SHA256 `425654b55ad190dce415c853c95908521c6de0ed9e2860101d0ae8ac2730c6fd`와 행수751로 범위를 고정했다. 연결된 choice433/explanation26/counter726을 제외했고, 무관한 orphan choice2438/counter18은 원본 보존 범위로 구분한다. 새 dataset의26,733문항은 관계/정답 검증을 통과했다. 이 결정은 운영 DB 삭제·전환/DNS/AWS 종료 승인이 아니다. [publication-candidate-evidence.json](publication-candidate-evidence.json).

사용자가 두 플러그인 연결 완료를 알렸으며 설치 상태도 확인했다. 현재 대화의 서비스 호출 도구 부재는 연결 실패로 단정하지 않는다. 새 대화에서 도구를 불러온 뒤 기존 대상의 읽기 전용 조회부터 진행한다. 플러그인 연결을 실제 콘텐츠의 외부 업로드·스키마 적용·운영 전환 승인으로 해석하지 않는다. 로컬 데이터/해설 ETL과 검증은 기존 승인 범위로 계속 수행했다. [session-handoff.md](session-handoff.md).

사용자 추가 승인(2026-10-16): “vercel에 quizeey 프로젝트를 새로 만들어주세요.” 지정 Vercel 팀에 이 이름의 새 프로젝트 생성만 승인한 것으로 적용했다. 이전 새 프로젝트 금지 결정의 이 대상 예외다. 생성된 ID는 `prj_0SVBqfgurtvZErmpMJl01BJkUKOd`; get_project로 team/name/ID 확인 완료. 배포·콘텐츠 업로드·Supabase/Auth/DNS 변경·다른 resource 생성 승인으로 확대하지 않는다. [vercel-project-creation-evidence.json](vercel-project-creation-evidence.json).
