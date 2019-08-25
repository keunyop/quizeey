-- TEST
insert into test (test_id, test_nm, created_date, modified_date) values ('10', '도시계획기사', now(), now());
-- VERSION
insert into version (test_id, ver_nbr, ver_nm, created_date, modified_date) values ('10', '1', '2019-04-27 기출문제', now(), now());
-- QUESTION
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('10', '1', '1', ' 1967년 도시 내의 상업 · 업무지역을 중심형 상업지구(nucleation), 가로변 상업지구(ribbon), 특화지구(specialized area)로 구분한 학자는?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '1', '1', ' 프라우푸트(Proudfoot)', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '1', '2', ' 사핀과 카이저(Chapin &Kaiser)', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '1', '3', ' 베리(Berry)', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '1', '4', ' 무쓰(Muth)', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('10', '1', '2', ' 토지이용에서 도시문제를 야기하는 대표적인 요인으로 보기 어려운 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '2', '1', ' 이용주체간의 경합', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '2', '2', ' 외부효과', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '2', '3', ' 토지의 난개발', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '2', '4', ' 계획성 있는 토지이용계획', 'Y', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('10', '1', '3', ' 재해관리정보시스템 구축을 위한 기본조사 항목과 가장 관계가 없는 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '3', '1', ' 방재관련 업무 분석', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '3', '2', ' 표준안 및 시스템 구축 지침 작성', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '3', '3', ' 데이터베이스 개념설계 및 기술 수요 분석', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '3', '4', ' 재해관련 부서 간 네트워킹 체계 및 업무 협조 체계 구축', 'Y', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('10', '1', '4', ' 기반시설로서 광장의 구분에 해당하지 않는 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '4', '1', ' 공중광장		', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '4', '2', ' 일반광장', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '4', '3', ' 경관광장		', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '4', '4', ' 건축물부설광장', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('10', '1', '5', ' 학자와 계획안의 연결이 틀린 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '5', '1', ' Ebenezer Howard - 전원도시', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '5', '2', ' Tony Garnier - 공업도시', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '5', '3', ' P. Abercrombie - 대런던계획', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '5', '4', ' Frank Lloyd Wright - 빛나는 도시', 'Y', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('10', '1', '6', ' 상업지역 이용인구 40000명, 1인당 평균상면적 15m2, 건폐율 50%, 공공용지율 40%, 평균층수가 10층인 경우 상업지역의 소요면적은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '6', '1', ' 20.0ha		', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '6', '2', ' 15.8ha', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '6', '3', ' 12.5ha		', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '6', '4', ' 10.0ha', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('10', '1', '7', ' 지리정보시스템(GIS)에서 활용하는 자료에 대한 설명으로 옳은 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '7', '1', ' GIS의 자료는 크게 도형자료와 속성자료로 구분된다.', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '7', '2', ' 래스터 자료는 자료 저장과 표현의 기본 단위로 점(point)을 이용한다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '7', '3', ' 래스터 자료는 저장의 기본 단위 크기를 크게 할수록 정밀도가 향상된다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '7', '4', ' 자료 구조 측면에서 GIS자료는 그리드(grid)와 래스터(raster) 자료로 구분된다.', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('10', '1', '8', ' 국토계획의 개념으로 틀린 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '8', '1', ' 국토계획은 전 국토를 대상으로 하는 계획이다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '8', '2', ' 국토계획은 국토에서 일어나는 여러 가지 인간 활동의 공간적 배분 문제를 다루는 공간계획이다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '8', '3', ' 국토계획은 국토의 공간구성과 관련되는 모든 분야가 망라되는 종합계획이다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '8', '4', ' 국토계획은 지방자치단체가 주체가 되어 수립한 계획을 종합한 계획이다.', 'Y', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('10', '1', '9', ' 도시계획이론에 대한 설명으로 틀린 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '9', '1', ' 합리적 계획 모형은 합리성과 의사 결정을 위한 일련의 선택 과정을 강조한다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '9', '2', ' 정치 경제 계획 모형(Political Economy Planning)은 자본주의 사회 계층 간의 갈등은 도시 계획의 집행 결과에 따른 현상으로 조명되야 한다고 주장한다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '9', '3', ' 점진적 계획(Incremental Planning)은 인간 합리성의 한계를 인정하고 지속적인 조정과 적용을 통해 계획의 목표를 추구하는 접근방법을 제시한다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '9', '4', ' 옹호적 계획(Advocacy Planning)은 공공정책 결정을 위한 기준을 제시하는 기술관료적 역할을 중시한다.', 'Y', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('10', '1', '10', ' 독시아디스(C.A. Doxiadis)가 주장하는 3차원의 공간에 대한 4차원의 시간에 초점을 맞춘 미래 도시 개념은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '10', '1', ' 연담도시		', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '10', '2', ' 다이나폴리스', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '10', '3', ' 메트로폴리스	', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '10', '4', ' 메갈로폴리스', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('10', '1', '11', ' 도시계획이론으로서 옹호적 계획(Advocacy Planning)을 주창한 학자는?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '11', '1', ' C. Lindblom	', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '11', '2', ' E. Etizioni', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '11', '3', ' P. Davidoff	', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '11', '4', ' H. Simon', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('10', '1', '12', ' 주택지의 말단부에서는 자동차와 사람이 공존하는 것이 더 바람직하며, 주택지 내 도로는 단순한 교통시설이 아니라 시민생활의 터전이 되어야 한다는 생각으로 네덜란드의 델프트에서 처음 등장한 보차공존도로 방식은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '12', '1', ' 본엘프(woonerf)', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '12', '2', ' 커뮤니티몰(community mall)', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '12', '3', ' 거주환경지역(environmental area)', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '12', '4', ' 보행자데크(pedestrian deck)', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('10', '1', '13', ' 머디(R. A. Muride, 1997)가 미국의 여러 도시들을 대상으로 한 사회공간구조의 분석 결과 밝혀낸 다핵 패턴을 이루게 되는 유형에 해당하지 않는 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '13', '1', ' 사회·경제적 지위	', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '13', '2', ' 가족구조', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '13', '3', ' 인종그룹		', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '13', '4', ' 사회제도구조', 'Y', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('10', '1', '14', ' 토지이용의 밀도 유형과 측정지표가 잘못 연결된 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '14', '1', ' 1인당주거면적 = 주거건물면적 / 가구수', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '14', '2', ' 용적률 = 건물연면적 / 대지면적', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '14', '3', ' 건폐율 = 건축면적 / 대지면적', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '14', '4', ' 호수밀도 = 주택수 / 대지면적', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('10', '1', '15', ' 도시조사에 이용되는 지적도에 대한 설명이 틀린 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '15', '1', ' 토지대장에 등록된 토지의 경계를 밝혀주는 공부다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '15', '2', ' 필지별 토지의 소재, 지번, 지목, 경계 등 소유권의 범위를 표시하고 있다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '15', '3', ' 필지 경계 외에도 지형 및 건물의 배치가 표기되어 있어 도시계획에 있어 필수적인 자료다.', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '15', '4', ' 도면상의 지적과 공부상의 면적이 일치하지 않는 지적불부합의 문제가 있다.', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('10', '1', '16', ' 비용편익분석에서 경제성을 평가하는 지표가 아닌 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '16', '1', ' B/C Ratio		', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '16', '2', ' Multiplier', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '16', '3', ' NPV		', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '16', '4', ' IRR', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('10', '1', '17', ' 현재 시행되고 있는 토지 관련 부담금의 종류가 아닌 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '17', '1', ' 「개발이익 환수에 관한 법률」에 따른 개발부담금', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '17', '2', ' 「개발제한구역의 지정 및 관리에 관한 특별조치법」에 따른 개발제한구역 보전부담금', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '17', '3', ' 「기반시설 부담금에 관한 법률」에 따른 기반시설부담금', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '17', '4', ' 「대도시권 광역교통 관리에 관한 특별법」에 따른 광역교통시설부담금', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('10', '1', '18', ' 도시계획에서의 아래의 설명에 해당하는 GIS 활용분야는?<br><br>전 국토의 환경 친화적이고 지속가능한 개발을 보장하고 개발과 보전이 조화되는 '선 계획 후 개발'의 국토관리체계를 구축하기 위하여 각종의 토지이용계획이나 주요시설의 설치에 관한 계획을 입안하고자 하는 경우에 토지의 환경생태적, 물리적, 공간적 특성을 종합적으로 고려 및 평가하여 보전할 토지와 개발 가능한 토지를 체계적으로 판단하는 것이다.    ', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '18', '1', ' 토지적성평가	', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '18', '2', ' 토지이용계획', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '18', '3', ' 토지보전가치평가	', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '18', '4', ' 국토관리평가', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('10', '1', '19', ' 우리나라 최초의 도시계획법이라고도 볼 수 있으며, 지역지구의 법적 근거를 최초로 마련한 법규는?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '19', '1', ' 조선시가지계획령	', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '19', '2', ' 토지구획정리사업법', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '19', '3', ' 도시계획법		', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '19', '4', ' 건축법', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('10', '1', '20', ' 지속가능한 도시가 추구하여야 할 기본 목표가 아닌 것은?<br><br><br><br>', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '20', '1', ' 환경부하가 높은 첨단도시', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '20', '2', ' 도시경관의 개선 및 보전', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '20', '3', ' 환경친화적 교토 · 물류체계의 정비', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '20', '4', ' 쾌적한 도시공간의 정비 및 확보', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('10', '1', '21', ' 케빈 린치가 도시환경의 이미지를 분석할 때 정의한 3가지 구성 요소가 아닌 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '21', '1', ' 정체성(Identity)	', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '21', '2', ' 구조(Structure)', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '21', '3', ' 의미(Meaning)	', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '21', '4', ' 행동장면(Behavior Setting)', 'Y', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('10', '1', '22', ' 단지 조사 시 등고선도의 활용만으로 가능한 분석내용은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '22', '1', ' 토양토심		', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '22', '2', ' 국지기후', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '22', '3', ' 지면경사		', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '22', '4', ' 지하수망', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('10', '1', '23', ' 어린이공원의 규모 및 유치거리 기준이 옳은 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '23', '1', ' 1500m2 이상, 250m 이하', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '23', '2', ' 2000m2 이상, 250m 이하', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '23', '3', ' 2500m2 이상, 300m 이하', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '23', '4', ' 3000m2 이상, 300m 이하', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('10', '1', '24', ' 지구단위계획 수립 시 환경관리계획의 목표로 가장 거리가 먼 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '24', '1', ' 개발로 인한 자연환경의 피해 최소화', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '24', '2', ' 자연생태계 보존 및 순환체계의 유지', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '24', '3', ' 자연에너지의 활용 및 에너지 절감', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '24', '4', ' 불투수포장 확대로 인한 물순환체계의 유지', 'Y', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('10', '1', '25', ' 생활편익시설의 배치 시 노선형에 비해 집중형으로 배치하였을 때의 특징으로 옳지 않은 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '25', '1', ' 시설 상호간의 유기적 관련성이 높다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '25', '2', ' 활력있는 가로 분휘기를 조성할 수 있다.', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '25', '3', ' 상점의 입장에서는 충분한 주차공간의 확보가 어렵다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '25', '4', ' 공공공간의 공동 이용으로 용지의 면적이 절약된다.', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('10', '1', '26', ' 범죄예방환경설계(CPTED)와 관련성이 가장 적은 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '26', '1', ' 자연적 접근 통제	', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '26', '2', ' 교통 편의성', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '26', '3', ' 영역성 강화	', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '26', '4', ' 자연적 감시', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('10', '1', '27', ' 다음 중 경관분석 방법에 해당하지 않는 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '27', '1', ' 기호화 방법	', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '27', '2', ' 군락측도방법', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '27', '3', ' 사진에 의한 방법	', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '27', '4', ' 메쉬(mesh)에 의한 방법', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('10', '1', '28', ' 계획 인구 5만명, 주택용지율 75%의 단지계획에서 1인당 택지 점유율이 30m2일 때, 계획대상 단지의 면적은 얼마인가?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '28', '1', ' 11.25 ha		', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '28', '2', ' 66.66 ha', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '28', '3', ' 150 ha		', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '28', '4', ' 200 ha', 'Y', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('10', '1', '30', ' 근린생활권의 위계 중에서 주민 간에 면식이 가능한 최소단위의 생활권으로, 유치원·어린이 공원 등을 공유하는 반경 약 250m가 설정기준이 되는 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '30', '1', ' 인보구		', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '30', '2', ' 근린기초구', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '30', '3', ' 근린분구		', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '30', '4', ' 근린주구', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('10', '1', '31', ' 사업부지와 공공시설로 제공되는 부지의 용적률이 다를 경우에는 공공시설 부지의 용적률과 사업부지의 용적률 비율(“가중치”라 한다)을 감안하여 용적률 완화 범위를 정할 수 있게 되는데 다음 조건에서 가중치는? 「용적률 800% 상업지역에서 공공시설인 공개공지 제공부지 200m2와 용적율 200% 주거지역에서 도로시설제공부지 100m2인 경우」', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '31', '1', ' 0.7		', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '31', '2', ' 0.75', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '31', '3', ' 0.8		', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '31', '4', ' 0.85', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('10', '1', '32', ' 다음 중 저밀도 개발 대상지로서 가장 바람직한 지역은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '32', '1', ' 평탄하고 도심지로의 접근로상에 위치한 고지가지역', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '32', '2', ' 주위에 상업시설이 밀집되어 있고 재개발이 추진되고 있는 지역', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '32', '3', ' 구릉지로서 자연경관과 지형이 어우러진 지역', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '32', '4', ' 역세권에서 위치하여 대중교통의 연계성이 우수한 소규모 지역', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('10', '1', '33', ' 아래 설명에 적합한 가로망 형태는?<br><br>막다른 도로의 형태로 통과교통이 최대한 배제되고 도로 주변 주민들이 독점적으로 활용할 수 있는 구획도로가 형성되지만, 일정한 도로폭을 유지하여야 차량의 회전과 생활공간의 확보가 가능하다.    ', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '33', '1', ' cul-de-sac	', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '33', '2', ' U자형(loop형)', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '33', '3', ' 방사형		', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '33', '4', ' 격자형', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('10', '1', '34', ' 학자가 주장한 주요 개념의 연결이 틀린 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '34', '1', ' 고든 쿨렌(Gordon Cullen) : 연속장면(Serial Vision)', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '34', '2', ' 케빈 린치(Kevin Lynch) : 가독성(Legibility)', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '34', '3', ' 카밀로 지테 : 연속경관(Choregraphic Sequence)', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '34', '4', ' 필립 티엘(Philip Thiel) : 스마트 스페이스(Smart Space)', 'Y', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('10', '1', '35', ' 도시지역 내 지구단위계획구역을 지정할 수 있는 용도지구가 아닌 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '35', '1', ' 경관지구		', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '35', '2', ' 보호지구', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '35', '3', ' 개발진흥지구	', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '35', '4', ' 리모델링지구', 'Y', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('10', '1', '36', ' 교차점광장의 결정 기준이 아닌 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '36', '1', ' 차량과 보행자를 원활히 소통시키기 위하여 필요한 곳에 설치한다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '36', '2', ' 다수인의 집회·행사·사교 등을 위하여 필요한 경우에 설치한다.', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '36', '3', ' 혼잡한 주요도로의 교차지점 중 필요한 곳에 설치한다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '36', '4', ' 자동차전용도로의 교차지점인 경우에는 입체교차방식으로 설치한다.', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('10', '1', '37', ' 하수배제 방식 분류식(Separate System)에 관한 설명으로 옳은 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '37', '1', ' 합류식에 비해 우천시 다량의 토사가 유입된다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '37', '2', ' 수로를 통폐합하고 우수배제 계통을 종합적으로 관리할 수 있다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '37', '3', ' 기존 측구를 유지할 경우 관리 및 미관상 문제가 발생할 수 있다.', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '37', '4', ' 오수, 오수관거의 2계통을 건설하는 것에 비해 저렴하나 오수관거만을 건설하는 것에 비해 고가이다.', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('10', '1', '38', ' 지구단위계획 중 건축물의 용도에 관한 계획에서 공공적 성격이 강하여 특별히 확보해야 하는 시설의 경우에 적용하는 용도제한의 종류는?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '38', '1', ' 지정		', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '38', '2', ' 권장', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '38', '3', ' 불허		', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '38', '4', ' 지하층', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('10', '1', '39', ' 지구단위계획이 다른 도시계획행위와 구별되는 특징에 대한 설명이 틀린 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '39', '1', ' 도시 전체를 대상으로 하지 않고 도시 내부의 특정 지구로 한정된다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '39', '2', ' 공공의 일상적 공간을 특정지구의 여건에 비추어 바람직한 장소로 만들어가는 것을 목표로 한다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '39', '3', ' 지구단위계획은 3차원적 요소에도 관여한다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '39', '4', ' 지구단위계획은 장소를 구성하는 물리적 요소가 갖고 있는 개체적 특성을 중시하지만 다른 공간계획은 그것들이 이루는 집합된 형태에 중점을 둔다.', 'Y', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('10', '1', '40', ' 일반적으로 도시공간에서 건물의 높이와 수평거리의 비율이 얼마일 때부터 폐쇄감을 느끼기 시작하는가?<br><br><br><br>', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '40', '1', ' 4:1		', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '40', '2', ' 2:1', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '40', '3', ' 1:2		', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '40', '4', ' 1:4', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('10', '1', '41', ' 부채에 의한 재원조달 방식이 아닌 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '41', '1', ' 회사채		', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '41', '2', ' 자산담보부증권', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '41', '3', ' 투자조합		', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '41', '4', ' 대출', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('10', '1', '42', ' 토지상환채권의 발행 규모는 그 토지상환채권으로 상환할 토지·건축물이 해당 도시개발사업으로 조성되는 분양토지 또는 분양건축물 면적의 얼마를 초과하지 아니하도록 하여야 하는가?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '42', '1', ' 2분의 1		', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '42', '2', ' 3분의 1', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '42', '3', ' 4분의 1		', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '42', '4', ' 5분의 1', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('10', '1', '43', ' 개발권양도제(TDR)의 목적으로 가장 거리가 먼 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '43', '1', ' 납세자 보호		', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '43', '2', ' 역사적 건축물 보호', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '43', '3', ' 과밀지역의 개발 제한	', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '43', '4', ' 사업 인프라비용 절감', 'Y', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('10', '1', '44', ' 기업도시의 기능별 유형에 해당하지 않는 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '44', '1', ' 산업교역형		', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '44', '2', ' 지식기반형', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '44', '3', ' 관광레저형		', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '44', '4', ' 특성화형', 'Y', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('10', '1', '45', ' 민관합동 부동산 개발금융방식인 프로젝트파이낸싱(project financing)의 자금조달 형태에 관한 설명이 틀린 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '45', '1', ' 자기 자본투자는 투자 회수 순위에서 가장 높은 순위를 지니므로 위험도가 가장 낮다고 할 수 있다.', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '45', '2', ' 자기 자본투자자는 전략적 투자자와 재무적 투자자로 분류되면 재무적 투자자는 사업에 의한 배당 수익에 투자목적이 있다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '45', '3', ' 선순위 채권(senior debt)은 프로젝트파이낸싱에서 가장 큰 비중을 차지하는 자금이다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '45', '4', ' 선순위 채권(senior debt)은 대부분 상업은행으로부터의 차입금이 이에 해당되며 이자수익을 목적으로 투자한다.', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('10', '1', '46', ' 도시 및 주거환경정비법에서 정의하고 있는 정비사업이 아닌 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '46', '1', ' 주건환경개선사업	', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '46', '2', ' 재개발사업', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '46', '3', ' 도시환경정비사업	', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '46', '4', ' 재건축사업', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('10', '1', '47', ' 재개발방식에 따른 재개발 유형에 해당하지 않는 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '47', '1', ' 공공시설정비재개발		', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '47', '2', ' 수복재개발', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '47', '3', ' 전면재개발			', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '47', '4', ' 보존재개발', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('10', '1', '49', ' 지역지구제에 대한 설명이 틀린 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '49', '1', ' 용도지역에 따라 건축물의 용도 이외에 건축물의 형태, 규모의 규제가 가능하다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '49', '2', ' 지역지구제는 공고의 건강과 복리 증진을 위해 경찰권을 사용하여 개인의 토지이용에 제한을 가하는 법적 배경을 가진다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '49', '3', ' 용도지역지구제에서 지역과 지역, 지역과 지구, 지구와 지구간은 상호 모순되지 않는 한 중복 지정이 가능하다.', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '49', '4', ' 용도구역은 도시집중과 그에 따른 무질서한 시가화를 방지하고 계획적·단계적으로 시가지를 조성하기 위해 지정한다.', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('10', '1', '50', ' 도시재정비 촉진을 위한 특별법에 따른 재정비촉진지구 지정 면적을 기준 면적의 2분의 1까지 완화하여 적용하는 기준이 옳은 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '50', '1', ' 인구가 100만 이상이고 150만 미만인 광역시 또는 시의 주거지형 : 30만 제곱미터 이상', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '50', '2', ' 인구가 100만 미만인 광역시 또는 시의 주거지형 : 20만 제곱미터 이상', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '50', '3', ' 기반시설이 열악한 지역으로서 정비구역이 4 이상 연접한 지역의 주거지형 : 10만 제곱미터 이상', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '50', '4', ' 산지로 주거여건이 열악하면서 경관을 보호할 필요가 있는 지역의 주거지형 : 15만 제곱미터 이상', 'Y', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('10', '1', '51', ' 마케팅전략의 3단계인 STP전략 중 새로운 제품에 대해 다양한 욕구, 행동, 특성을 가진 소비자들을 동질적인 집단으로 나누는 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '51', '1', ' 시장 세분화	', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '51', '2', ' 표적시장 선정', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '51', '3', ' 전략적 판촉	', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '51', '4', ' 제품 포지셔닝', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('10', '1', '52', ' 미국의 샌프란시스코(1981년)를 필두로 하여 도심재개발에 적용된 연계정책(Linkage Policy)에 대한 설명으로 가장 거리가 먼 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '52', '1', ' A. Keating, G. McMahon 등이 링키지(Linkage)란 용어를 사용하였다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '52', '2', ' 링키지에 대한 정의의 폭이 각기 다른 것은 연계프로그램의 정책적 내용이 차츰 확대되어 나가고 있음을 반영하는 것으로 볼 수 있다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '52', '3', ' 시당국이 신규로 상업적 개발을 허가해 주는 대신 개발업자에게 일정한 주택, 고용기회, 보육시설, 교통시설 등의 건설을 촉구하는 다양한 프로그램으로 정의하기도 한다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '52', '4', ' 업무, 상업시설 등을 고려하여 고소득 주택과의 연계만을 추구하는 것이 일반적이다.', 'Y', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('10', '1', '53', ' 도시개발수요를 분석하기 위한 정성적 예측모형 중 조사하고자 하는 특정사항에 대하여 전문가 집단을 대상으로 반복 앙케이트를 수행하여 의견을 수집하는 방법은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '53', '1', ' 델파이법		', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '53', '2', ' 지수평화활법', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '53', '3', ' 박스젠킨스법	', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '53', '4', ' 의사결정나무기법', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('10', '1', '54', ' 자산담보부증권(ABS)에 대한 설명으로 옳지 않은 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '54', '1', ' 자산을 기초로 발행하는 경우 대차대조표에는 영향을 미치지 않는 부외금융이라는 이점이 있다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '54', '2', ' 사업주의 신용이 낮은 경우에도 자금을 조달 할 수 있다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '54', '3', ' 대출과 달리 유가증권의 형태로 유동화 한다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '54', '4', ' 다른 수단에 비하여 간편하지만 운용보수가 높다.', 'Y', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('10', '1', '55', ' Jenson과 Meckling(1976)이 대리인 문제로부터 발생하는 금전적·비금전적 비용을 분류한 내용에 해당하지 않는 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '55', '1', ' 감시비용		', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '55', '2', ' 거래비용', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '55', '3', ' 잔여손실		', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '55', '4', ' 확증비용', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('10', '1', '56', ' 개발사업 시행주체에 따른 도시개발방식에 대한 설명으로 가장 거리가 먼 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '56', '1', ' 공공개발은 국가나 지방자치단체가 직접 시행하는 도시개발이며, 공사 또는 지방공기업이 시행하는 경우는 공공개발에서 제외된다.', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '56', '2', ' 합동개발이란 공공이 사업주체가 되고 민간이 자본과 기술을 투입하여 택지를 조성하는 공영개발방식으로 이해되기도 한다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '56', '3', ' 민간개발이란 토지소유자 또는 토지소유자로 구성된 조합, 순수 민간기업 등이 사업시행자가 되는 경우를 말한다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '56', '4', ' 제3섹터개발은 관·민 양 부문이 공동출자하여 설립된 반관반민의 법인조직이 개발하는 것을 말한다.', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('10', '1', '57', ' 도시개발사업에서의 인·허가에 대한 설명이 틀린 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '57', '1', ' 허가(許可)란 법령에 의하여 금지되어 있는 행위를 해제하여 적법하게 하는 것을 말한다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '57', '2', ' 인가(認可)란 제3자의 행위를 보충하여 그 법률상의 효력을 완성시키는ㄴ 행위를 의미한다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '57', '3', ' 승인(承認)은 국가 또는 지방자치단체가 특정 행위에 대하여 부여하는 동의·승낙 등을 의미한다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '57', '4', ' 허가를 요하는 행위를 허가없이 행하거나, 인가를 받지 않고 한 행위는 처벌의 대상이 된다.', 'Y', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('10', '1', '58', ' 도시재정비 촉진을 위한 특별법이 규정하는 재정비촉진계획의 내용이 아닌 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '58', '1', ' 경관계획', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '58', '2', ' 인구·주택 수용계획', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '58', '3', ' 교육시설, 문화시설, 복지시설 등 기반시설 설치계획', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '58', '4', ' 분양계획', 'Y', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('10', '1', '59', ' 국토의 계획 및 이용에 관한 법률에서 개발로 인하여 기반시설이 부족할 것으로 예상되나 기반시설을 설치하기 곤란한 지역을 대상으로 건폐율이나 용적률을 강화하여 지정하는 구역은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '59', '1', ' 용도구역		', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '59', '2', ' 기반시설부담구역', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '59', '3', ' 개발밀도관리구역	', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '59', '4', ' 입지규제최소구역', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('10', '1', '61', ' 총 고용이 50만 명인 어느 지역의 경제기반승수가 2라면, 기반활동 고용이 1만 명 증가할 때 총 고용은 어떻게 변하는가?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '61', '1', ' 51만 명으로 증가	', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '61', '2', ' 52만 명으로 증가', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '61', '3', ' 53만 명으로 증가	', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '61', '4', ' 54만 명으로 증가', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('10', '1', '62', ' 로렌츠 곡선(Loranz curve)을 통해서 파악할 수 있는 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '62', '1', ' 지역고용구조	', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '62', '2', ' 지역생산구조', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '62', '3', ' 지역소득분배	', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '62', '4', ' 지역소득수준', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('10', '1', '63', ' 도시순위규모법칙에 따른 q값이 과거 1.0에서 현제 2.0으로 증가한 어는 나라의 도시체계에 관한 설명으로 가장 옳은 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '63', '1', ' 과거보다 도시화의 속도가 2배로 증가하였다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '63', '2', ' 과거보다 수위 도시 또는 소수의 몇몇 대도시에 더욱 많은 인구가 집중하였다.', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '63', '3', ' 과거에는 도시 인구의 분포가 균등하지 못하였으나 현재는 균등한 분포에 근접하고 있다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '63', '4', ' 과거에는 인구분포가 균형을 이루었으나 현재는 주요 도시의 인구가 농촌 인구의 2배가 되었다.', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('10', '1', '64', ' 성장거점이론의 기본개념과 가장 거리가 먼 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '64', '1', ' 파급효과(Spread effect)', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '64', '2', ' 선도산업(Leading industry)', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '64', '3', ' 극화효과(Polarization effect)', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '64', '4', ' 경쟁효과(Competition effect)', 'Y', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('10', '1', '65', ' 과밀억제권역으로부터 이전하는 인구와 산업을 계획적으로 유치하고 산업의 입지와 도시의 개발을 적정하게 관리할 필요가 있는 지역에 해당하는 권역은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '65', '1', ' 개발제한권역	', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '65', '2', ' 개발유도권역', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '65', '3', ' 자연보전권역	', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '65', '4', ' 성장관리권역', 'Y', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('10', '1', '66', ' 다음 중 최소비용이론에 입각하여 공업입지이론을 제안한 학자는?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '66', '1', ' 웨버(A. Weber)', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '66', '2', ' 로쉬(A. Loesch)', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '66', '3', ' 튀넨(Von Thuenen)', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '66', '4', ' 크리스탈러(W. Christaller)', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('10', '1', '67', ' 다음 중 지역문제의 발생 원인으로 가장 거리가 먼 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '67', '1', ' 지역주민들의 요구 수준의 차이', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '67', '2', ' 지역 내 특정 자연자원의 부존여부와 입지조건의 차이', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '67', '3', ' 정부가 추진하는 선(先)성장, 후(後)분배의 경제개발 정책방향', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '67', '4', ' 해당 지역 지배 산업의 전 세계 또는 다른 지역의 산업들과의 경쟁력 수준', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('10', '1', '68', ' 국토 및 지역계획수립을 위한 자료조사방법 중 1차 자료가 아닌 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '68', '1', ' 면접조사		', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '68', '2', ' 설문조사', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '68', '3', ' 현지조사		', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '68', '4', ' 통계자료조사', 'Y', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('10', '1', '69', ' 다음 중 가장 큰 규모의 공간단위는?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '69', '1', ' 메갈로폴리스	', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '69', '2', ' 메트로폴리스', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '69', '3', ' 인구밀집지역(DID)	', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '69', '4', ' 표준대도시통계지역', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('10', '1', '70', ' 제4차 국토종합계획 수정계획(2011~2020)의 주요 내용으로 가장 거리가 먼 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '70', '1', ' 점적 개방(3개축)을 중심으로 국토 골격 형성', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '70', '2', ' 해외 자원 확보 및 공동개발 추진', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '70', '3', ' 행정구역을 초월한 5+2 광역경제권', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '70', '4', ' 수도권의 경쟁력 강화 및 계획적 성장관리', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('10', '1', '71', ' 다음 중 국토기본법상 국토관리의 기념이념으로 옳지 않은 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '71', '1', ' 환경친화적 국토관리', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '71', '2', ' 국토의 균형있는 발전', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '71', '3', ' 경쟁력 있는 국토 여건의 조성', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '71', '4', ' 거점개발에 의한 집적이익의 추구', 'Y', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('10', '1', '72', ' 지속가능한 개발(Sustainable Development)의 개념에 대한 설명으로 옳지 않은 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '72', '1', ' 환경오염 규제만을 강화하는 개발 방법', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '72', '2', ' 지구의 환경용량 내에서 삶의 질을 향상시키는 개발', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '72', '3', ' 미래세대 수요충족을 저해하지 않으면서 현세대의 수요충족을 보장하는 개발', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '72', '4', ' 자연과 사회체계의 생명력을 보호하면서 기초적인 모든 서비스를 모든 공동체 주민에게 제공하는 것', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('10', '1', '73', ' 지역 간 균형과 사회계층 간 형평성을 중시하는 개발 방식을 주요 전략으로 하며 지역생활권개발의 이론적 근거가 되는 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '73', '1', ' 중심지이론		', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '73', '2', ' 경제기반이론', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '73', '3', ' 기본수요이론	', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '73', '4', ' 성장거점이론', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('10', '1', '74', ' 국토의 계획 및 이용에 관한 법률에서 명시하고 있는 구역에 해당하지 않는 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '74', '1', ' 개발제한구역	', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '74', '2', ' 국토자연구역', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '74', '3', ' 수산자원보호구역	', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '74', '4', ' 입지규제최소구역', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('10', '1', '75', ' 다음 중 부드빌(Boudeville)에 의한 지역 분류로 옳은 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '75', '1', ' 과밀지역 - 중간지역 - 후진지역', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '75', '2', ' 동질지역 - 결절지역 - 계획권역', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '75', '3', ' 보완지역 - 대체지역 - 발전지역', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '75', '4', ' 성장지역 - 침체지역 - 쇠퇴지역', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('10', '1', '76', ' 합리적 계획모형을 비판하는데서 출발하여 계획은 자본주의 생산양식의 관점에서 분석되어야 하며 특정 이념에만 기능하는 대신 역사적 관계와 정치·사회·경제적 맥락을 전반적으로 조명하여야 한다고 강조하는 지역계획모형은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '76', '1', ' 옹호적 계획(advocacy planning) 모형', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '76', '2', ' 혼합주사적 계획 (mixed planning) 모형', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '76', '3', ' 교류적 계획(transactive planning) 모형', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '76', '4', ' 정치경제 계획 (political economy planning) 모형', 'Y', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('10', '1', '77', ' 매년 1천 2백만 원의 임대료수익(R)을 영구히 주는 토지의 현재가치(PV)는? (단, 연간이자율(i)은 10%이다.)', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '77', '1', ' 4천 8백만 원	', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '77', '2', ' 9천 6백만 원', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '77', '3', ' 1억 2천만 원	', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '77', '4', ' 무한대', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('10', '1', '78', ' 국토계획평가를 실시한 후 그 결과를 심의하는 위원회는?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '78', '1', ' 국토계획위원회	', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '78', '2', ' 국토정책위원회', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '78', '3', ' 국토평가위원회	', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '78', '4', ' 중앙도시계획위원회', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('10', '1', '79', ' 지역생활권이론의 기본적인 개념으로서 도농통합전략에 대한 설명으로 옳은 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '79', '1', ' 성장거점이론의 실천적 개념이다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '79', '2', ' J.Friedmann과 K.Popper가 주장하였다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '79', '3', ' 기본 아이디어는 도농지구(Agropolitan)이다.', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '79', '4', ' 도농 간 차이를 인정하면서 보완적이지만 기능적으로 통합되지 않는다.', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('10', '1', '81', ' 도시공원 및 녹지 등에 관한 법률상 공원시설에 관한 설명으로 옳지 않은 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '81', '1', ' 점용허가의 대상이다.', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '81', '2', ' 도시공원 조성계획에 포함된다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '81', '3', ' 민간인도 허가를 받아 관리할 수 있다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '81', '4', ' 도시공원의 효용을 다하기 위하여 설치되는 시설이다.', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('10', '1', '82', ' 도시공원의 구분에 따른 규모 기준으로 옳은 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '82', '1', ' 묘지공원 - 10000m2 이상', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '82', '2', ' 체육공원 - 30000m2 이상', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '82', '3', ' 어린이공원 - 1500m2 이상', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '82', '4', ' 도보권 근린공원 - 20000m2', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('10', '1', '83', ' 중앙도시계획위원회에 관한 설명으로 옳은 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '83', '1', ' 공무원이 아닌 위원의 수는 10명 이상으로 하고, 그 임기는 3년으로 한다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '83', '2', ' 위원장·부위원장 각 1명을 포함한 30명 이상 40명 이하의 위원으로 구성한다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '83', '3', ' 광역도시계획·도시·군계획·토지거래계획허가구역 등 국토교통부장관의 권한에 속하는 사항의 심의 업무를 수행한다.', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '83', '4', ' 위원은 관계 중앙행정기관의 공무원과 도시·군계획과 관련된 분야에 관한 학식과 경험이 풍부한 자 중에서 위원장이 임명하거나 위촉한다.', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('10', '1', '84', ' 수도정비계획법령상 과밀부담금의 감면에 관한 내용으로 옳지 않은 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '84', '1', ' 국가나 지방자치단체가 건축하는 건축물에는 부담금을 부과하지 아니한다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '84', '2', ' 「과학기술기본법」에 따른 과학연구단지에는 부담금을 부과하지 아니한다.', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '84', '3', ' 건축물 중 수도권만을 관할하는 공공법인(지점을 포함한다)의 사무소에 대하여는 부담금을 부과하지 아니한다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '84', '4', ' 「도시 및 주거환경정비법」에 따른 재개발사업으로 건축하는 건축물에는 부담금의 100분의 50을 감면한다.', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('10', '1', '85', ' 국토교통부장관이 개발제한구역의 지정 및 해제를 도시·군관리계획으로 결정할 수 있는 경우로 가장 거리가 먼 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '85', '1', ' 도시의 무질서한 확산을 방지할 필요가 있는 경우', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '85', '2', ' 올림픽 등 국제행사에 대비하여 대규모 자연공간을 확보할 필요가 있는 경우', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '85', '3', ' 국방부장관의 요청으로 보안상 도시의 개발을 제한할 필요가 있다고 인정되는 경우', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '85', '4', ' 도시민의 건전한 생활환경을 확보하기 위하여 도시의 개발을 제한할 필요가 있는 경우', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('10', '1', '86', ' 도시개발법상 도시개발구역을 지정할 수 없는 자는?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '86', '1', ' 구청장		', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '86', '2', ' 도지사', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '86', '3', ' 광역시장		', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '86', '4', ' 특별시장', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('10', '1', '87', ' 도시 및 주거환경정비법상 분양신청 현황을 기초로 한 관리처분계획 수립 시 포함되어야 하는 사항이 아닌 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '87', '1', ' 분양설계', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '87', '2', ' 분양대상자의 주소 및 성명', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '87', '3', ' 관리처분계획의 인가 연월일', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '87', '4', ' 분양대상자별 종전의 토지 또는 건축물 명세', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('10', '1', '88', ' 주택법상 사업주체가 대통령령으로 정하는 호수 이상의 주택건설사업을 시행하는 경우 지방자치단체가 설치하는 도로 및 상하수도시설에 대하여 국가가 보조할 수 있는 설치비용의 범위는?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '88', '1', ' 그 비용의 전부	', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '88', '2', ' 그 비용의 30%', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '88', '3', ' 그 비용의 50%	', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '88', '4', ' 그 비용의 75%', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('10', '1', '89', ' 국토의 계획 및 이용에 관한 법령에 따른 용도지구 중 문화재·전통사찰 등 역사·문회적으로 보존가치가 큰 시설 및 지역의 보호와 보존을 위하여 필요한 지구는?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '89', '1', ' 복합개발진흥지구		', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '89', '2', ' 특정개발진흥지구', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '89', '3', ' 중요시설물보호지구		', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '89', '4', ' 역사문화환경보호지구', 'Y', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('10', '1', '90', ' 하나의 도시지역 안에 있어서의 도시공원의 확보기준은 해당도시지역 안에 거주하는 주민 1인당 얼마 이상으로 하는가?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '90', '1', ' 6m2	Ā		', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '90', '2', ' 7m2', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '90', '3', ' 8m2	Ā		', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '90', '4', ' 9m2', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('10', '1', '91', ' 관광진흥법령상 관광객 이용시설업의 종류에 해당하지 않는 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '91', '1', ' 전문휴양업		', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '91', '2', ' 종합휴양업', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '91', '3', ' 관광유람선업	', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '91', '4', ' 일반유원시설업', 'Y', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('10', '1', '92', ' 택지개발촉진법령상 수의계약으로 공급할 수 있는 택지로 부적합한 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '92', '1', ' 「주택법」에 따른 사업주체 중 국가. 지방자치단체 또는 국토교통부령으로 정하는 공공기관에 공급할 경우', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '92', '2', ' 면적이 100만m2 이상인예정지구안에서 지형조건 및 다양한 시설용도 등을 고려하여 복합적이고 입체적인 개발이 필요한 경우', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '92', '3', ' 도로, 학교, 공원, 공용의 청사 등 일반인에게 분양할 수 없는 공공시설용지를 국가, 지방자치단체, 그 밖에 법령에 따라 해당 공공시설을 설치할 수 있는 자에게 공급할 경우', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '92', '4', ' 주택조합의 조합원에게 공급하여야 할 주택을 건설하는 데 필요한 토지 면적의 2분의 1이상을 취득한 주택조합이 그 토지의 전부를 관련 법률에 따른 협의에 응하여 시행자에게 양도하였을 때 해당 주택조합에 국토교부령으로 정하는 면적의 범위에서 택지를 공급하는 경우', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('10', '1', '93', ' 택지개발촉진법령상 택지개발지구 안에서의 관할 특별자치도지사·시장·군수 또는 자치구의 구청장의 허가를 받아야 하는 행위가 아닌 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '93', '1', ' 토지의 형질변경', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '93', '2', ' 죽목의 벌채 및 식재', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '93', '3', ' 건축물의 건축 또는 공작물의 설치', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '93', '4', ' 재해 복구 또는 재난 수습에 필요한 응급조치를 위하여 하는 행위', 'Y', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('10', '1', '94', ' 수도권정비계획법의 정의에 부합되지 않는 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '94', '1', ' “수도권”이란 서울특별시와 대통령령으로 정하는 그 주변 지역을 말한다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '94', '2', ' “공업지역”이란 「국토기본법」에 따라 지정된 공업지역을 말한다.', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '94', '3', ' “수도권정비계획”이란 「국토기본법」에 따른 국토종합계획을 기본으로 하여 관련 조항에 따라 수립되는 계획을 말한다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '94', '4', ' “인구집중유발시설”이란 학교, 공장, 공공청사, 업무용 건축물, 판매용 건축물, 연수시설, 그 밖에 인구 집중을 유발하는 시설로서 대통령령으로 정하는 종류 및 규모 이상의 시설을 말한다.', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('10', '1', '95', ' 택지개발촉진법상 환매권에 관한 설명으로 옳지 않은 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '95', '1', ' 환매권자는 환매로써 제3자에게 대항할 수 있다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '95', '2', ' 보상금에 가산하는 환매가액은 보상금 산정일부터 환매일까지의 법정이자이다.', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '95', '3', ' 수용한 토지 등의 전부 또는 일부가 필요ㅊ없게 되었을 때에 환매권자는 필요 없게 된 날부터 1년 이내에 환매할 수 있다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '95', '4', ' 환매권자는 토지 등의 수용 당시 받은 보상금에 대통령령으로 정한 금액을 가산하여 시행자에게 지금하고 이를 환매할 수 있다.', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('10', '1', '96', ' 국토의 계획 및 이용에 관한 법률에 따른 기반시설에 속하지 않는 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '96', '1', ' 광장·공원·녹지 등 공간시설', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '96', '2', ' 도로·철도·항만·공항·주차장 등 교통시설', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '96', '3', ' 아파트·연립주택·다세대주택 등 주거시설', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '96', '4', ' 하수도, 폐기물처리 및 재활용시설, 빗물저장 및 이용시설 등 환경기초시설', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('10', '1', '97', ' 산업입지 및 개발에 관한 법률에 따른 산업단지에 해당하는 것으로만 나열된 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '97', '1', ' 국가산업단지, 일반산업단지, 농공단지', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '97', '2', ' 국가산업단지, 지역산업단지, 농공단지', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '97', '3', ' 국가산업단지, 도시산업단지, 농공산업단지', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '97', '4', ' 국가산업단지, 일반산업단지, 특수산업단지', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('10', '1', '98', ' 주차장 법령상 단지조성사업등으로 설치되는 노외주차장에 경형자동차 및 환경친화적 자동차를 위한 전용주차구획을 노외주차장 총 주차대수의 얼마 이상이 되도록 설치하여야 하는가?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '98', '1', ' 100분의 3		', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '98', '2', ' 100분의 5', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '98', '3', ' 100분의 10		', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '98', '4', ' 100분의 15', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('10', '1', '99', ' 시가화조정구역에서 특별시장·광역시장·특별자치시장·특별자치도지사·시장 또는 군수의 허가를 받아 할 수 있는 행위에 대한 내용으로 옳지 않은 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '99', '1', ' 입목의 벌채, 조림, 육림, 토석의 채취, 그 밖에 대통령령으로 정하는 경미한 행위', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '99', '2', ' 건축물의 건축 및 공작물 중 대통령령으로 정하는 종류의 공작물을 설치하는 행위', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '99', '3', ' 농업·임업 또는 어업용의 건축물 중 대통령령으로 정하는 종류와 규모의 건축물이나 그 밖의 시설을 건축하는 행위', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '99', '4', ' 마을공동시설, 공익시설·공공시설, 광공업 등 주민의 생활을 영위하는 데에 필요한 행위로서 대통령령으로 정하는 행위', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('10', '1', '100', ' 관광진흥법상 관광개발기본계획에 따라 구분된 권역을 대상으로 수립하는 권역별 관광개발계획에 포함하는 사항으로 옳지 않은 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '100', '1', ' 환경보전에 관한 사항', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '100', '2', ' 관광지 연계에 관한 사항', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '100', '3', ' 관광권역별 관광개발의 기본방향에 관한 사항', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('10', '1', '100', '4', ' 관광자원의 보호·개발·이용·관리 등에 관한 사항', 'N', now(), now());

