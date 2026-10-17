# 운영 원본 검증 — 2026-10-16

최신 결정: 사용자가 문제751문항을 **새 서비스 이전 대상에서 삭제하고 원본 백업을 유지**하도록 확인했다. 승인된 ID 집합을 제외한 private `new-service-dataset.json`은26,733문항·107,516선택지·2,183해설·25,870통계다. 원본6개 테이블과 운영 MySQL은 그대로다. 아래 원본 오류 표는 삭제 전 source 상태를 보존한 기록이며, 새 dataset의 관계/정답 검증은 통과했다. [삭제 범위/대사 근거](publication-candidate-evidence.json).

새 콘텐츠 모델의 로컬 리허설도 통과했다. exams181/versions330/questions26,733/choices107,516/legacy_counters25,870을 원본 ID로 매핑하여 FK/unique5테이블에2회 적재하고 백업·복원했다. 전체 값·UTC·ID 및 실제 정답 ID 집합이 일치한다. FK/선택지번호 unique 위반을 실제23503/23505로 거부하고 공개/service 역할 접근42501·sequence를 검증했다. [content-rehearsal-evidence.json](content-rehearsal-evidence.json). 이후 실제 dataset의 보호된 로컬 조회·채점/복원을 검증했고, 사용자 해설2,183개를630개 문항 topic으로 native 로컬 ETL2회·pending RLS·전체 값/ID/UTC 대사·backup restore도 통과했다. [local-content-flow-evidence.json](local-content-flow-evidence.json), [native-explanation-evidence.json](native-explanation-evidence.json). 운영 변경·hosted import/API 공개는 실행하지 않았다.

사용자가 원본 6개 테이블의 로컬 반출을 명시적으로 승인했다. 이전 자동 승인 검토는 전체 행 반출의 명시적 승인이 없다는 이유로 차단했으며, 승인 전에는 집계만 조회했다. 승인 후 운영 서버에서 READ ONLY / REPEATABLE READ 일관 스냅샷을 취득했다. 운영 DB·앱에는 쓰지 않았다.

실제 대상은 `us-west-2`의 EC2 `i-046087bdb8dff10f7`이다. IMDSv2 identity, 실행 Java 프로세스의 localhost:3306 연결, 실제 production config의 대상, SQL VERSION을 대조했다. DB는 **EC2 내부 MySQL 5.7.30**이다. MariaDB는 JDBC 드라이버 이름이었다. 별도 RDS `quizeey` 리소스의 존재·용도는 AWS 계정 조회 전까지 미확인이다.

실행 중 Java가 열고 있는 JAR SHA-256은 `27f09b12f3531519062235d23c51c854bd7c9b296b2d61b3abbef518b610e880`이다. 서버 checkout은 `7e6424c4239a3c8f81ff982aea02d3d7938877e6`; 검토한 `33e8fb7`과 Java/templates Git tree가 동일하다. 실제 JAR의 controller class 2개는 로컬 JDK8 빌드와 일치하고, HBS 218개는 줄바꿈 정규화 후 저장소와 일치한다. 전체 의존성이나 JAR 빌드 commit의 암호학적 증명은 아니다. [배포 대조](deployment-compatibility.json), [실행 근거](ec2-runtime-evidence.json).

| 테이블 | 스냅샷 행수 |
| --- | ---: |
| test | 181 |
| version | 330 |
| question | 27,484 |
| example | 110,387 |
| explanation | 2,209 |
| question_stats | 26,614 |
| 합계 | 167,205 |

스냅샷 시각은 UTC `2026-10-16 19:13:19.072129`, 완료는 `19:13:42.286904`다. NDJSON 51,689,927바이트, SHA-256 `d2048f0f0ac7f22a29820e8bbb6d6ac770bb6f04ca65072467ba62f1531f3405`. 원본과 정규화 JSON, SQL, 상세 보고서는 ignored `.modernization/exports/source-265c3ca16e/`에만 둔다. 폴더의 상속을 차단하고 현재 소유자만 접근하는 ACL을 적용했다. 작성자 이름을 포함하지만 비밀번호·서버 설정은 포함하지 않는다. Git·외부 서비스 업로드는 없다. [반출 근거](source-snapshot-evidence.json).

## 실제 스키마 계약

6개 모두 InnoDB, 테이블 charset `utf8` / collation `utf8_general_ci`, PK 외 FK/unique/secondary index 없음. DB 기본 charset `latin1`과 테이블의 실제 charset을 혼동하지 않는다. 세션 `utf8mb4`, 시간대 `+00:00`으로 읽었으며 원본 문자열에 임의 재인코딩을 하지 않는다. [실제 DDL](live-source-schema.sql), [메타데이터](live-schema-evidence.json), [기계 판독 계약](../../tools/migration/verified_schema.json).

현재 컬럼은 `answer_yn` / `multi_answer_yn`이다. test에는 `test_nm_eng/url/inqr_seq`가 있고 question explanation/reference 폭은 4000/1000이다. explanation 테이블도 실제로 존재한다. 이전 사용자 제공 5개 DDL은 역사 자료이며 현재 스키마를 대신하지 않는다.

원본 `created_date`까지 `ON UPDATE CURRENT_TIMESTAMP`가 설정되어 있다. 이미 덮어쓴 최초 생성 시각은 복구할 수 없으므로 현재 값을 보존한다. explanation.created_date는 NULL 허용. MySQL 시스템 시간대 UTC와 반출 세션 UTC를 확인했지만 새 서비스의 표시 시간대 결정과는 별개다.

## 공개 이전을 막는 기존 데이터 문제

| 검증 종류 | 원본 결과 | 처리 |
| --- | ---: | --- |
| question 복합 키 중복 | 41그룹, 추가 행44개 | 85개 원본 question ID 모두 보존, 정답 연결 미확정 |
| example 복합 키 중복 | 77그룹, 추가 행81개 | 모든 원본 choice ID 보존 |
| question → 없는 test | 596행 | 자동 삭제·시험 재배정 금지 |
| question → 없는 version | 609행 | 자동 버전 생성·재배정 금지 |
| example → 없는 question | 2,438행, 키610그룹 | private 보존, 공개 연결 보류 |
| example → 중복 question 키 | 204행 | 특정 question ID에 임의 연결 금지 |
| question_stats → 없는 question | 18행 | 누적 통계 포함 보존 |
| 정답 집합/단일·복수 flag 불일치 | 656문항 | 문항별 검토 필요 |

문제 분류는 서로 겹친다. 행수나 그룹수를 합산해 총 불량 문항 수로 쓰지 않는다. 선택지 없는 단일 question 키615그룹은 정답 집합 오류와 겹친다. 복수 flag인데 정답 하나인 사례도 자동 수정하지 않는다. 설명의 orphan은 0, PK 중복·잘못된 ID·음수 counter·PostgreSQL 불가 문자 오류는 검출되지 않았다.

내용까지 비교하면 question 중복41그룹 중31그룹은 문항/해설/참고/복수 flag가 같고10그룹은 다르다. choice 번호 중복77그룹 중4그룹은 내용/정답 flag가 같고73그룹은 다르다. ID와 timestamp가 다른 행을 “내용이 같다”는 이유로 버리지 않는다. 검토된 QuestionService 소스는 선택지를 test_id/ver_nbr/quest_nbr로 조회하므로 같은 키의 question ID들에 선택지가 공유된다. 이 기존 조회 후보를 private `relationship-review.json`에 보존했지만 의미상 올바른 연결이나 수정 승인을 뜻하지 않는다. 같은 폴더의 `relationship-review.html`은 원문을 이스케이프하고 외부 요청·스크립트를 차단한 오프라인 검토 자료다.

raw staging은 `(source_table, original_PK)`로 보존하므로 이 관계 오류에도 원본을 잃지 않는다. `audit.py` schema3은 중복 question 키의 정답 집합을 `null`로 기록하고85개 ID를 별도 보고한다. `--allow-raw-relational-errors`는 비공개 원본 보존 SQL에만 적용하며 publication 차단을 해제하지 않는다. 새 서비스는 승인된751문항을 제외한 검증 dataset만 사용하며, migration006의 별도 FK/unique 콘텐츠 모델로 변환한다. 원본 보관용 `quizeey_legacy`를 그대로 공개하지 않는다.

누적 correct 5,986,271 / incorrect 2,337,709는 집계 조회 시점의 lifetime counter다. 월간 사용자 활동·최근 트래픽·사람이 푼 수·수익으로 환산하지 않는다. 운영 쓰기가 계속되므로 이후 최종 snapshot/delta는 별도로 필요하다.

## 남은 실행 범위

원본의 로컬 PostgreSQL 재실행·백업 복원은 최종 typed ETL 및 Supabase 실계정 검증과 구분한다. 관계 예외를 검토하고 이미지/첨부 manifest·Disqus export·공개 HTML sanitizer·전체 경로 본문 대사를 계속 준비한다. 현 앱의 synthetic fixture는 원본으로 자동 교체하지 않는다.

private typed archive migration005와 schema 기반 변환 도구를 추가했다. bigint ID·기존 duplicate/orphan·원본 폭/NULL·counter를 유지하고 TIMESTAMP는 확인된 UTC instant로 변환한다. 5개 identity는 원본 AUTO_INCREMENT 및 maxID보다 뒤로 맞춘다. FK/복합 unique나 공개 권한을 임의 추가하지 않는다. raw JSONB는 원본 문자열 해시를 그대로 보존하고 typed archive는 UTC 의미상 전체 값 해시로 별도 대사한다. 로컬 결과는 [source-rehearsal-evidence.json](source-rehearsal-evidence.json)에 기록한다.

실제 리허설 결과: 원본167,205행의 raw 및 typed 보존을 각2회 재실행하고 백업·복원했다. raw 전체 payload/시험·버전/정답/counter hash와 typed 전체 값/UTC hash가 모두 일치했다. anon/authenticated뿐 아니라 BYPASSRLS인 service_role도 schema/table grants가 없어 접근42501로 거부되며 복원 후 재확인했다. 로컬 서버는 종료했다. 각 스키마를 검사한 import operator는 로컬 superuser이므로 Supabase 실제 운영 role/RLS를 증명하지 않는다. sequence probe는 로컬 미사용 값 하나를 소비하며 PostgreSQL sequence 증가는 rollback되지 않는다. 운영 source sequence에는 접근·변경하지 않았다.

실제 원본144,033개 텍스트 필드의 HTML 구조를 조사했다. table26/pre20, 활성 구조로 해석될 수 있는 object1/meta1, 임의 기술 placeholder가 태그로 해석된82개를 집계했다. 추출 가능한 src/href/style URL 참조는0이었다. 이는 서버 자산 누락이 없다는 증명이나 파일 SHA manifest가 아니다. 기술 문구의 `<...>`를 무조건 제거하면 문제가 변할 수 있어 공개 sanitizer의 본문 보존 검증이 남는다. [타입/HTML 집계](source-contract-evidence.json).

이어진 HTML 검증: attribute가 없는 비표준 기술 token을 문자로 이스케이프한 뒤 기존 sanitize-html 경계를 적용했다. `<CTRL>`·`<AMI-ID>`·generic type의 대소문자를 보존하며 활성 HTML은 그대로 필터링한다. 전체144,033필드에서 정규화8,966개, parsed-text 차이36개는 모두 기술 token 복원이었다. 예상 밖 텍스트 차이0/재정제 차이0/활성 태그·실행 속성 검출0. [learning-html-evidence.json](learning-html-evidence.json). 이 검사는 모든 실제 브라우저 레이아웃·원본 권리·출시 승인 증명이 아니다. 오프라인 본문 검토 HTML은 원본 private 폴더에만 둔다.

참조 구현은 설치된 sanitize-html2.18.1 소스/README를 기준으로 확인했다. 공식 저장소는 [Apostrophe monorepo](https://github.com/apostrophecms/apostrophe/tree/main/packages/sanitize-html)로 이동했고, HTML 요소 분류는 [HTML Standard](https://html.spec.whatwg.org/multipage/indices.html#elements-3)를 참고했다. 기술 token 전처리는 sanitizer를 대체하지 않는다.

DB/DNS 전환은 정확한 대상·revision·백업·예외·RPO/RTO·쓰기 동결·rollback 근거를 갖춘 뒤 별도 확인받는다. AWS 종료도 별도다. EBS/EIP/배치/Docker/DNS/메일 및 다른 서비스 공유 여부는 아직 전체 inventory를 확보하지 않았다.
