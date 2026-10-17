# 증분 비용 모델 (USD)

기존 공통 Pro 구독료 전체를 Quizeey 신규 비용으로 더하지 않는다. 다만 project compute가 기존 구독에 포함되어 무료라고 가정하지도 않는다.

공식 확인 자료(2026-10-16): [Supabase compute](https://supabase.com/docs/guides/platform/manage-your-usage/compute), [Vercel Pro](https://vercel.com/docs/plans/pro-plan), [Supabase billing](https://supabase.com/docs/guides/platform/billing-on-supabase).

현재 **추가 유료 리소스 생성 0**, 외부 배포 0. 로컬 개발 비용만 발생. 실제 account usage/credit/compute가 없어 월 증분액은 미확정이다.

| 항목 | 추정 방식 | 필요한 입력 |
| --- | --- | --- |
| Supabase compute | 새 Quizeey project hourly compute × 월 시간 − 실제 사용 가능한 credit | org/project, size, region, credit 기존 소비 |
| Supabase Storage/egress/DB | 실제 저장량·파일 전송·요청량 × 계정 단가/초과량 | 익명화 크기, asset manifest, 예상 batch/cache |
| Vercel | 해당 team의 실제 추가 usage/seat/add-on | invoice, 포함 allowance의 타 서비스 사용량 |
| Preview | project/branch 상시 compute·테스트 트래픽 | 보호 preview 방식·수명 |
| AWS 병행 운영 | 실제 비용 × 겹치는 기간 | 리소스별 $30 추정 분해 |
| 종료 후 잔여 | DNS/domain/mail/snapshot/retained storage 등 | 공유 여부·retention·next bill |

월 이익 모델: 검증된 Quizeey 수익 − Quizeey로 실제 늘어나는 비용. 공통 구독 배분 후 이익은 별도 열로 계산한다. 1,000세션당 비용은 같은 기간의 실제 비용 ÷ 세션 × 1,000.

September RPM가 유지된다는 단순 가정에서 $20/$30/$45 손익분기 AdSense PV는 약 4,855/7,282/10,923이다. 요금 견적이나 트래픽/수익 상승 예측이 아니다. 새 project 생성 전 account 기반 비용 행과 승인 상태를 채운다.
