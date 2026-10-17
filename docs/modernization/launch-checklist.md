# 출시 gate

- [ ] Vercel/Supabase 실제 Pro 대상 IDs·권한·리전·증분 비용 확인
- [x] Live DDL6개/원본 PK/charset/timezone 확인 — EC2-local MySQL5.7.30
- [x] 승인된 원본167,205행 READ ONLY snapshot·owner-only 보관·타입/길이/NULL 검증
- [x] 실제 원본의 로컬 raw/typed2회 replay·UTC/ID/sequence·backup restore·private role 접근 거부 검증
- [x] 원본 오류751문항을 새 서비스 dataset에서 제외하는 사용자 결정·정확한ID 해시·관계/정답 대사
- [x] 승인된 새 콘텐츠 FK/unique5테이블 ETL2회·정답/ID/UTC·역할 거부·backup restore 로컬 대사
- [x] 실제26,733문항의 보호된 local-archive API/브라우저 채점·복원,751 삭제ID 부재·hosted 차단·trace 제외 검증
- [x] 실제 사용자 해설2,183개/문항topic630개 native 로컬2회 ETL·원문/ID/UTC·pending RLS·무권한 수정 거부·backup restore 검증
- [ ] Native 해설의 실제 대상 import·검토/공개·권한/소유권 없는 원본 글 정책 검증
- [ ] 새 콘텐츠 FK/unique 모델의 실제 Supabase transport/권한·최종 delta 검증
- [ ] 파일 manifest 및 Disqus export/이전 권한 확인
- [ ] 최종 ETL 및 backup restore·rollback rehearsal 통과
- [ ] table/exam/version·ID/정답집합/parent/파일 hash 대사, 모든 불일치 보고
- [ ] 전체 URL 회귀 및 GSC 클릭 95% 커버·한국어/영어 metadata/실제 equivalents의 hreflang 검증
- [ ] /app 및 구 브라우저 API compatibility, invalid ID·status 동작 검증
- [ ] 단일/복수 채점·skip/back/refresh·이미지/표/code·버전/북마크/오답·키보드/mobile 검증
- [ ] guest-A/B·쿠키 없음/만료·CSRF/XSS·공유 rate limit·idempotency·pending/revision 격리·RLS 직접쓰기 거부
- [ ] 관리자 인증/allowlist/moderation, signup 비활성 범위가 Quizeey 전용임을 확인
- [ ] 관리자 서버 세션 폐기·만료/쿠키 재사용 거부·복원 후 재로그인과 감사 보존을 실제 대상에서 확인
- [ ] 제공 DDL vs JPA 차이, 공조냉동 catalog141/page140 매핑 차이를 실제 데이터로 해소
- [ ] 과거 개인정보 고지의 Disqus/UA·새 서버/capability/보존 정책 및 연락/요청 전달 경로 검토
- [ ] Disqus export 재실행 대사·최종 쓰기 동결·신규 런타임 요청 0
- [ ] 기존 AdSense 첫 운영 릴리스 설정/ads.txt·CMP/거절·차단·slot once·CLS 검증
- [ ] GA4 실제 property 보존·PII 제외·quiz/forum/locale 이벤트·테스트 유입 제외
- [ ] 운영 accidentally noindex/preview canonical 0; preview 보호/noindex/광고 0
- [ ] lab + RUM 계획, mobile p75 LCP≤2.5s/INP≤200ms/CLS≤0.1 목표 및 실측 계획
- [ ] owner 승인 staging 부하 검증·최근 기준선·단일 writer/구 탭 차단·RPO/RTO/관찰기간
- [ ] 검증 evidence와 exact DB/DNS change request 제출 후 사용자 확인
- [ ] 안정화 뒤 별도 AWS resource-by-resource 종료 승인, backup retention/복구·next bill 확인

체크되지 않은 항목을 성공으로 표시하거나 로컬 빌드만으로 출시하지 않는다.
