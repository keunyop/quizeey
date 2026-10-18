# 데이터 이전 계약

**현재 검증 기준은 [live-source-schema.sql](live-source-schema.sql)과 승인된 원본6개 테이블이다.** [source-reconciliation.md](source-reconciliation.md)에 실제 MySQL5.7.30·UTC·컬럼·중복/고아·정답 예외를 기록했다. 아래 제공 DDL/직접 접속 실패는 초기 조사 이력이다. raw 보존과 공개 serving ETL을 구분하며 기존 ID를 임의 병합하지 않는다.

새 서비스 입력: 사용자가 오류751문항 삭제를 확인했고 정확한 ID 집합 해시로 제외한 `new-service-dataset.json`을 사용한다. 원본 snapshot/`quizeey_legacy`에는 전체 데이터를 유지한다. `quizeey_content`의 exams/version/question/choice는 원본 PK를 그대로 사용하고, source의 검증된 유일 composite key로 version_id/question_id FK를 결정한다. 시험·언어별 경로는 별도 계약이며 slug를 강제로 unique로 만들거나 영어 번역을 자동 생성하지 않는다. UTC 날짜·nullable본문·정답 ID·누적통계는 전체 값 해시로 대사한다. 원본 사용자 해설2,183개는 source ID를 보존한 native forum import 대상으로 남아 있으며 core 콘텐츠5테이블에 누락을 감추어 합치지 않는다.

**사용자 제공 DDL 5개를 수신했지만 현재 운영 스키마와의 일치는 미검증이다.** 다음은 JPA/서비스와 제공 DDL의 비교이며 운영 PostgreSQL 스키마 확정이 아니다. 원문 JSON staging과 충돌 검사를 구현하고 실제 SHOW CREATE/표본 검증 후 최종 제약을 적용한다.

제공 DDL은 [owner-supplied-schema.sql](owner-supplied-schema.sql)에 자격 증명 없이 보존했다. `example.answer` ↔ 소스 `answer_yn`, `question.is_multi_answer` ↔ 소스 `multi_answer_yn` 차이가 있다. 제공 `test`에는 소스의 `test_nm_eng/url/inqr_seq`가 없고 `explanation` 테이블 DDL도 없다. engine/charset/collation/timezone/FK/secondary index는 제공되지 않았다. 오래된 초기 DDL일 가능성은 추론이며 사실로 확정하지 않는다.

감사 도구는 두 flag 이름을 원문 그대로 유지하면서 Y/N 정답 집합을 검증한다. 양쪽 이름이 상충하거나 알 수 없는 값이면 변환을 차단한다. 테이블뿐 아니라 시험·버전별 question/choice/counter/correct-set 해시도 대사한다. 누락 테이블을 임의로 빈 데이터라고 처리하지 않는다.

사용자가 소스의 연결 주소를 재확인했다. 소스 계정 1회 및 사용자가 추가로 요청한 master 계정 1회 모두 연결 단계 `1130/HY000`으로 거부됐다. 실제 metadata/row 조회는 0이며 [접속 근거](legacy-schema-access-master.json)에 값 없이 기록했다. TLS verify-full을 설정했으며 검증을 우회하지 않았다. 해당 주소는 RDS 호스트명 형식이 아니고 AWS 인스턴스 `quizeey`와의 관계는 미확인이다. 현재 허용된 호스트/터널을 통한 읽기 전용 접근이 필요하다.

사용자의 소스 직접 조사 요청에 따라 추가 확인했다. `util/sql.sql`은 738,231바이트, question INSERT 502개/example INSERT 2,126개이며 CREATE/ALTER TABLE 0개다. question의 quest_id와 example의 exmp_id를 지정하지 않아 운영 auto-generated ID를 복원할 수 없다. `resources/dumps/수질환경산업기사@industrial-engineer-water-pollution-environmental@2020-08-22.txt`도 질문 원문 형식이며 운영 PK/DDL/전체 snapshot이 아니다. Disqus XML export는 발견되지 않았다. 해시와 컬럼 근거는 [source-data-evidence.json](source-data-evidence.json)에 있다. 생성기는 운영 디렉터리 파일을 읽고 처리 후 삭제하는 경로가 있어 감사/복원 도구로 실행하지 않았다.

| 소스 entity | 보존 ID | 발견한 관계/주의사항 |
| --- | --- | --- |
| Test | testId | testNm/testNmEng/url/inqrSeq; 경로와 ID가 반드시 1:1은 아님 |
| Version | verId | testId + verNbr로 조회, verNm; 복합 중복 조사 필요 |
| Question | questId | testId/verNbr/questNbr, HTML questTxt/explanation/reference, multiAnswerYn |
| Example | exmpId | testId/verNbr/questNbr로 문제에 연결; exmpNbr가 보이는 순서, answerYn이 정답 |
| Explanation | explId | questId, userNm, explanation; HTML/XSS·기존 노출 권한 조사 |
| QuestionStats | questId | correct/inCorrect 원본 보존; 기존 read-modify-write 경쟁 가능 |
| BaseTimeEntity | 해당 없음 | JPA는 LocalDateTime. 실제 MySQL system UTC/반출 session +00:00 확인; 원본 TIMESTAMP 현재 값 보존. created_date도 ON UPDATE라 최초 생성 시각 복구 불가 |

발견한 경로 충돌: 요리 5경로 → testId14; 산업기사 전기공사/공조냉동 → testId140. 잘못된 매핑인지 공유 데이터인지 live DB/운영 확인이 필요하다. 새 URL이나 ID를 임의로 할당하지 않는다.

추가 운영 증거: 한국어 `/tests`는 181개 항목을 반환하며, 공조냉동 경로는 목록에서 testId141이지만 실제 페이지의 `#testId`는 소스와 같은 140이다. 두 근거를 [catalog-reconciliation.json](catalog-reconciliation.json), [catalog-route-probe.json](catalog-route-probe.json)에 보존했다. 이전 중 140을 141로 조용히 바꾸거나 141을 140으로 병합하지 않는다. 실제 문항 대사와 명시적인 매핑 결정이 필요하다. 목록의 `/@ccna-300-115`, `/microsoft-az-500`는 현재 공개 GET 404여서 새 정상 페이지나 redirect를 만들지 않았다.

ID는 64비트 정수의 십진 문자열로 처리한다. choice 정답은 ID 집합으로 비교한다. shuffle 후 화면 A/B/C는 ID가 아니다. 순서 의존 문구의 표시는 원본 순서를 유지한다. 최종 import에는 test/version/question/choice/explanation의 ID 또는 unique legacy mapping, sequence reset, orphan/duplicate 검사, 시험·버전별 count/hash/correct-set 대사, 이미지/PDF 파일별 SHA-256 manifest를 포함한다.

현재 로컬 synthetic fixture는 새로 작성한 4문항이며 운영 문제/수량/권리의 증거가 아니다. 운영 출판은 차단한다. 외부 hotlink는 이전 권한/호스트 manifest 확인까지 새 런타임 sanitizer에서 허용하지 않는다. 이미지 누락을 해결하기 전 운영 호환성이 통과했다고 표시하지 않는다.

Disqus: `questionbank-2`, 기존 JS의 thread URL은 `http://quizeey.com/test/{questId}`. 이는 WebController에서 발견된 페이지 경로가 아니며 SEO redirect 근거로 사용하지 않는다. source thread/post IDs, parent, timestamp, visibility와 원본 export 해시를 보존한다. 삭제/스팸/비공개 글은 공개 import 제외. 이메일/IP/Auth 계정/이름 기반 소유권은 이식하지 않는다.
