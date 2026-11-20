# 3D프린터 첫 층·워핑 원본 학습 콘텐츠 검수

- 작성일/검토일: 2026-11-20. 콘텐츠 revision: `printing-first-layer-v1`.
- 시험/언어: 3D프린터운용기능사 / 한국어. FDM/FFF 첫 층·출력 결함 기초이며 특정 시험 버전의 전체 범위나 공식 기출을 주장하지 않는다.
- 작성자: primary PO/Engineering. 독립 근거 검토: 별도 Content 검수자 `content_research`.
- 원본: [글과 세 확인 문제](../../web/src/components/PrintingFirstLayerArticle.tsx). 본문에 문항·선택지·정답·해설·각 오답 이유를 보존한다. DB 문항 스키마에 새 검수 필드가 생긴 것으로 해석하지 않는다.
- 상태: 공식 근거·정답·오답 독립 검수 완료. 로컬 전체 검사와 운영 반영 확인은 [당일 일지](../quizeey-ops/journal/2026-11-20.md)의 최신 상태를 따른다.

| 원본 항목 | 영역/난이도 | 정답 집합 | 판단과 오답 구분 | 공식 근거 |
| --- | --- | --- | --- | --- |
| 글 1번: 간격을 줄인 뒤 눌린 선·능선 | 첫 층 간격/기초 | 2 | 추가 내림 대신 보정·압출 확인. 계속 내림은 과근접 무시, 브림은 간격 보정 아님 | First layer issues, First Layer Calibration |
| 글 2번: 넓은 모델의 모서리가 나중에 들림 | 워핑 진단/기초 | 1 | 형상·열수축·접착·재료별 냉각 비교. 팬 최대 고정과 바닥 접착 배제는 부적절 | Warping |
| 글 3번: 작은 바닥의 첫 층 면적 확대 | 브림/기초 | 3 | 브림은 바닥 접착 도움. 일반 스커트는 흐름·상태 확인, 서포트는 돌출부 지지 | Skirt and Brim |

공식 원문: [First layer issues](https://help.prusa3d.com/article/first-layer-issues_1804), [First Layer Calibration (i3)](https://help.prusa3d.com/article/first-layer-calibration-i3_112364), [Warping](https://help.prusa3d.com/article/warping_2011), [Skirt and Brim](https://help.prusa3d.com/article/skirt-and-brim_133969). 검수자는 2026-11-20에 원문을 직접 읽었다. 기종별 자동 보정·표면/재료별 세척·팬/밀폐 조건·브림 분리 간격의 차이를 확인했고 범용 수치·확정 원인으로 바꾸지 않았다.

기존 [레이어·서포트·인필 글](../../web/src/components/PrintingArticle.tsx)은 층 수 계산과 구조 선택을 다룬다. 새 사례는 첫 층 관찰 시점과 실패 진단을 다루며 기존 문항 복사 없이 새로 작성했다. 글 안 세 항목의 정답이 각각 2/1/3이며 단일 정답과 모든 오답 이유를 검토했다.

연결 경로는 `/craftsman-3D-printer-operation?verNbr=202611`이다. 실제 로컬 fixture에서 정식 시험명, 2026-11 연습문제 20개, 첫 FDM 부품 문항과 선택지를 확인했다. 기존 10월 23문항과 혼동하지 않으며 워핑만 모은 필터를 약속하지 않는다. 원본 글의 세 문제는 블로그 확인 문제이며 연습 세트에 새로 등록한 문항이 아니다.

검색 근거의 원본 값·쿼리·원본 식별자와 파일 해시는 비공개 운영 기록에 둔다. 넓은 한국어 필기 연습 수요가 근거이며 첫 층 전용 검색 수요와 실제 학습 효과는 미측정이다. 신규 글이 11월 20일 운영 확인을 마치면 11월 21일~12월 18일 완결 28일을 관측한다. 복구는 글·등록·연결 변경의 Git revert다.
