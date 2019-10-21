
-- VERSION
insert into version (test_id, ver_nbr, ver_nm, created_date, modified_date) values ('13', '1', '2011-10-09 기출문제', now(), now());
-- QUESTION
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('13', '1', '1', ' 기관의 냉각팬에 대한 설명 중 틀린 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '1', '1', ' 유체 커플링식은 냉각수의 온도에 따라서 작동된다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '1', '2', ' 전동팬은 냉각수의 온도에 따라 작동된다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '1', '3', ' 전동팬이 작동되지 않을 때는 물 펌프도 회전하지 않는다.', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '1', '4', ' 전동팬의 작동과 관계없이 물 펌프는 항상 회전한다.', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('13', '1', '2', ' 기관 과열의 주요 원인이 아닌 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '2', '1', ' 라디에이터 코어의 막힘', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '2', '2', ' 냉각장치 내부의 물때 과다', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '2', '3', ' 냉각수의 부족', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '2', '4', ' 엔진 오일량 과다', 'Y', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('13', '1', '3', ' 다음 중 연소 시 발생하는 질소산화물(NOx)의 발생 원인과 가장 밀접한 관계가 있는 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '3', '1', ' 높은 연소 온도	', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '3', '2', ' 가속 불량', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '3', '3', ' 흡입 공기 부족	', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '3', '4', ' 소염 경계층', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('13', '1', '4', ' 디젤기관에서 시동이 되지 않는 원인으로 맞는 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '4', '1', ' 연료공급 펌프의 연료공급 압력이 높다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '4', '2', ' 가속 페달을 밟고 시동하였다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '4', '3', ' 배터리 방전으로 교체가 필요한 상태이다.', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '4', '4', ' 크랭크축 회전속도가 빠르다.', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('13', '1', '5', ' 디젤기관에서 사용하는 분사노즐의 종류에 속하지 않는 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '5', '1', ' 핀틀(pintle)형', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '5', '2', ' 스로틀(throttle)형', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '5', '3', ' 홀(hole)형', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '5', '4', ' 싱글 포인트(single point)형', 'Y', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('13', '1', '6', ' 디젤기관에서 부조 발생의 원인이 아닌 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '6', '1', ' 발전기 고장			', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '6', '2', ' 거버너 작용 불량', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '6', '3', ' 분사시기 조정 불량		', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '6', '4', ' 연료의 압송 불량', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('13', '1', '7', ' 디젤기관에서 연료장치 공기빼기 순서가 바른 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '7', '1', ' 공급펌프 → 연료여과기 → 분사펌프', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '7', '2', ' 공급펌프 → 분사펌프 → 연료여과기', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '7', '3', ' 연료여과기 → 공급펌프 → 분사펌프', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '7', '4', ' 연료여과기 → 분사펌프 → 공급펌프', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('13', '1', '8', ' 운전 중인 기관의 에어클리너가 막혔을 때 나타나는 현상으로 맞는 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '8', '1', ' 배출가스 색은 검고, 출력은 저하한다.', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '8', '2', ' 배출가스 색은 희고, 출력은 정상이다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '8', '3', ' 배출가스 색은 청백색이고, 출력은 증가된다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '8', '4', ' 배출가스 색은 무색이고, 출력은 무관하다.', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('13', '1', '9', ' 엔진의 윤활유 소비량이 과다해지는 가장 큰 원인은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '9', '1', ' 기관의 과냉', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '9', '2', ' 피스톤 링 마멸', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '9', '3', ' 오일 여과기 필터 불량', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '9', '4', ' 냉각펌프 손상', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('13', '1', '10', ' 흡·배기 밸브의 구비조건이 아닌 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '10', '1', ' 열전도율이 좋을 것', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '10', '2', ' 열에 대한 팽창율이 적을 것', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '10', '3', ' 열에 대한 저항력이 작을 것', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '10', '4', ' 가스에 견디고, 고온에 잘 견딜 것', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('13', '1', '11', ' 일반적으로 기관에 많이 사용되는 윤활 방법은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '11', '1', ' 수 급유식		', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '11', '2', ' 적하 급유식', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '11', '3', ' 압송 급유식	', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '11', '4', ' 분무 급유식', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('13', '1', '12', ' 기관 실린더(cylinder) 벽에서 마멸이 가장 크게 발생하는 부위는?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '12', '1', ' 상사점 부근	', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '12', '2', ' 하사점 부근', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '12', '3', ' 중간 부분		', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '12', '4', ' 하사점 이하', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('13', '1', '13', ' 기동 전동기의 시험 항목으로 맞지 않는 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '13', '1', ' 무부하 시험	', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '13', '2', ' 회전력 시험', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '13', '3', ' 저항 시험		', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '13', '4', ' 중부하 시험', 'Y', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('13', '1', '14', ' 전압 조정기의 종류에 해당하지 않는 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '14', '1', ' 접점식		', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '14', '2', ' 카본파일식', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '14', '3', ' 트랜지스터식	', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '14', '4', ' 저항식', 'Y', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('13', '1', '15', ' 예열플러그를 빼서 보았더니 심하게 오염되어있다. 그 원인으로 가장 적합한 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '15', '1', ' 불완전 연소 또는 노킹', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '15', '2', ' 엔진 과열', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '15', '3', ' 플러그의 용량 과다', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '15', '4', ' 냉각수 부족', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('13', '1', '16', ' 운전 중 갑자기 계기판에 충전 경고등이 점등되었다. 그 현상으로 맞는 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '16', '1', ' 정상적으로 충전이 되고 있음을 나타낸다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '16', '2', ' 충전이 되지 않고 있음을 나타낸다.', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '16', '3', ' 충전계통에 이상이 없음을 나타낸다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '16', '4', ' 주기적으로 점등되었다가 소동되는 것이다.', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('13', '1', '17', ' 납산 축전지가 방전되어 급속 충전을 할 때의 설명으로 틀린 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '17', '1', ' 충전 중 전해액의 온도가 45℃가 넘지 않도록 한다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '17', '2', ' 충전 중 가스가 많이 발생되면 충전을 중단한다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '17', '3', ' 충전전류는 축전지 용량과 같게 한다.', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '17', '4', ' 충전시간은 가능한 짧게 한다.', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('13', '1', '18', ' 건설기계에 사용하는 축전지 2개를 직렬로 연결하였을 때 변화 되는 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '18', '1', ' 전압이 증가된다.', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '18', '2', ' 사용 전류가 증가된다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '18', '3', ' 비중이 증가된다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '18', '4', ' 전압 및 이용 전류가 증가된다.', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('13', '1', '19', ' 지게차 작업장치의 동력전달 기구가 아닌 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '19', '1', ' 리프터 체인	', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '19', '2', ' 틸트 실린더', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '19', '3', ' 리프트 실린더	', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '19', '4', ' 트랜치호', 'Y', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('13', '1', '20', ' 운전 중 클러치가 미끄러질 때의 영향이 아닌 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '20', '1', ' 속도 감소		', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '20', '2', ' 견인력 감소', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '20', '3', ' 연료소비량 증가	', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '20', '4', ' 엔진의 과냉', 'Y', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('13', '1', '21', ' 무한궤도식 굴삭기와 타이어식 굴삭기의 운전 특성에 대한 설명으로 틀린 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '21', '1', ' 무한궤도식은 기복이 심한 곳에서 작업이 불리하다.', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '21', '2', ' 타이어식은 변속 및 주행 속도가 빠르다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '21', '3', ' 무한궤도식은 습지, 사지에서 작업이 유리하다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '21', '4', ' 타이어식은 장거리 이동이 쉽고 기동성이 양호하다.', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('13', '1', '22', ' 휠 로더의 붐과 버킷 레버를 동시에 당기면 작동은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '22', '1', ' 붐만 상승한다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '22', '2', ' 버킷만 오무려 진다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '22', '3', ' 붐은 상승하고 버킷은 오무려 진다.', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '22', '4', ' 작동이 안 된다.', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('13', '1', '23', ' 파워스티어링에서 핸들이 매우 무거워 조작하기 힘든 상태일 때의 원인으로 맞는 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '23', '1', ' 바퀴가 습지에 있다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '23', '2', ' 조향 펌프에 오일이 부족하다.', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '23', '3', ' 볼 조인트의 교환시기가 되었다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '23', '4', ' 핸들 유격이 크다.', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('13', '1', '24', ' 진공식 제동 배력 장치의 설명 중에서 옳은 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '24', '1', ' 진공 밸브가 새면 브레이크가 전혀 듣지 않는다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '24', '2', ' 릴레이 밸브의 다이어프램이 파손되면 브레이크가 듣지 않는다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '24', '3', ' 릴레이 밸브 피스톤 컵이 파손되어도 브레이크는 듣는다.', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '24', '4', ' 하이드로릭 피스톤의 체크 볼이 밀착 불량이면 브레이크가 듣지 않는다.', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('13', '1', '25', ' 일반적으로 기중기 작업시 붐의 최대와 최소 제한각도로 가장 적합한 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '25', '1', ' 최대 20°, 최소 30°', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '25', '2', ' 최대 78°, 최소 20°', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '25', '3', ' 최대 78°, 최소 55°', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '25', '4', ' 최대 180°, 최소 20°', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('13', '1', '26', ' 자동변속기가 장착된 건설기계의 모든 변속단에서 출력이 떨어질 경우 점검해야 할 항목과 거리가 먼 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '26', '1', ' 오일의 부족', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '26', '2', ' 토크컨버터 고장', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '26', '3', ' 엔진고장으로 출력 부족', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '26', '4', ' 추진축 휨', 'Y', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('13', '1', '27', ' 건설기계를 산(매수 한) 사람이 등록사항변경(소유권 이전) 신고를 하지 않아 등록사항 변경신고를 독촉하였으나 이를 이행하지 않을 경우 판(매도 한) 사람이 할 수 있는 조치로서 가장 적합한 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '27', '1', ' 소유권 이전 신고를 조속히 하도록 매수 한 사람에게 재차 독촉한다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '27', '2', ' 매도 한 사람이 직접 소유권 이전 신고를 한다.', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '27', '3', ' 소유권 이전 신고를 조속히 하도록 소송을 제기한다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '27', '4', ' 아무런 조치도 할 수 없다.', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('13', '1', '28', ' 덤프트럭이 건설기계 검사소 검사가 아닌 출장검사를 받을 수 있는 경우는?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '28', '1', ' 너비가 3m인 경우', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '28', '2', ' 최고 속도가 40km/h인 경우', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '28', '3', ' 자체중량이 25톤인 경우', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '28', '4', ' 축중이 5톤인 경우', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('13', '1', '29', ' 노면이 얼어붙은 경우 또는 폭설로 가시거리가 100미터 이내인 경우 최고속도의 얼마나 감속 운행하여야 하는가?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '29', '1', ' 50/100		', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '29', '2', ' 30/100', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '29', '3', ' 40/100		', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '29', '4', ' 20/100', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('13', '1', '31', ' 등록건설기계의 기종별 표시방법으로 옳은 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '31', '1', ' 01 : 불도저	', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '31', '2', ' 02 : 모터그레이더', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '31', '3', ' 03 : 지게차	', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '31', '4', ' 04 : 덤프트럭', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('13', '1', '32', ' 편도 4차로 일반도로의 경우 교차로 30m 전방에서 우회전을 하려면 몇 차로로 진입 통행해야 하는가?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '32', '1', ' 1차로로 통행한다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '32', '2', ' 2차로와 1차로로 통행한다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '32', '3', ' 4차로로 통행한다.', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '32', '4', ' 3차로만 통행 가능하다.', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('13', '1', '33', ' 정차 및 주차금지 장소에 해당 되는 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '33', '1', ' 건널목 가장자리로부터 15m 지점', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '33', '2', ' 정류장 표지판으로부터 12m 지점', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '33', '3', ' 도로의 모퉁이로부터 4m 지점', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '33', '4', ' 교차로 가장자리로부터 10m 지점', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('13', '1', '34', ' 특별 표지판을 부착하여야 할 건설기계의 범위에 해당하는 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '34', '1', ' 높이가 5미터인 건설기계', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '34', '2', ' 총중량이 50톤인 건설기계', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '34', '3', ' 길이가 16미터인 건설기계', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '34', '4', ' 최소회전반경이 13미터인 건설기계', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('13', '1', '35', ' 현장에 경찰 공무원이 없는 장소에서 인명사고와 물건의 손괴를 입힌 교통사고가 발생하였을 때 가장 먼저 취할 조치는?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '35', '1', ' 손괴한 물건 및 손괴 정도를 파악한다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '35', '2', ' 즉시 피해자 가족에게 아리고 합의한다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '35', '3', ' 즉시 사상자를 구호하고 경찰 공무원에게 신고한다.', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '35', '4', ' 승무원에게 사상자를 알리게 하고 회사에 알린다.', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('13', '1', '36', ' 3톤 미만 지게차의 소형건설기계 조종 교육시간은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '36', '1', ' 이론 6시간, 실습 6시간', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '36', '2', ' 이론 4시간, 실습 8시간', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '36', '3', ' 이론 12시간, 실습 12시간', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '36', '4', ' 이론 10시간, 실습 14시간', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('13', '1', '37', ' 건설기계에 사용되는 유압 실린더 작용은 어떠한 것을 응용한 것인가?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '37', '1', ' 베르누이의 정리	', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '37', '2', ' 파스칼의 정리', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '37', '3', ' 지렛대의 원리	', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '37', '4', ' 후크의 법칙', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('13', '1', '39', ' 작동형, 평형피스톤형 등의 종류가 있으며 회로의 압력을 일정하게 유지시키는 밸브는?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '39', '1', ' 릴리프 밸브	', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '39', '2', ' 메이크업 밸브', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '39', '3', ' 시퀀스 밸브	', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '39', '4', ' 무부하 밸브', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('13', '1', '40', ' 유압 실린더는 유체의 힘을 어떤 운동으로 바꾸는가?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '40', '1', ' 회전 운동		', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '40', '2', ' 직선 운동', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '40', '3', ' 곡선 운동		', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '40', '4', ' 비틀림 운동', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('13', '1', '41', ' 유압 작동유의 점도가 너무 높을 때 발생되는 현상으로 맞는 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '41', '1', ' 동력 손실의 증가		', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '41', '2', ' 내부 누설의 증가', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '41', '3', ' 펌프 효율의 증가		', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '41', '4', ' 마찰 마모 감소', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('13', '1', '42', ' 일반적으로 오일탱크의 구성품이 아닌 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '42', '1', ' 스트레이너		', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '42', '2', ' 배플', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '42', '3', ' 드레인플러그	', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '42', '4', ' 압력조절기', 'Y', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('13', '1', '43', ' 다음 중 액추에이터의 입구 쪽 관로에 설치한 유량제어밸브로 흐름을 제어하여 속도를 제어하는 회로는?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '43', '1', ' 시스템 회로(system circuit)', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '43', '2', ' 블리도오프 회로(bled-off circuit)', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '43', '3', ' 미터인 회로(meter-in circuit)', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '43', '4', ' 미터아웃 회로(meter-out circuit)', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('13', '1', '44', ' 유압장치의 구성요소가 아닌 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '44', '1', ' 유니버셜 조인트	', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '44', '2', ' 오일탱크', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '44', '3', ' 펌프		', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '44', '4', ' 제어밸브', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('13', '1', '46', ' 유압에너지를 공급받아 회전운동을 하는 기기를 무엇이라 하는가?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '46', '1', ' 펌프		', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '46', '2', ' 모터', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '46', '3', ' 밸브		', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '46', '4', ' 롤러 리미트', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('13', '1', '47', ' 볼트 등을 조일 때 조이는 힘을 측정하기 위하여 쓰는 렌치는?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '47', '1', ' 복스 렌치		', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '47', '2', ' 오픈엔드 렌치', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '47', '3', ' 소켓 렌치		', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '47', '4', ' 토크 렌치', 'Y', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('13', '1', '48', ' 크레인으로 무거운 물건을 위로 달아 올릴 때 주의할 점이 아닌 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '48', '1', ' 달아 올릴 화물의 무게를 파악하여 제한하중 이하에서 작업한다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '48', '2', ' 매달린 화물이 불안전하다고 생각될 때는 작업을 중지한다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '48', '3', ' 신호의 규정이 없으므로 작업자가 적절히 한다.', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '48', '4', ' 신호자의 신호에 따라 작업한다.', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('13', '1', '49', ' 전기장치의 퓨즈가 끊어져서 다시 새것으로 교체하였으나 또 끊어졌다면 어떤 조치가 가장 옳은가?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '49', '1', ' 계속 교체한다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '49', '2', ' 용량이 큰 것으로 갈아 끼운다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '49', '3', ' 구리선이나 납선으로 바꾼다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '49', '4', ' 전기장치의 고장개소를 찾아 수리한다.', 'Y', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('13', '1', '51', ' 가동하고 있는 엔진에서 화재가 발생하였다. 불을 끄기 위한 조치 방법으로 가장 올바른 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '51', '1', ' 원인분석을 하고 모래를 뿌린다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '51', '2', ' 포말 소화기를 사용 후 엔진 시동스위치를 끈다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '51', '3', ' 엔진 시동스위치를 끄고 ABC 소화기를 사용한다.', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '51', '4', ' 엔진을 급가속하여 팬의 강한 바람을 일으켜 불을 끈다.', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('13', '1', '52', ' 동력 전달장치에서 가장 재해가 많이 발생하는 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '52', '1', ' 차축		', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '52', '2', ' 기어', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '52', '3', ' 피스톤		', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '52', '4', ' 벨트', 'Y', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('13', '1', '53', ' 크레인으로 인양 시 물체의 중심을 측정하여 인양하여야 한다. 다음 중 잘못된 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '53', '1', ' 형상이 복잡한 물체의 무게 중심을 확인한다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '53', '2', ' 인양 물체를 서서히 올려 지상 약 30cm지점에서 정지하여 확인한다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '53', '3', ' 인양 물체의 중심이 높으면 물체가 기울 수 있다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '53', '4', ' 와이어로프나 매달기용 체인이 벗겨질 우려가 있으면 되도록 높이 인양한다.', 'Y', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('13', '1', '54', ' 구급처치 중에서 환자의 상태를 확인하는 사항과 가장 거리가 먼 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '54', '1', ' 의식		', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '54', '2', ' 상처', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '54', '3', ' 출혈		', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '54', '4', ' 격리', 'Y', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('13', '1', '55', ' 작업장에서 전기가 예고 없이 정전 되었을 경우 전기로 작동하던 기계기구의 조치방법으로 틀린 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '55', '1', ' 즉시 스위치를 끈다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '55', '2', ' 안전을 위해 작업장을 정리해 놓는다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '55', '3', ' 퓨즈의 단선 유, 무를 검사한다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '55', '4', ' 전기가 들어오는 것을 알기 위해 스위치를 켜둔다.', 'Y', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('13', '1', '56', ' 복스 렌치가 오픈 렌치보다 많이 사용되는 이유는?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '56', '1', ' 값이 싸며 적은 힘으로 작업할 수 있다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '56', '2', ' 가볍고 사용하는데 양손으로도 사용할 수 있다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '56', '3', ' 파이프 피팅 조임 등 작업용도가 다양하여 많이 사용된다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '56', '4', ' 볼트, 너트 주위를 완전히 감싸게 되어 사용 중에 미끄러지지 않는다.', 'Y', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('13', '1', '57', ' 다음 중 한국전력의 송전선로 전압으로 맞는 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '57', '1', ' 6.6kV		', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '57', '2', ' 22.9kV', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '57', '3', ' 345kV		', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '57', '4', ' 0.6kV', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('13', '1', '58', ' 일반 도시가스 사업자의 지하배관 설치시 도로폭 8m 이상인 도로에서는 관련법상 어느 정도의 깊이에 배관이 설치되어 있는가?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '58', '1', ' 1.5m 이상		', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '58', '2', ' 1.2m 이상', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '58', '3', ' 1.0m 이상		', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '58', '4', ' 0.6m 이상', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('13', '1', '59', ' 도시가스사업법에서 압축가스일 경우 중압이라 함은 얼마의 압력을 말하는가?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '59', '1', ' 0.1MPa ~ 1MPa 미만    ', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '59', '2', ' 0.02MPa ~ 1MPa 미만', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '59', '3', ' 1MPa ~ 10MPa 미만     ', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '59', '4', ' 10MPa ~ 100MPa 미만', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('13', '1', '60', ' 굴착도중 전력케이블 표지시트가 나왔을 경우의 조치사항으로 적합한 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '60', '1', ' 표지시트를 제거하고 계속 굴착한다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '60', '2', ' 표지시트를 제거하고 보호판이나 케이블이 확인될 때 까지 굴착한다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '60', '3', ' 즉시 굴착을 중지하고 해당 시설 관련기관에 연락한다.', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('13', '1', '60', '4', ' 표지시트를 원상태로 다시 덮고 인근 부위를 재 굴착한다.', 'N', now(), now());

