-- TEST
insert into test (test_nm, created_date, modified_date) values ('교통기사', now(), now());
-- VERSION
insert into version (test_id, ver_nbr, ver_nm, created_date, modified_date) values ('7', '1', '2019-04-27 기출문제', now(), now());
-- Q1
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('7', '1', '1', '「지능형교통체계 기본계획 2020」의 추진전력으로 옳지 않은 것은?', '', '', 'N', now(), now());

-- Q2
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('7', '1', '3', '지하철의 요금이 1200원일 때 승객수요는 8000명이다. 수요탄력성이 –1.5일 때, 지하철 요금이 1300원으로 인상되는 경우의 수요는 얼마인가?', '', '', 'N', now(), now());

-- Q3
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('7', '1', '4', 'A도시 내 백화점 주차특성 조사 결과가 아래와 같으며, 신축예정인 어느 백화점의 건물연면적(상면적)이 22350m2 일 때 원단위법에 의해 산정한 목표연도의 주차수요대수는? (단, 목표연도는 5년 후이다.)<br><br>  - 주차발생 원단위 : 5.5(대/1000m2/시)<br>  - 주차이용률 : 85%<br>  - 신축 후 주차대수의 연평균 증가율 : 3%  ', '', '', 'N', now(), now());

-- Q4
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('7', '1', '5', '다음 중 교통수단선택을 예측하는데 사용되는 모형이 아닌 것은?', '', '', 'N', now(), now());

-- Q5
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('7', '1', '6', '교통감응신호기에 대한 설명으로 옳지 않은 것은?', '', '', 'N', now(), now());

-- Q6
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('7', '1', '7', '교통수요 예측을 위한 자료 조사 방버인 우편에 의한 회수법에 대한 설명으로 옳지 않은 것은?', '', '', 'N', now(), now());

-- Q7
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('7', '1', '8', '다음 중 4단계 교통수요 추정방법에 대한 설명으로 옳지 않은 것은?', '', '', 'N', now(), now());

-- Q8
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('7', '1', '9', '교통체계운영(TSM)에 대한 설명으로 옳은 것은?', '', '', 'N', now(), now());

-- Q9
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('7', '1', '10', '교통계획에서 차량 보유대수 자료의 활용 내용과 가장 거리가 먼 것은? ', '', '', 'N', now(), now());

-- Q10
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('7', '1', '11', '교통계획과정에서 승객이나 화물이동의 흐름을 분석하고 추정하기 위한 단위지역인 교통 존(traffic zone)의 설정기준으로 옳은 것은? ', '', '', 'N', now(), now());

-- Q11
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('7', '1', '12', '다음 중 대중교통 통행배정을 위한 일반화 비용 추정 시 고려되지 않는 변수는? ', '', '', 'N', now(), now());

-- Q12
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('7', '1', '13', '내부수익률(IRR)을 이용한 경제성 분석법에 대한 설명으로 옳은 것은? ', '', '', 'N', now(), now());

-- Q13
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('7', '1', '14', '교통시설 투자의 타당성 분석에서 매우 중요한 시간가치를 산출할 때 사용되는 것은? ', '', '', 'N', now(), now());

-- Q14
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('7', '1', '15', '사용자 균형(User Equilibrium)을 만족하는 통행배정량을 수치적으로 도출하기 위한 프랭크울프(Frank-Wolfe) 알고리즘의 순서로 옳은 것은? ', '', '', 'N', now(), now());

-- Q15
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('7', '1', '16', '도시교통정비 촉진법에서 규정하는 시장이 시행하는 교통수요관리 방안이 아닌 것은? ', '', '', 'N', now(), now());

-- Q16
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('7', '1', '17', '교통사업 평가 시 고려되는 차량운행비(Vehicle Operating Costs) 중 고정비(Fixed Cost)가 아닌 것은? ', '', '', 'N', now(), now());

-- Q17
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('7', '1', '18', '버스 승객의 효용함수가 아래와 같을 때 승객 1시간 시간가치는?<br><br>  U버스 = 0.1 x 통행시간(분) + 0.001 x 버스요금(원)     ', '', '', 'N', now(), now());

-- Q18
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('7', '1', '19', '개별행태모형에 대한 설명으로 틀린 것은? ', '', '', 'N', now(), now());

-- Q19
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('7', '1', '20', '경전철(light rail transit)의 일반적인 특성으로 옳은 것은? ', '', '', 'N', now(), now());

-- Q20
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('7', '1', '21', '다음 중 계수분포에 해당하는 확률분포모형이 아닌 것은? ', '', '', 'N', now(), now());

-- Q21
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('7', '1', '22', '교통신호와 관련된 용어에 대한 설명이 틀린 것은? ', '', '', 'N', now(), now());

-- Q22
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('7', '1', '23', '아래와 같은 특징을 갖는 신호연동체계는?<br><br>  - 각 교차로의 시간분할은 같다.<br>  - 교통량이 많고, 교차로 간격이 짧으면서 길이가 비슷한 간선도로에서 비교적 긴 주기로 사용하면 효과적이다.     ', '', '', 'N', now(), now());

-- Q23
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('7', '1', '24', '도로의 교통용량에 있어 기본 교통 용량의 정의로 옳은 것은? ', '', '', 'N', now(), now());

-- Q24
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('7', '1', '25', '차량이 움직이는데 발생하는 엔진외부저항, 즉 주행저항에 속하는 것을 모두 고른 것은?<br><br>  ⓐ 구름저항(rolling resistance)<br>ⓑ공기저항(air resistance)<br>ⓒ경사저항(grade resistance<br>ⓓ곡선저항(curve resistance)    ', '', '', 'N', now(), now());

-- Q25
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('7', '1', '27', '대기행렬이론에서 단일 서비스 시스템에 대한 설명으로 틀린 것은? ', '', '', 'N', now(), now());

-- Q26
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('7', '1', '28', '도로의 일정 구간을 주행하는 각 차량들의 속도가 동일하지 않은 경우 공간평균속도와 시간평균속도의 관계를 옳게 설명한 것은? ', '', '', 'N', now(), now());

-- Q27
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('7', '1', '29', '교통량 조사방법으로 가장 부적합한 것은? ', '', '', 'N', now(), now());

-- Q28
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('7', '1', '30', '자유류 속도가 70km/h인 도로 구간의 차량정지선에 있는 차량이 출발하였을 때, 충격파의 속도(uw)가 –35km/h 이었다. 출발하는 차량의 속도는? ', '', '', 'N', now(), now());

-- Q29
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('7', '1', '31', '어떤 도로의 3km 구간에서 이동차량방법(moving vehicle method)으로 측정한 결과 B차가 주행하면서 만난 반대방향 차량대수가 60대, A차가 추월한 차량이 4대, A차를 추월한 차량이 4대, A차의 주행시간이 5분, B차의 주행시간이 4분 이었을 때, A차가 달리는 방향의 평균 교통량은? ', '', '', 'N', now(), now());

-- Q30
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('7', '1', '32', '신호교차로 접근로의 용량 산정 시, 기본 포화 교통류율이 2200pcphgpl이 되는 이상적인 조건으로 옳지 않은 것은? ', '', '', 'N', now(), now());

-- Q31
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('7', '1', '33', '현장 관측자료를 이용한 속도와 밀도의 관계가 아래와 같을 때, 다음 설명 중 옳지 않은 것은?     ', '', '', 'N', now(), now());

-- Q32
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('7', '1', '35', '일련의 신호교차로에서의 교통흐름을 나타내는 시공도(time-space diagram)에서 관측할 수 있는 것으로만 나열한 것은? ', '', '', 'N', now(), now());

-- Q33
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('7', '1', '37', '어느 도로의 첨두시간 교통량이 1500대/시간이고 첨두시간 중 15분 최대교통량이 450대 일 때, 첨두시간계수(PHF)는? ', '', '', 'N', now(), now());

-- Q34
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('7', '1', '38', '교통시설 설계 시 설계기준자동차의 제원 기준이 아닌 것은? ', '', '', 'N', now(), now());

-- Q35
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('7', '1', '40', '고속도로 기본 구간의 이상적인 조건이 아닌 것은? ', '', '', 'N', now(), now());

-- Q36
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('7', '1', '41', '설계속도가 120 km/h인 도로의 평면곡선부에 설치하는 완화곡선의 최소길이 기준은? ', '', '', 'N', now(), now());

-- Q37
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('7', '1', '42', '차량이 85km/h 의 속도로 평지인 도로를 주행하고 있다. 도로의 마찰계수는 0.3, 지각반응시간이 2.5초 일 때, 주행중인 차량의 최소정지시거는? ', '', '', 'N', now(), now());

-- Q38
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('7', '1', '43', '차로의 폭을 결정하는 요인으로 가장 거리가 먼 것은? ', '', '', 'N', now(), now());

-- Q39
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('7', '1', '44', '도로의 평면곡선설계에서 최소 평면곡선 반지름을 정할 때 고려하지 않아도 되는 것은? ', '', '', 'N', now(), now());

-- Q40
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('7', '1', '45', '도로의 기능별 구분에 따른 최소 설계속도 기준이 옳지 않은 것은? ', '', '', 'N', now(), now());

-- Q41
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('7', '1', '46', '평면교차와 그 접속기준이 옳은 것은? ', '', '', 'N', now(), now());

-- Q42
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('7', '1', '47', '주차장의 주차단위구획과 관련한 설명으로 옳은 것은? ', '', '', 'N', now(), now());

-- Q43
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('7', '1', '48', '노면이 시멘트 포장도로인 차도의 횡단경사 기준은? ', '', '', 'N', now(), now());

-- Q44
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('7', '1', '49', '도로 설계 시 환경시설대의 설치기준으로 옳은 것은? ', '', '', 'N', now(), now());

-- Q45
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('7', '1', '50', '도로의 구조·시설 기준에 관한 규칙에 따르면 도로의 계획목표연도는 공용개시 계획연도를 기준으로 몇 년 이내로 정하는가? ', '', '', 'N', now(), now());

-- Q46
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('7', '1', '51', '화물터미널 설계 시 고려해야 할 시설로 가장 거리가 먼 것은? ', '', '', 'N', now(), now());

-- Q47
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('7', '1', '52', '인터체인지의 연결로 설계 시 유출입 유형의 일관성을 유지할 경우 얻게 되는 장점이 아닌 것은? ', '', '', 'N', now(), now());

-- Q48
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('7', '1', '53', '도시지역 차도의 평면곡선부 최대편경사 기준으로 옳은 것은? ', '', '', 'N', now(), now());

-- Q49
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('7', '1', '54', '입체교차 변속차로의 설계에 대한 설명으로 옳은 것은? ', '', '', 'N', now(), now());

-- Q50
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('7', '1', '55', '자동차 전용도로의 설계속도는 최소 얼마 이상으로 하는가? (단, 자동차 전용도로가 도시지역에 있거나 소형차도로인 경우는 고려하지 않는다.) ', '', '', 'N', now(), now());

-- Q51
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('7', '1', '56', '도시지역의 일반도로에 주정차대를 설치하는 경우의 최소 폭 기준으로 옳은 것은? (단, 소형자동차를 대상으로 하는 주정차대의 경우는 고려하지 않는다.) ', '', '', 'N', now(), now());

-- Q52
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('7', '1', '57', '노상시설에 해당하지 않는 것은? ', '', '', 'N', now(), now());

-- Q53
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('7', '1', '58', '교차로 진입속도가 50 km/h, 교차로 횡단거리 20m, 차량의 가속도 5.0 m/s2, 차량길이 4m 일 때 적정 황색 시간은? (단, 운전자 반응시간은 1초이다.) ', '', '', 'N', now(), now());

-- Q54
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('7', '1', '59', '도로의 부대시설 중 체인탈착장의 설계 시 유의사항에 대한 설명으로 틀린 것은? ', '', '', 'N', now(), now());

-- Q55
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('7', '1', '60', '노상주차장의 구조·설비기준으로 틀린 것은? (단, 해당 지방자치단체의 조례로 따로 정하거나 기타 사항의 경우는 고려하지 않는다.) ', '', '', 'N', now(), now());

-- Q56
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('7', '1', '61', '도시계획 과정에서 여러 종류의 변수들이 서로 어떤 관계를 갖는지 분석하는 방법으로 옳지 않은 것은? ', '', '', 'N', now(), now());

-- Q57
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('7', '1', '62', '토지구획정리사업에 있어서의 환지설계방법 중 교통 여건, 토지이용상황 등 모든 여건이 토지 가격에 의해 나타난다는 전제 하에 사업 전의 토지 가격을 사업종료 후의 토지 가격에 비례해서 환지하는 방식은? ', '', '', 'N', now(), now());

-- Q58
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('7', '1', '63', '주거 단지 내 도로계획 시 일반적 고려사항이 아닌 것은? ', '', '', 'N', now(), now());

-- Q59
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('7', '1', '64', '용도지구의 종류가 아닌 것은? ', '', '', 'N', now(), now());

-- Q60
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('7', '1', '65', '재정계획에 있어서 계속되는 사업이라도 예산 편성 시 신규사업처럼 능률성, 효과성, 사업의 확대, 축소 여부를 새로이 분석·검토하고 사업의 우선순위를 결정하여 예산과 사업계획에 대한 결정을 하는 제도는? ', '', '', 'N', now(), now());

-- Q61
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('7', '1', '66', '계획이론에 대한 허드슨(Hudson)의 분류에서 린드블룸(Lindblom)이 주창한 것으로 지속적인 조정과 적용을 통해 계획의 목표를 추구하는 접근 방법을 제시한 계획이론은? ', '', '', 'N', now(), now());

-- Q62
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('7', '1', '67', '국토의 계획 및 이용에 관한 법률에서 정의하는 기반시설 중 ''공동구''가 해당하는 시설은? ', '', '', 'N', now(), now());

-- Q63
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('7', '1', '68', '다음 중 아디케스법의 기본 개념으로 옳은 것은? ', '', '', 'N', now(), now());

-- Q64
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('7', '1', '69', '토지이용 결정이론에서 선형지대이론의 특징으로 옳은 것은? ', '', '', 'N', now(), now());

-- Q65
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('7', '1', '70', '기능 및 주제에 따른 도시공원의 종류와 내용으로 옳지 않은 것은? ', '', '', 'N', now(), now());

-- Q66
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('7', '1', '71', '도로의 기능별 구분 중 주간선도로를 집산도로 또는 주요 교통발생원과 연결하여 시·군 교통의 집산기능을 하고 근린주거구역의 외곽을 형성하는 도로는? ', '', '', 'N', now(), now());

-- Q67
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('7', '1', '72', '도시의 근린생활권 중 공간적 범위가 큰 단계에서 작은 단계로 올바르게 나열한 것은? ', '', '', 'N', now(), now());

-- Q68
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('7', '1', '73', '국토의 계획 및 이용에 관한 법률에 의한 용도지역 중 관리지역에 해당되지 않는 것은? ', '', '', 'N', now(), now());

-- Q69
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('7', '1', '74', '보행자전용도로의 결정기준으로 옳지 않은 것은? ', '', '', 'N', now(), now());

-- Q70
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('7', '1', '75', '도시·군계획시설로서 도로의 규모별 구분으로 옳지 않은 것은? ', '', '', 'N', now(), now());

-- Q71
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('7', '1', '76', '상위 계획에서 하위 계획 순으로 올바르게 나열한 것은? ', '', '', 'N', now(), now());

-- Q72
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('7', '1', '77', '케빈 린치(Kevin Lynch)가 주장한 도시의 이미지를 결정하는 구성요소에 해당하지 않는 것은? ', '', '', 'N', now(), now());

-- Q73
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('7', '1', '78', '토지이용계획을 입지계획·시설 및 규모 계획·입지 배분 계획으로 분류할 때, 입지배분 계획의 내용으로 적절하지 않은 것은? ', '', '', 'N', now(), now());

-- Q74
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('7', '1', '79', '도시 및 지역경제 분석 방법 중의 하나로, 지역산업의 변화를 내적요인과 외적요인에 해당하는 국가 전체의 성장요인(national share), 산업구조적 요인(industry mix), 지역의 경쟁력 요인(local factor)으로 나누어 파악하고, 이를 통해 지역의 산업성장을 분석하는 방법은? ', '', '', 'N', now(), now());

-- Q75
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('7', '1', '82', '도로를 횡단하는 자전거 운전자의 안전을 위하여 기준에 따라 자전거횡단도를 설치할 수 있는 자는? ', '', '', 'N', now(), now());

-- Q76
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('7', '1', '83', '도로법상 도로의 종류에 따른 도로관리청의 연결로 옳지 않은 것은? (단, 국가지원지방도는 특별시, 광역시 또는 특별자치시 관할구역에 있는 구간의 경우는 고려하지 않는다.) ', '', '', 'N', now(), now());

-- Q77
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('7', '1', '84', '국가기간교통망계획과 다른 계획과의 관계에 관한 설명으로 옳은 것은? ', '', '', 'N', now(), now());

-- Q78
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('7', '1', '85', '도로법에 의한 도로의 종류와 등급 분류에 해당되지 않는 것은? ', '', '', 'N', now(), now());

-- Q79
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('7', '1', '86', '도시교통의 원활한 소통과 교통편의 증진을 위해 지정하는 교통혼잡 특별관리구역과 교통혼잡 특별관리시설물의 지정기준으로 옳지 않은 것은? (단, “혼잡시간대”란 일정한 지역이 그 지역을 통과하거나 둘러싼 도로 중 1개 이상의 도로에서 시간대별 평균 통행속도가 시속 15킬로미터 미만인 상태를 뜻한다.) ', '', '', 'N', now(), now());

-- Q80
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('7', '1', '87', '국토교통부장관이 도시교통정비구역으로 지정·고시할 수 있는 도시의 인구 규모 기준이 옳은 것은? ', '', '', 'N', now(), now());

-- Q81
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('7', '1', '88', '도로교통법의 목적과 가장 관계가 먼 것은? ', '', '', 'N', now(), now());

-- Q82
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('7', '1', '89', '국가통합교통체계효율화법규상 국가교통 데이터베이스 점검단 구성 및 운영에 관한 설명으로 옳지 않은 것은? ', '', '', 'N', now(), now());

-- Q83
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('7', '1', '90', '시·군·구 교통안전정책심의위원회에 관한 설명으로 옳지 않은 것은? ', '', '', 'N', now(), now());

-- Q84
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('7', '1', '91', '국가통합교통체계효율화법령상 대통령령으로 정하는 대구모 개발사업의 범위와 면적 기준이 옳지 않은 것은? ', '', '', 'N', now(), now());

-- Q85
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('7', '1', '92', '교통안전법상 국가교통안전기본계획은 몇 년 단위로 수립하여야 하는가? ', '', '', 'N', now(), now());

-- Q86
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('7', '1', '93', '도로교통법규에 따라 차도의 노면으로부터 높이 4.0m인 구조물의 전면에 차 높이 제한표지를 설치하고자 할 때 표시하여야 할 수치는? ', '', '', 'N', now(), now());

-- Q87
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('7', '1', '94', '주차장의 수급(需給) 실태조사에 대한 설명으로 옳지 않은 것은? ', '', '', 'N', now(), now());

-- Q88
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('7', '1', '95', '부설주차장 설치의무가 면제되는 주차대수 규모 기준으로 옳은 것은? ', '', '', 'N', now(), now());

-- Q89
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('7', '1', '97', '다음 중 도로교통법 횡단보도의 설치기준으로 옳지 않은 것은? ', '', '', 'N', now(), now());

-- Q90
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('7', '1', '98', '도로법에 따라 도로 구조의 파손 방지, 미관의 훼손 또는 교통에 대한 위험 방지를 위하여 필요하면 소관 도로의 경계선에서 20m(고속국도의 경우 50m)를 초과하지 아니하는 범위에서 도로관리청이 지정할 수 있는 것은? ', '', '', 'N', now(), now());

-- Q91
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('7', '1', '99', '도시교통정비촉진법상 원칙적으로 도시교통정비지역을 지정·고시할 수 있는 자는? ', '', '', 'N', now(), now());

-- Q92
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('7', '1', '100', '국가통합교통체계효율화법에서 규정하는 타당성 평가에 관한 설명으로 옳지 않은 것은? ', '', '', 'N', now(), now());

-- Q93
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('7', '1', '101', '영국의 수미드(R. J. Smeed)가 1938년에 발표한 교통사고 예측 모형에서 교통사고 사망자 수를 나타내는데 이용한 변수로만 나열된 것은? ', '', '', 'N', now(), now());

-- Q94
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('7', '1', '102', '도로운영과 사고에 관한 설명으로 옳지 않은 것은? ', '', '', 'N', now(), now());

-- Q95
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('7', '1', '103', '사고다발지점 선정 방법 중 부상(사고)의 유형에 따라 가중치를 부여하여 합계 점수가 가장 높은 지점을 선정하는 방법은? ', '', '', 'N', now(), now());

-- Q96
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('7', '1', '104', '사고위험이 높은 장소를 선정할 때 사용하지 않는 지표는? ', '', '', 'N', now(), now());

-- Q97
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('7', '1', '105', '차량의 미끄럼거리 추정에 관한 설명이 틀린 것은? ', '', '', 'N', now(), now());

-- Q98
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('7', '1', '106', '사고심각도기법 중 EPDO가 뜻하는 내용은? ', '', '', 'N', now(), now());

-- Q99
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('7', '1', '107', '고속도로의 사고율이 평균 이하인 도로의 특징과 가장 관계가 먼 것은? ', '', '', 'N', now(), now());

-- Q100
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('7', '1', '109', '도로교통 안전프로그램의 내용과 가장 거리가 먼 것은? ', '', '', 'N', now(), now());

-- Q101
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('7', '1', '110', '과속방지턱(speed hump)에 대한 설명으로 옳지 않은 것은? ', '', '', 'N', now(), now());

-- Q102
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('7', '1', '111', '어느 차량이 평지의 도로에서 단속적으로 20m에 이어 40m의 바퀴자국을 남기고 정지하였을 경우 이 차량의 초기 속도는? (단, 노면 마찰계수는 0.5이다.) ', '', '', 'N', now(), now());

-- Q103
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('7', '1', '112', '약한 지주와 강한 레일로 구성되며 충격차량을 억제하기 위하여 주로 레일요소의 작용에 의존하는 노변방호책은? ', '', '', 'N', now(), now());

-- Q104
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('7', '1', '113', '개선 사업을 시행하기 전 연평균 사고건수가 10건, 연평균 ADT가 6000대인 교차로에 사고 감소율이 20%인 교통안전사업을 시행한 후 예측되는 연평균 사고감소 건수는? (단, 이 교차로의 사업시행 후 연평균 ADT는 9000대로 예측된다.) ', '', '', 'N', now(), now());

-- Q105
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('7', '1', '114', '차량 A가 10m 높이의 언덕에서 추락하였다. 추락 후 노면에 떨어진 지점까지의 수평거리가 17m 일 경우 차량 A 의 초기속도는? ', '', '', 'N', now(), now());

-- Q106
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('7', '1', '115', '교통안전 전략으로서 노출통제에 해당하는 것은? ', '', '', 'N', now(), now());

-- Q107
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('7', '1', '116', '사고다발지역 선정 및 도로안전개선사업 시행의 중요성에 대한 설명 중 옳지 않은 것은? ', '', '', 'N', now(), now());

-- Q108
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('7', '1', '117', '지구교통개선사업 등에 널리 적용되고 있는 교통 정온화(Traffic calming) 기법 중 주행속도의 억제 기능을 갖는 대책이 아닌 것은? ', '', '', 'N', now(), now());

-- Q109
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('7', '1', '118', '차가 주행할 때 타이어의 공기압이 적은 상태이면 타이어 접지면이 압축되어 변형하면서 회전하므로 타이어가 물결치는 모양이 되어 파열의 원인이 되는 현상을 무엇이라 하는가? ', '', '', 'N', now(), now());

-- Q110
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('7', '1', '119', '다음의 교통안전 조치 중 이동성을 저해할 수 있는 것은? ', '', '', 'N', now(), now());

-- Q111
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('7', '1', '120', '곡선반경 250m인 도로 구간에서 편주현상(yawing)이 일어나 차량이 전복하는 사고가 발생하였다. 편주혼 시작점의 곡선반경 250m, 편경사 5%, 횡방향 마찰계수가 0.4일 때, 편주가 시작되는 점에서 이 차량의 주행속도는 얼마인가? ', '', '', 'N', now(), now());
