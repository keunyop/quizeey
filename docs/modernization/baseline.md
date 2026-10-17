# 기준선

현재 상태: [운영 원본 검증](source-reconciliation.md). SSH/IMDSv2·실행 JAR·DB 연결을 대조해 EC2 내부 MySQL5.7.30과 live DDL6개를 확인했다. 승인된 READ ONLY 스냅샷167,205행을 로컬에 보존했다. 아래 이어진 조사 절의 접속 실패·미확인은 당시 이력이며 최신 상태는 위 보고서와 evidence를 따른다. 전체 AWS 계정·Vercel/Supabase Pro 권한·최종 공개 ETL은 여전히 미검증이다.

사용자 추가 확인: Vercel team ID `team_VSzA796D92aso5IuzUIiOdnb`, Supabase project name `quizeey` / ID `tfkhnrbshvyfmrzxqfmq` / region `us-west-2`. [deployment-targets.json](deployment-targets.json)에 제공값과 API 검증 상태를 분리했다. 실제 계정 연결·Vercel project ID·Supabase org ID·청구·권한은 미확인이다. 기존 대상 식별 정보를 다시 요청하지 않는다.

## 저장소에서 확인한 사실

| 항목 | 결과 |
| --- | --- |
| 시작 상태 | master, 작업 트리 깨끗함; 리뷰 문서의 커밋과 일치 |
| 레거시 | Java 8, Spring Boot 2.4.5, Gradle 6.8.3, JPA, MariaDB JDBC, Handlebars 0.3.0 |
| UI | jQuery/Bootstrap, c3/d3, 시험별 한국어·영어 HBS |
| CI | `.travis.yml`: master Java8 빌드·zip; 실제 배포 대상/배포 커밋은 없음 |
| 기존 새 스택 설정 | package.json, Vercel/Supabase project 연결 파일 없음 |
| 개발 환경 | Windows PowerShell, Node 24.13.0, npm.cmd 11.6.2, Python 3.14, PostgreSQL18 CLI/서비스 |
| Java 실행 | PATH에는 java 없음. workspace 임시 폴더에 공식 Adoptium JDK8을 checksum 검증 후 설치해 Gradle6.8.3 build 성공. compileTestJava/test는 NO-SOURCE. 앱 시작·DB 통합 검증은 하지 않음 |
| 계정 도구 | AWS CLI 있으나 configured profile 없음. Vercel/Supabase CLI·연결 플러그인 없음 |
| 인증 정보 | 추적된 application.yml에 DB 설정이 있음. 이어진 읽기 전용 조사에서 기존 계정과 사용자가 요청한 master 계정을 각 1회 시도했으나 연결 단계 1130으로 거부. 값 출력·새 파일 저장·DB 변경 없음 |

## 운영에서 읽기 전용으로 확인한 사실

`public-probe.json`의 15 URL을 직렬 GET으로 확인했다. 쓰기 API, AJAX 요청, 광고 스크립트 실행, 부하 테스트는 하지 않았다.

- `/`, `/en`, `/kr`, `/app`, SQLD 및 `/kr` 별칭, 영어 AWS, `/test?testId=5`, robots/sitemap/ads.txt/Naver 확인 파일이 200.
- HTTP/HTTPS, www 유무의 홈페이지 4형태 모두 리디렉션 없이 200. 표본 HTML에 canonical link 없음. `https://quizeey.com`은 문서의 목표 origin이며 운영 canonical 정책 확정은 GSC 확인까지 보류한다.
- 표본 주요 제목·설명은 소스와 부합한다. Cloudflare Rocket Loader/Insights가 운영 HTML에 추가된다. 동일한 배포 커밋이라는 증거는 아니다.
- 운영 표본에 UA-66061566-2 및 AdSense 스크립트 존재. GA4 별도 동작/동의 상태/실제 광고 수익은 계정 검증 필요.
- 소스 sitemap 238 loc, controller/내부 링크/static/query 계약을 합쳐 446개 URL 후보. 이 수치는 전체 운영 URL 수나 전체 유기적 유입 범위를 의미하지 않는다.

## 사용자 제공 2026-09 기준선 (USD)

AWS 약 $30/월. Analytics 활성사용자 1,600 / 조회 3,300 / 세션 2,600 / 평균 참여 93초. GSC 클릭 1,110 / 노출 8,060 / CTR 13.8% / 위치 7.5. AdSense PV 2,380 / page RPM $4.12 / 노출 8,750 / 클릭 173 / CPC $0.06 / page CTR 7.28%. 주 유입은 한국.

RPM 기반 추정 매출 $9.8056, AWS 차감 후 약 -$20.19. 지급액으로 검증되지 않았고 CPC 매출을 더하지 않는다. GA views/session 1.27은 문제 풀이 수나 이탈률이 아니다.

## 필요한 운영 증거

사용자가 식별 정보를 추가 제공했다: Vercel 팀 경로 `kevins-projects-e2dcc34c` ([대시보드](https://vercel.com/kevins-projects-e2dcc34c)), Supabase project ref `tfkhnrbshvyfmrzxqfmq` ([API origin](https://tfkhnrbshvyfmrzxqfmq.supabase.co)), **Quizeey 전용**임을 확인했다. 계정 연결이 없어 team UUID, org ID, Pro 청구·리전·권한은 아직 검증되지 않았다. 두 URL의 웹 도구 조회도 접근 불가였다. 다른 제품의 인증/정책이나 데이터에 변경하지 않았다.

1. Vercel Pro team/project ID, 권한·리전·현재 청구, production root/브랜치 연결; Supabase Pro org/project ID·리전·compute/credit 잔여량.
2. 실제 production commit/JAR checksum, AWS 리소스별 inventory·3개월 청구·공유 여부·DNS/메일/배치/외부 API.
3. GSC 16개월 및 최근90일 URL/쿼리·GA4/AdSense 90일 export, 보고 timezone. 출시 직전 최근 기준선도 추가.
4. Live DDL/PK/index/charset/collation와 승인된 원본 스냅샷은 확보. 관계 예외·수정 주기·최종 복구 절차·첨부/이미지 manifest 검증을 계속한다.
5. Disqus 권한 있는 XML export와 쓰기 동결 방법. 실제 `/app` 외부 소비자와 오래 열린 브라우저의 쓰기 차단/전달 경로.

자료가 없는 항목은 미확인으로 유지한다. 운영 데이터와 계정 검증을 fixture 결과로 대체하지 않는다.

## 이어진 조사

사용자 제공 DDL 5개는 [owner-supplied-schema.sql](owner-supplied-schema.sql)에 보존했으며 최신 live DDL임을 증명하지 않는다. 소스와 flag/시험 메타데이터/추가 해설 구조 차이가 있다. 사용자 확인 주소는 RDS hostname 형식이 아니고 AWS instance `quizeey`와의 관계도 아직 미확인이다. 두 계정 모두 1130/HY000, metadata/row 수신 0. 계정/비밀번호 변경만으로 해결됐다고 판단하지 않으며 DB host grants나 네트워크 정책은 변경하지 않았다.

공개 읽기 API 3개는 각각 200, `/tests` 한국어 목록 181개, SQLD 버전 3개, 질문 JSON boolean 필드를 확인했다. 목록과 소스의 공조냉동 시험 ID 차이와 목록만 있고 실제 404인 2개 경로를 추가 기록했다. 공개 질문 표본은 전체 export·ID snapshot이 아니다. 관리 인증/검토·세션 폐기와 about/privacy 원문 보존을 로컬에서 추가 구현했으며 외부 배포·Auth 설정 변경·유료 리소스 생성은 0이다.

사용자의 AWS 호스팅 질문에 따라 공개 IP 목록/PTR을 확인했다. `52.35.43.187`은 AWS `52.32.0.0/14`, `us-west-2`, AMAZON/EC2 서비스 대역이며 PTR은 `ec2-52-35-43-187.us-west-2.compute.amazonaws.com`이다. [legacy-host-evidence.json](legacy-host-evidence.json)에 조회 시각·공식 목록 게시 시각을 기록했다. AWS 네트워크라는 근거이며 실제 운영 앱의 연결 대상·EC2 인스턴스 소유권·RDS 여부를 계정 수준으로 검증한 것은 아니다. [AWS 공식 설명](https://docs.aws.amazon.com/vpc/latest/userguide/aws-ip-ranges.html)처럼 다른 AWS 서비스도 EC2 주소 공간을 사용할 수 있다.

기존에 권한 있는 AWS CLI profile이 준비되면 `tools/modernization/inspect_aws.py --profile <existing-profile>`로 해당 IP의 EC2 인스턴스와 오리건 RDS `quizeey`의 선택된 메타데이터를 읽을 수 있다. 자격 증명을 설정/조회하거나 보안그룹·권한·리소스를 변경하지 않는다. 현재 profile이 없어 실행하지 않았으며 이 좁은 조회만으로 전체 AWS 종료 inventory가 완성되지는 않는다.

이후 사용자가 EC2 `i-046087bdb8dff10f7` (questionbank), Running/3 checks, VPC `vpc-0b3c42198edaed211`, subnet `subnet-0386e4a855e79695d`, SG `sg-0c3c1c9686826401d`를 제공했다. [ec2-inspection.md](ec2-inspection.md)에 기존 접속 수단과 비밀값을 출력하지 않는 조회 절차를 준비했다. 이 인스턴스의 공인 IP와 소스 DB 주소의 일치·MariaDB 설치/앱 실제 설정은 아직 미확인이다. CLI 조사 도구는 이 정확한 instance ID를 기본 대상으로 갱신했다. 로컬에 SSH 키/접속 설정/AWS profile/SSM plugin이 발견되지 않아 현재 서버 접속은 시작하지 않았다.

그 뒤 기존 `questionbank.pem` 파일 경로, launch key pair questionbank, public DNS `ec2-52-35-43-187.us-west-2.compute.amazonaws.com`, SSH user `ec2-user`를 제공받았다. 콘솔 정보로 호스트 주소가 소스 IP와 일치함은 확인했으며 API/IMDS로 인스턴스 identity를 검증한 것은 아니다. 파일 존재 확인 후 SSH1회 시도는 TCP22 timeout으로 인증 전 중단됐다. 추가 네트워크 probe는 22 timeout/3306 reachable + greeting1130이었다. 키 내용 출력·복사/원격 명령/DB query/SG·서버 변경은0. 허용된 SSH 경로 또는 기존 Session Manager 연결이 필요하다.

이후 사용자 제공 SSH `/32` 규칙5개와 현재 공인 IPv4를 대조했다. proxy 없는 AWS checkip/ipify2개가 같은 IP를 반환했으며 제공 목록에 포함되지 않았다. SSH timeout의 유력한 근거이며 AWS API/SSH source flow log 검증은 아니다. TCP22/현재IPv4 `/32` 한 개를 추가하고 조사 후 해당 신규 rule ID만 제거하는 실행안을 준비했다. 실제 IP·기존 client CIDR/설명은 ignored private 폴더에만 보관하며 [ssh-rule-diagnosis.json](ssh-rule-diagnosis.json)에 안전한 요약을 기록했다. AWS API/보안그룹 변경은0이다.
