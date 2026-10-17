# 빈 스키마 적용 결과

2026-10-16. 사용자가 A+B를 승인하고 샘플 preview 대신 실제 문항 버전을 기다리기로 결정했다.

A는 Supabase `tfkhnrbshvyfmrzxqfmq`에 적용했다. Migration `20261016235602` / `quizeey_schema_preview_candidate_v1`, SQL SHA256 `e39095edb20acce1b999aee0e276c78b1c9317d8b55d2222799acac142200cff`. private 두 schema는 실제 HTTP PGRST106 응답으로 unexposed임을 확인했고, 노출 목록은 public/graphql_public이었다.

적용 후 READ ONLY postflight: 앱15테이블/0행, FORCE RLS·table/sequence/RPC ACL·owner/search_path 전부 통과. public invoker10/private definer11/public definer0. 원본/콘텐츠 업로드0, Vercel 배포0. [cloud-schema-apply-evidence.json](cloud-schema-apply-evidence.json).

Advisor ERROR/WARN은 없고 다음 INFO를 기록했다:

- private/content13테이블의 [RLS enabled, no policy](https://supabase.com/docs/guides/database/database-linter?lint=0008_rls_enabled_no_policy)는 의도된 default-deny다. 경고를 없애려고 허용 정책을 추가하지 않는다.
- [forum_reports.post_id의 FK index](https://supabase.com/docs/guides/database/database-linter?lint=0001_unindexed_foreign_keys)1건은 다음 로컬 private_study_reader migration에 index를 준비했다. 아직 cloud에 적용하지 않았다.
- [미사용 index](https://supabase.com/docs/guides/database/database-linter?lint=0005_unused_index)9개는 새0행 스키마이므로 유지한다.
- [Auth connection allocation](https://supabase.com/docs/guides/deployment/going-into-prod)은 기존10연결 설정의 INFO다. 승인된 signup 한 필드 변경에 성능 설정 변경을 섞지 않는다.

B는 승인됐지만 아직 미적용이다. 연결 도구에는 Auth config GET/PATCH가 없고 기존 로컬 Management token도 없다. owner에게 Dashboard 신규 가입 차단과 Vercel preview-only QUIZEEY_SUPABASE_SECRET_KEY 설정을 요청했다. 비밀값을 채팅에 요청하지 않았다. 최신 readback은 disable_signup=false, email=true, anonymous_users=false이며 Vercel env 목록은 비어 있었다.

실제 콘텐츠 업로드는 별도 질문의 답변 대기다. [preview-content-upload-request.md](preview-content-upload-request.md)의5테이블160,630행만 대상으로 하고 native 사용자 해설/작성자는 제외한다. 현재 private 로컬 batch191개와 전체 값 해시만 준비했으며 원문 출력/네트워크 업로드는0이다. 실제 bounded reader는 로컬에서 개발·검증 중이며 cloud 배포/반출 승인을 대신하지 않는다.
