-- TEST
insert into test (test_nm, created_date, modified_date) values ('SQLD', now(), now());

-- VERSION
insert into version (test_id, ver_nbr, ver_nm, created_date, modified_date) values ('5', '1', '기출 21회차', now(), now());

-- Q1
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, is_multi_answer, created_date, modified_date) values ('5', '1', '1', '데이터 모델링에 대한 아래 보기 설명 중 알맞은 것은?', '논리 모델링의 외래키는 물리 모델에서 반드시 구현되지 않음. (선택 사항임)<br>
실제 데이터베이스 구축 시 참고되는 모델은 물리적 데이터 모델링이다<br>
개념 모델링에서 물리 모델링으로 가면서 더 구체적이며 개념 모델링이 가장 추상적이다<br>
데이터 모델링의 3요소는 Thing, Attributes, Relationship 이다', '', 'false', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('5', '1', '1', '1', '논리 모델링의 외래키는 물리 모델에서 반드시 구현되지는 않는다', 'true', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('5', '1', '1', '2', '실제로 데이터베이스를 구축할 때 참고되는 모델은 개념적 데이터 모델링이다', 'FALSE', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('5', '1', '1', '3', '물리 모델링 -> 논리 모델링 -> 개념 모델링 단계로 갈수록 구체적이다', 'FALSE', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('5', '1', '1', '4', '데이터 모델링의 3가지 요소는 Process, Attributes, Relationship 이다', 'FALSE', now(), now());

-- Q2
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, is_multi_answer, created_date, modified_date) values ('5', '1', '2', '데이터 모델링에 대한 단계 중 아래에서 설명하는 단계는 어떤 단계의 모델링인가?<br><br>추상화 수준이 높고 업무중심적이고 포괄적인 수준의 모델링 진행. 전사적 데이터 모델링.<br>EA 수립 시 많이 이용됨', '', '', 'false', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('5', '1', '2', '1', '개념적 데이터 모델링', 'true', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('5', '1', '2', '2', '논리적 데이터 모델링', 'FALSE', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('5', '1', '2', '3', '물리적 데이터 모델링', 'false', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('5', '1', '2', '4', '추상적 데이터 모델링', 'FALSE', now(), now());

-- Template
-- Q20
-- insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, is_multi_answer, created_date, modified_date) values ('5', '1', '1', '', '', '', 'false', now(), now());
-- insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('5', '1', '1', '1', '', 'FALSE', now(), now());
-- insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('5', '1', '1', '2', '', 'FALSE', now(), now());
-- insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('5', '1', '1', '3', '', 'TRUE', now(), now());
-- insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('5', '1', '1', '4', '', 'FALSE', now(), now());