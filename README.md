# Quizeey

(한글) https://quizeey.com/
(English) https://quizeey.com/en

The idea of Quizeey, pool of quizzes, first came out when I was studying for the AWS Certified Developer - Associate exam.
Most of the time I used my smart phone to study the AWS practice questions which was a PDF file.
It was so hard to see the PDF file through a small phone screen and with an answer placed right under the questions make it hard to concentrate.
So I decided to make a mobile friendly pool of quizzes to study more effectively

현재 v2 앱은 `web/`의 Next.js 앱입니다. v1 Spring Boot 소스·템플릿·Gradle·Travis 설정과 Java 빌드 결과는 제거했습니다. 이전 소스는 Git 이력에서 확인할 수 있습니다.

- `web/`: v2 앱, 정적 자산, 호환 URL·본문 데이터와 테스트
- `supabase/`: v2 데이터베이스 마이그레이션과 보안 검증
- `tools/content/`: v2 문항 생성 도구
- `tools/migration/`, `tools/modernization/`, `docs/modernization/`: 데이터 이전·복원 도구와 전환 근거

## 로컬 개발·검증과 배포 비용

Node.js 24에서 `web` 디렉터리로 이동해 `npm ci`를 실행합니다.

```powershell
cd web
npm run dev:local       # http://127.0.0.1:3000, 샘플 문항으로 개발
npm run test:local      # 단위 테스트
npm run check:local     # 타입·린트·단위·로컬 빌드·브라우저 검증
```

PowerShell 실행 정책이 `npm.ps1`을 차단하면 `npm` 대신 `npm.cmd`를 사용합니다.

브라우저 테스트만 다시 실행할 때는 `npm run test:e2e:local`을 사용합니다. 이 명령은 최신 코드를 로컬에서 빌드한 뒤 `127.0.0.1:3100` 서버를 직접 시작·종료합니다. Windows는 기본적으로 Edge를 사용하며 다른 환경은 Playwright Chromium 설치가 필요합니다. 각 명령은 운영 앱 환경변수를 제거하고 fixture 콘텐츠를 사용합니다. Next가 자동으로 읽는 `.env`, `.env.local`, `.env.production` 등의 파일이 있으면 실행을 중단합니다. 운영 설정은 기존 `.env.forum.production.local`처럼 자동 로드되지 않는 ignored 파일에 보관합니다.

댓글·관리자 통합 테스트에는 기존의 격리된 로컬 PostgreSQL(`127.0.0.1:55432`)과 Auth fixture(`127.0.0.1:55433`)가 필요합니다. 없으면 해당 테스트는 skip으로 표시됩니다. 전체 fixture 초기화 절차는 [.github/workflows/modernization.yml](.github/workflows/modernization.yml)을 참고하세요. GitHub Actions도 해당 runner 안의 로컬 서버·DB를 사용하며 Vercel에서 테스트하지 않습니다. Actions 사용료는 별도입니다.

개발 브랜치에서 변경을 모아 로컬 검증 후 `master`에 한 번 반영합니다. `web/vercel.json`은 개발 브랜치의 자동 Preview 배포를 끄고 `master`의 운영 배포를 유지합니다. 이 설정은 원격에 push한 이후 적용됩니다. `master` push로 배포했다면 같은 변경을 CLI/API로 다시 배포하지 않습니다. 배포 후 운영에서는 변경 경로만 소수의 읽기 요청으로 확인하고 전체 회귀 테스트는 로컬에서 실행합니다.

빌드 비용을 더 줄이는 선택지는 Production 설정으로 `vercel build --prod`를 실행하고 `vercel deploy --prebuilt --prod`로 결과만 올리는 것입니다. 현재 Windows fixture 빌드를 그대로 운영에 올리면 안 됩니다. 운영 환경변수·시스템 변수·Linux 의존성·기존 인증 및 콘텐츠 가드를 검증한 별도의 릴리스 절차가 필요합니다. [공식 prebuilt 안내](https://vercel.com/docs/cli/deploy#prebuilt), [Git 자동 배포 설정](https://vercel.com/docs/project-configuration/git-configuration#git.deploymentenabled).
