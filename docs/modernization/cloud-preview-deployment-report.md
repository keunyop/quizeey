# 실제 문항 보호 preview 배포 기록

2026-10-17 America/Vancouver. owner가 승인한 지정 Supabase/Vercel 범위에서 실행했다.

실제 콘텐츠 5테이블160,630행(문항26,733개)의 적재와 전체 값 해시 대사가 모두 통과했다. 191개 원본 배치의 완료 checkpoint와 SQL은 owner-private 폴더에 보관한다. 사용자 해설/작성자 이름/원본 전체 백업은 업로드하지 않았다. [cloud-content-upload-evidence.json](cloud-content-upload-evidence.json).

최종 Vercel 배포 `dpl_ANXS2HUdcsoZeV6z7gPPjPZeJGWX`는 **READY**, API target=`staging`(legacy preview target)이다. 실제 preview URL은 [Quizeey 보호 preview](https://quizeey-13nrq49m1-kevins-projects-e2dcc34c.vercel.app)이다. 빌드 완료 로그, SSO enabled/all_except_custom_domains, 공개 요청302→vercel.com 인증 이동을 확인했다. 앱 Basic 자격증명과 최종 URL은 기존 owner-private `preview-access.txt`에만 보관한다. Supabase 서버 키는 조회하지 않았으며 실제 SDK 조회 성공으로 유효성을 확인했다. 최종 배포의 검증 후15분 error/fatal runtime 집계는0이고 실제 학습 흐름도 아래와 같이 통과했다.

배포에는 명시적 allowlist57개 코드/정적 파일만 전송했다. 최종 전송본의 각 파일과 전체 payload SHA256(`5a6a3835c9fbc7a048560762e7b00a9c97929827a7b8970e1f8523de9706c788`)를 로컬 준비본과 대사했다. 실제 문항은 정적 bundle/소스에 포함하지 않고 서버 전용 reader RPC로 조회한다. 운영 도메인/DNS/AWS writer는 변경하지 않았다. 새 사용자/관리자 계정은0이다.

첫 배포는 target 생략 시 preview라는 API 문서와 달리 production으로 분류됐고, npm ci 오류로 ERROR가 됐다. 앱은 제공되지 않았고 production env에 앱 키를 추가하거나 production guard를 완화하지 않았다. Vercel의 [첫 배포 분류 기록](https://github.com/vercel/vercel/pull/17206)을 확인한 뒤 두 번째 배포에 `target=staging`을 명시해 preview 빌드를 완료했다. [preview-deployment-attempts.json](preview-deployment-attempts.json).

Linux npm ci 오류는 누락된 emnapi 항목3개만 추가해 해결했다. 기존 의존성 버전과 직접 pin은 유지했고 Linux ci dry-run, typecheck/lint/unit58/build가 통과했다.

## 실제 흐름 검증

Vercel 인증을 통과한 실제 브라우저/API 조회·채점·새로고침 검증이 **통과**했다. `tools/modernization/verify_cloud_preview.mjs`로 원본 본문·선택지·정답 대사, 직접 ID beyond20/전체 시험·회차/카운터, 한국어·영어/복수정답 부분선택 오답/채점·복원, 비밀값·정적 앱 bundle·캐시·미인가 접근/admin 차단을 확인했다. 원문/스크린샷/자격증명은 Git·채팅에 출력하지 않았다. [cloud-preview-flow-evidence.json](cloud-preview-flow-evidence.json).

실제 자동 검증에서 회차 선택 상자가390px 모바일 화면을2px 넘는 것을 발견했다. `.version-form select`에 min-width:0/max-width:100%를 적용해 수정·재배포했고 documentWidth=viewport=390을 확인했다. 기존 빌드에 남은 Vercel 협업 툴바는 공식 자동화 헤더/Preview feedback=false 설정 후에도 요청되어, 알려진 플랫폼 요청9개를 전송 전 차단하고 앱 요청과 분리해 기록했다. 외부 앱 요청/브라우저 오류는0이다. 플랫폼 툴바의 자체 동작은 검증 범위가 아니다. [Vercel 자동화 안내](https://vercel.com/docs/vercel-toolbar/managing-toolbar).

최초 임시 링크 생성은 자동승인 검토에서 거절됐으나, 이후 owner가 별도로 **1시간 임시 접근 승인(앱 암호 유지)**을 선택했다. 승인 후에만 생성했고 수정 배포로 대상을 교체할 때 기존 링크를 먼저 폐기·최초 만료시간을 유지했다. 최종 검증 후 임시 링크2개를 모두 폐기했으며 fresh HTTP 요청302→vercel.com 인증 이동으로 차단을 확인했다. owner-private 접근 파일에서도 임시 URL을 제거했다. [cloud-preview-access-evidence.json](cloud-preview-access-evidence.json). owner는 Vercel 계정 로그인과 owner-private 앱 암호로 확인할 수 있다.

## DB advisory 해석

ERROR/WARN0. private/content의 policy 없는 RLS13건은 의도한 default-deny 경계이며 permissive 정책을 추가하지 않는다. [RLS 안내](https://supabase.com/docs/guides/database/database-linter?lint=0008_rls_enabled_no_policy). 미사용 index10건은 아직 사용하지 않은 포럼/관리자 경로의 초기 상태여서 유지한다. [Index 안내](https://supabase.com/docs/guides/database/database-linter?lint=0005_unused_index). Auth 최대10connections 설정은 기존 값으로 유지했으며 운영 전 별도 검토한다. [운영 안내](https://supabase.com/docs/guides/deployment/going-into-prod). 이전 unindexed FK는 reader migration의 reports(post_id) index로 해소했다.
