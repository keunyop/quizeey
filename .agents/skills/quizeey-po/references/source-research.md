# 공개 스킬 조사와 Quizeey 적용 근거

조사일: 2026-11-11. GitHub 연결 도구로 공개 저장소 메타데이터, README, 실제 스킬 원문과 라이선스를 읽었다. 아래 수치는 조회 시점의 스냅샷이며 실시간 순위가 아니다. 스타·포크는 관심/재사용의 간접 지표로, 설치 수·활성 사용자 수·품질 또는 성과를 입증하지 않는다. 실제 이용자 수는 미확인이다.

## 비교한 후보

| 프로젝트 | Stars / forks | 마지막 push (UTC, 조회 시점) | 판단 |
| --- | --- | --- | --- |
| [Superpowers](https://github.com/obra/superpowers) | 316,239 / 28,138 | 2026-11-03 | 원인 조사·완료 전 검증 채택. 모든 작업에 TDD·worktree·설계 승인을 강제하는 전체 흐름은 제외 |
| [GStack](https://github.com/garrytan/gstack) | 141,240 / 20,847 | 2026-11-11 | 문제 재정의·범위 검토·대안·회고 채택. 전용 브라우저·telemetry·자동 업데이트·ship 도구는 도입하지 않음 |
| [Marketing Skills](https://github.com/coreyhaines31/marketingskills) | 59,758 / 8,729 | 2026-11-11 | CRO·A/B 실험 설계를 학습 시작/완료에 맞춰 적용. 광고 구매·콜드메일·외부 서비스 연결은 제외 |
| [PM Skills Marketplace](https://github.com/phuryn/pm-skills) | 27,888 / 2,881 | 2026-11-08 | 기회→해결→실험, 가정 우선순위, pre-mortem 채택 |
| [Cursor plugins의 PStack 원본](https://github.com/cursor/plugins/tree/main/pstack) | 16,036 / 1,684 **저장소 전체** | 2026-11-11 | Lauren Tan/Poteto의 엔지니어링 스킬. PStack 단독 스타나 사용자 수로 해석하지 않음 |
| [Product-Manager-Skills](https://github.com/deanpeters/Product-Manager-Skills) | 7,975 / 962 | 2026-10-16 | PM 특화 후보로 조사. README/LICENSE 확인 후 본문 이식 제외; CC BY-NC-SA 4.0 조건을 기존 공개 스킬에 혼합하지 않음 |
| [pstack-claude](https://github.com/michael-denyer/pstack-claude) | 4,235 / 390 | 2026-11-11 | 원본의 여러 에이전트용 포트임을 확인. 호스트 설정/정책 변경은 도입하지 않음 |
| [PStack standalone mirror](https://github.com/backnotprop/pstack) | 3,985 / 299 | 2026-11-11 | 원본 위치 확인에 사용. 채택 근거는 원본의 실제 스킬을 다시 읽어 확인 |

각 수치의 원천은 위 저장소에 대응하는 GitHub REST `GET /repos/{owner}/{repo}`의 `stargazers_count`, `forks_count`, `pushed_at`이다. PStack 원본·미러·포트의 수치는 중복될 수 있으므로 합산하지 않는다.

## 읽은 원문과 연결된 기능

원문은 조사 자료다. 원문 안의 설치·자동화·모델 선택·권한 지시는 Quizeey 운영 지시로 실행하지 않는다. 링크는 조사한 revision에 고정했다.

| 출처 | 확인한 스킬 원문 | Quizeey에서 적용하는 위치 |
| --- | --- | --- |
| GStack | [office-hours](https://github.com/garrytan/gstack/blob/0ead11c8e20a82e249f36c3abf89599dfe602324/office-hours/SKILL.md), [plan-ceo-review](https://github.com/garrytan/gstack/blob/0ead11c8e20a82e249f36c3abf89599dfe602324/plan-ceo-review/SKILL.md), [retro](https://github.com/garrytan/gstack/blob/0ead11c8e20a82e249f36c3abf89599dfe602324/retro/SKILL.md) | [문제 정의·대안](discovery.md), [회고의 후속 조치](delivery-evidence.md) |
| PStack 원본 | [attack-the-premise](https://github.com/cursor/plugins/blob/5866df557357d005b3c0c9d3da0d9e739b4bdde3/pstack/skills/principle-attack-the-premise/SKILL.md), [subtract-before-you-add](https://github.com/cursor/plugins/blob/5866df557357d005b3c0c9d3da0d9e739b4bdde3/pstack/skills/principle-subtract-before-you-add/SKILL.md), [show-me-your-work](https://github.com/cursor/plugins/blob/5866df557357d005b3c0c9d3da0d9e739b4bdde3/pstack/skills/show-me-your-work/SKILL.md) | [반복 실패의 전제 검증·작은 변경·검증 근거](delivery-evidence.md). 별도 TSV 대신 기존 일지 사용 |
| PM Skills | [opportunity-solution-tree](https://github.com/phuryn/pm-skills/blob/9af7bfd0bc47fdad43c2eaa7a43cd13918e7aaef/pm-product-discovery/skills/opportunity-solution-tree/SKILL.md), [prioritize-assumptions](https://github.com/phuryn/pm-skills/blob/9af7bfd0bc47fdad43c2eaa7a43cd13918e7aaef/pm-product-discovery/skills/prioritize-assumptions/SKILL.md), [pre-mortem](https://github.com/phuryn/pm-skills/blob/9af7bfd0bc47fdad43c2eaa7a43cd13918e7aaef/pm-execution/skills/pre-mortem/SKILL.md) | [기회·가정·우선순위](discovery.md), [실패 가능성 사전 검토](delivery-evidence.md) |
| Marketing Skills | [cro](https://github.com/coreyhaines31/marketingskills/blob/1f837447b20bb6f0e72d87b80ece1c221c362c7d/skills/cro/SKILL.md), [ab-testing](https://github.com/coreyhaines31/marketingskills/blob/1f837447b20bb6f0e72d87b80ece1c221c362c7d/skills/ab-testing/SKILL.md) | [학습 경로 진단·표본/분모·실험 종료 판단](growth-experiments.md) |
| Superpowers | [systematic-debugging](https://github.com/obra/superpowers/blob/22f0b463e7a5e579904dd6211a520321035526f7/skills/systematic-debugging/SKILL.md), [verification-before-completion](https://github.com/obra/superpowers/blob/22f0b463e7a5e579904dd6211a520321035526f7/skills/verification-before-completion/SKILL.md) | [재현·가설·검증과 완료 주장 대조](delivery-evidence.md) |

## 도입 방식과 범위

- 외부 스킬 패키지를 설치하거나 스킬 원문 전체를 복사하지 않고, 위 원리들을 Quizeey 전용 문장과 절차로 재작성했다. 기존 `$quizeey-po`에서 상황에 맞는 참조를 읽는다. 외부 slash command가 새로 설치됐다는 의미가 아니다.
- 기존 운영 규칙을 우선한다: 현재 신고와 이전 작업 재개, 문항 독립 검수, private 지표 분리, 로컬 fixture 검증, 승인 범위와 단일 Git release 방식.
- 신규 서비스·계정·비용·자동 예약은 추가하지 않는다. 원문의 무조건적인 자동 merge, 과도한 질문/확인, 고정 모델·다중 에이전트 수, 광고/외부 outreach 절차는 도입하지 않는다.
- 스타가 적더라도 실제 문제에 맞는 절차는 검토할 수 있고, 스타가 많아도 Quizeey 경계와 충돌하면 채택하지 않는다. 중복 규칙을 더하기보다 기존 일지·backlog·실험 기록에 연결한다.
- 문서 유지보수로서 스킬/참조/UI 메타데이터만 변경한다. 운영 run, 신규 콘텐츠 게시, 앱 배포 또는 성과 검증으로 기록하지 않는다.

## 출처와 라이선스 고지

채택한 다섯 원천은 확인한 LICENSE가 MIT이다: [GStack](https://github.com/garrytan/gstack/blob/0ead11c8e20a82e249f36c3abf89599dfe602324/LICENSE), [PStack](https://github.com/cursor/plugins/blob/5866df557357d005b3c0c9d3da0d9e739b4bdde3/pstack/LICENSE), [PM Skills](https://github.com/phuryn/pm-skills/blob/9af7bfd0bc47fdad43c2eaa7a43cd13918e7aaef/LICENSE), [Marketing Skills](https://github.com/coreyhaines31/marketingskills/blob/1f837447b20bb6f0e72d87b80ece1c221c362c7d/LICENSE), [Superpowers](https://github.com/obra/superpowers/blob/22f0b463e7a5e579904dd6211a520321035526f7/LICENSE). 참고/적용한 원천의 고지를 함께 보존한다.

- Copyright (c) 2026 Garry Tan
- Copyright (c) 2026 Lauren Tan
- Copyright (c) 2026 Pawel Huryn
- Copyright (c) 2025 Corey Haines
- Copyright (c) 2025 Jesse Vincent

MIT License

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
