# questionbank EC2 읽기 전용 조사

## 최신 결과

사용자의 임시 SSH 규칙 추가 후 접속에 성공했다. IMDSv2로 instance ID와 region/public IP를 검증했고, 실행 중 JAR·active prod profile·Java DB socket·실제 production 설정을 대조했다. DB는 **EC2 내부 MySQL5.7.30**, 앱 연결은 localhost:3306/quizeey다. [원본 검증](source-reconciliation.md), [runtime](ec2-runtime-evidence.json), [DDL](live-source-schema.sql), [배포 대조](deployment-compatibility.json)를 따른다. 아래 timeout/미확인 설명은 연결 전 조사 이력이다.

기존 PEM은 복사하지 않았다. OpenSSH가 넓은 Windows ACL을 거부해 기존 소유자를 유지하고 해당 PEM만 상속 해제·소유자 Read 권한으로 좁혔다. 원래 ACL SDDL/소유자는 ignored `.modernization/ssh/key-acl-backup.json`에 보관했다. 복구가 필요하면 원래 소유자의 세션에서 해당 파일의 SDDL을 읽어 **백업에 기록된 정확한 PEM 경로 한 개**에 Set-Acl을 적용한다. 키 내용은 읽어 출력하거나 백업하지 않았다.

ED25519 host key를 `.modernization/ssh/known_hosts`에 pin했고 이후 StrictHostKeyChecking=yes를 적용했다. fingerprint는 `SHA256:e4ukUNMB/WTTqUo3WmaVG31fNMBXPH+gDte9ETZpoqo`다. 읽기 스크립트는 SSH stdin으로 전달하여 서버에 파일·패키지를 설치하지 않았다. credentials는 원격 RAM/mysql child 환경에서만 사용하고 로그·명령 인자·내보내기에 포함하지 않았다.

조사 재현은 `python tools/modernization/inspect_ec2.py --phase runtime|schema|aggregates --key <기존-PEM-경로>`다. 원본 반출은 별도 `--phase export --export-mode original`이며 사용자가 승인한 6개 테이블의 로컬 범위 안에서만 사용한다. Windows에서는 원래 소유자 세션이 PEM과 private export 폴더에 접근한다. sandbox 사용자에게 키 권한을 추가하지 않는다.

임시 SSH 규칙의 신규 `sgr-...` ID는 아직 전달되지 않았다. AWS profile이 없어 자동 회수하지 않았다. 추가 원격 inventory에 필요한 동안 유지하고, 조사 완료 후 콘솔에서 설명 `quizeey-modernization-ssh-temporary`인 **신규 규칙만** 식별·제거하고 TCP22 결과를 확인한다. 기존5개 규칙은 유지한다. Docker/배치/HTTP80·443 전달 경로와 AWS 계정 전체 inventory는 아직 미확인이다. 이 사실을 확인하기 전 AWS 종료안을 실행하지 않는다.

## 연결 전 조사 이력

2026-10-16 America/Vancouver. 사용자가 AWS 콘솔에서 제공한 정보이며 CLI/API로 대조한 결과는 아직 아니다.

| 항목 | 사용자 제공 값 |
| --- | --- |
| 리전 | us-west-2 |
| 인스턴스 | i-046087bdb8dff10f7 (questionbank) |
| 상태 | Running, 3/3 checks passed |
| VPC | vpc-0b3c42198edaed211 |
| Subnet | subnet-0386e4a855e79695d |
| Security group | sg-0c3c1c9686826401d (questionbank) |

소스 DB 주소 `52.35.43.187`과 이 인스턴스 공인 IP의 일치는 아직 확인하지 않았다. EC2가 Running이라는 사실이나 이름이 questionbank라는 사실만으로 MariaDB가 이 인스턴스에 설치됐다고 결론내리지 않는다.

로컬에는 OpenSSH/AWS CLI가 있지만 ~/.ssh·AWS profile·Session Manager plugin이 발견되지 않았다. 현재 원격 세션은 시작하지 않았다. 기존 SSH 키의 **경로와 접속 사용자명**, 또는 현재 콘솔의 기존 Session Manager/EC2 Instance Connect 접속 수단이 필요하다. 키 내용·비밀번호를 채팅에 붙이지 않는다.

## 기존 키를 이용한 접속 시도

이후 사용자가 기존 `questionbank.pem`의 로컬 경로와 아래 콘솔 정보를 제공했다. 파일 존재를 확인했으며 키 내용은 출력하거나 복사하지 않았다.

- launch key pair: questionbank
- public DNS: ec2-52-35-43-187.us-west-2.compute.amazonaws.com
- SSH username: ec2-user

해당 호스트에 BatchMode/IdentitiesOnly/ConnectTimeout=8로 SSH 1회 연결을 시도했으나 TCP22 연결이 시간 초과됐다. 키 인증·원격 명령 실행·인스턴스 metadata 검증에는 도달하지 못했다. 저장된 host key 확인을 우회하지 않으며 첫 연결의 known_hosts는 ignored `.modernization/ssh/`를 사용하도록 준비했다.

추가 bounded TCP probe에서 22는 시간 초과, 같은 호스트의 3306은 도달 가능하며 로그인 전 greeting에서 MariaDB 오류1130을 반환했다. [ssh-access-evidence.json](ssh-access-evidence.json)에 시각·상태를 기록했다. 이 probe의 인증·SQL·서버 변경은 모두0이다. 서버 전체 장애나 키 오류로 단정하지 않으며 SSH security group/source CIDR, NACL/경로, SSH 서비스/호스트 방화벽을 구분해야 한다. 기존 Session Manager 접속이 가능하다면 우선 그 경로를 사용한다. 새로운 보안그룹 규칙이나 서비스 재시작은 실행하지 않았다.

DB가 보고한 접속 원본 IP가 포함된 네트워크 진단은 `.modernization/ssh/direct-peer.json`에만 보관했다. 공개 보고/Git에는 방문자·클라이언트 IP를 추가하지 않는다. 아직 인스턴스 내부의 DB 설치/앱 실제 설정은 확인하지 못했다.

## 현재 SSH 허용 목록 대조와 좁은 추가안

사용자가 보안그룹의 SSH/TCP22 인바운드 규칙5개를 제공했다. 모두 특정 IPv4 `/32`이고 현재 직접 HTTPS로 관찰한 공인 IPv4는 어느 규칙에도 포함되지 않았다. 프록시를 명시적으로 끈 AWS checkip/ipify 조회2개가 같은 값을 반환했다. 이는 SSH timeout을 설명하는 유력한 근거이며 다른 보안그룹·NACL·호스트 방화벽 상태를 AWS API로 확인한 결과는 아니다. SSH 패킷의 실제 source를 서버 로그/flow log로 검증하지도 않았다.

실제 client IP와 기존 CIDR/설명은 ignored `.modernization/ssh/`에만 보관한다. 공개 근거는 [ssh-rule-diagnosis.json](ssh-rule-diagnosis.json)에 rule IDs/count·일치 여부와 변경0으로 기록했다. DB greeting에는 추출 가능한 client IPv4가 없어 `direct-peer.json`의 값은 null이다.

콘솔 실행안:

1. us-west-2의 `sg-0c3c1c9686826401d` 인바운드 편집에서 기존5개 규칙을 유지한다.
2. SSH / TCP / port22 / 현재 확인한 공인 IPv4 한 개의 `/32`를 추가한다. 설명은 `quizeey-modernization-ssh-temporary`다. 실제 값을 포함한 CLI용 ip-permissions JSON은 `.modernization/ssh/planned-ingress.json`에 준비했다. IP가 바뀌면 저장 전에 다시 확인한다. 이 작업에는 DB3306·DNS·서비스 설정 변경이 없다.
3. 저장 후 새로 할당된 `sgr-...` ID를 기록하고, 기존 PEM/ec2-user로 읽기 전용 SSH를 재시도한다. 여전히 TCP timeout이면 규칙을 더 넓히지 않고 NACL/라우팅/호스트 방화벽·sshd 상태를 기존 콘솔 접속으로 구분한다.
4. 조사 완료 후 새로 추가한 rule ID만 제거한다. 기존5개 규칙은 유지한다.

현재 AWS 로그인 profile/계정 연결이 없어 위 추가안은 미실행이다. 사용자가 콘솔에서 규칙을 추가하거나 기존 Session Manager 접속 경로를 제공해야 실제 원격 검증을 진행할 수 있다. [AWS 보안그룹 규칙 편집](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/changing-security-group.html).

## 콘솔에서 첫 확인

오리건 EC2에서 해당 인스턴스의 공인 IPv4를 먼저 대조한다. Connect에서 이미 사용 가능한 Session Manager 또는 EC2 Instance Connect로 접속한다. Session Manager에는 기존 SSM 관리 상태/IAM 역할 등이 필요하며, 이 조사를 위해 새 정책·보안그룹·패키지를 임의로 설치하거나 변경하지 않는다.

[AWS 연결 방법](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/connect-to-linux-instance.html), [Session Manager 콘솔 연결](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/connect-with-systems-manager-session-manager.html).

접속 후 다음은 조회만 수행하며 서비스 재시작·DB 변경을 하지 않는다. 출력에는 비밀번호나 환경 변수·프로세스 전체 인자를 포함하지 않는다.

```sh
hostname
systemctl --no-pager --plain list-units --type=service --all 'mariadb*' 'mysql*' 'mysqld*' 'nginx*' '*questionbank*'
ss -lnt '( sport = :3306 or sport = :3307 or sport = :8080 )'
```

이미 Docker를 쓰는 서버라면 아래는 컨테이너 이름·이미지·포트만 조회한다. docker inspect/env 출력은 공유하지 않는다.

```sh
docker ps --format 'table {{.Names}}\t{{.Image}}\t{{.Ports}}'
```

명령이 없거나 권한이 없으면 설치·권한 상승·설정 변경으로 해결하지 않고 그 상태를 기록한다. 서비스 목록이 비어 있다고 DB가 없다고 판단하지 않는다. 컨테이너/수동 프로세스/다른 DB 호스트 가능성을 확인한다.

## 다음 확인과 판단 근거

1. 실행 중 앱의 PID/JAR/배포 시각·파일 checksum을 기록하고, 적용된 profile/config 위치를 식별한다. 프로세스 전체 인자·환경 변수·application.yml 전체 출력은 피한다. DB 설정을 확인할 때 host/port/database만 추출하고 username/password/URL query 값은 출력하지 않는다. JAR 내부 기본 설정만으로 실행 시 override가 없다고 판단하지 않는다.
2. 로컬 MariaDB 프로세스·listener·컨테이너가 확인되고 앱의 실제 DB target이 로컬 서버임을 대조하면 EC2 직접 호스팅 근거가 된다. 앱이 별도 RDS endpoint를 쓰면 해당 실제 대상을 조사한다.
3. 허용된 로컬 읽기 전용 DB 연결이 확인된 뒤 VERSION/charset/timezone/SHOW CREATE/index metadata를 수집한다. 사용자 제공 DDL과 JPA의 차이를 대조한다. 전체 행 수/대용량 export는 크기·부하·보존 위치를 먼저 검토한다.
4. DB host grant·방화벽·보안그룹을 열거나 비밀번호를 변경하지 않는다. 원격 접속을 위해 DB를 인터넷에 추가 공개하지 않는다. 기존 허용 경로와 로컬/터널 접속을 사용한다.

기존 AWS CLI profile이 제공되면 `inspect_aws.py --profile <existing-profile>`는 위 instance ID를 정확히 조회하고 실제 공인 IP를 소스 주소와 대조한다. 현재 미실행이며 RDS 이름 `quizeey`도 별도로 읽어 확인한다. 웹 앱과 DB의 정확한 연결 관계, 다른 서비스와의 공유 여부, EBS/EIP/backup/DNS/메일/배치를 확인하기 전에는 어떤 리소스도 종료하지 않는다.
