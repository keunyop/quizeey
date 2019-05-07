-- TEST
insert into test (test_nm, created_date, modified_date) values ('SQLD', now(), now());

-- VERSION
insert into version (test_id, ver_nbr, ver_nm, created_date, modified_date) values ('5', '1', '기출 21회차', now(), now());
insert into version (test_id, ver_nbr, ver_nm, created_date, modified_date) values ('5', '2', '기출 30회차', now(), now());

-- V21.Q1
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, is_multi_answer, created_date, modified_date) values ('5', '1', '1', '데이터 모델링에 대한 아래 보기 설명 중 알맞은 것은?', '논리 모델링의 외래키는 물리 모델에서 반드시 구현되지 않음. (선택 사항임)<br>
실제 데이터베이스 구축 시 참고되는 모델은 물리적 데이터 모델링이다<br>
개념 모델링에서 물리 모델링으로 가면서 더 구체적이며 개념 모델링이 가장 추상적이다<br>
데이터 모델링의 3요소는 Thing, Attributes, Relationship 이다', '', 'false', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('5', '1', '1', '1', '논리 모델링의 외래키는 물리 모델에서 반드시 구현되지는 않는다', 'true', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('5', '1', '1', '2', '실제로 데이터베이스를 구축할 때 참고되는 모델은 개념적 데이터 모델링이다', 'FALSE', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('5', '1', '1', '3', '물리 모델링 -> 논리 모델링 -> 개념 모델링 단계로 갈수록 구체적이다', 'FALSE', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('5', '1', '1', '4', '데이터 모델링의 3가지 요소는 Process, Attributes, Relationship 이다', 'FALSE', now(), now());

-- V21.Q2
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, is_multi_answer, created_date, modified_date) values ('5', '1', '2', '데이터 모델링에 대한 단계 중 아래에서 설명하는 단계는 어떤 단계의 모델링인가?<br><br>추상화 수준이 높고 업무중심적이고 포괄적인 수준의 모델링 진행. 전사적 데이터 모델링.<br>EA 수립 시 많이 이용됨', '', '', 'false', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('5', '1', '2', '1', '개념적 데이터 모델링', 'true', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('5', '1', '2', '2', '논리적 데이터 모델링', 'FALSE', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('5', '1', '2', '3', '물리적 데이터 모델링', 'false', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('5', '1', '2', '4', '추상적 데이터 모델링', 'FALSE', now(), now());

-- V30.Q1
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, is_multi_answer, created_date, modified_date) values ('5', '2', '1', '데이터 모델링이 최종적으로 완료된 상태라고 정의할 수 있는, 즉 물리적인 스카마 설계를 하기 전 단계를 가리키는 말은?', '논리 데이터 모델링의 결과로 얻어지는 논리 데이터 모델은 데이터 모델링이 최종적으로 완료된 상태라고 정의할 수 있다. 즉 물리적인 스키마 설계를 하기 전 단계의 ‘데이터 모델’ 상태를 일컫는 말이다.', '', 'false', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('5', '2', '1', '1', '개괄 데이터 모델링', 'FALSE', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('5', '2', '1', '2', '개념적 데이터 모델링', 'FALSE', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('5', '2', '1', '3', '논리적 데이터 모델링', 'TRUE', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('5', '2', '1', '4', '물리적 데이터 모델링', 'FALSE', now(), now());

-- V30.Q2
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, is_multi_answer, created_date, modified_date) values ('5', '2', '2', '엔터티 - 인스턴스 - 속성 - 속성값에 대한 관계 설명중 틀린 것을 고르시오.', '하나의 속성은 하나의 속성값을 가지며 하나 이상의 속성값을 가지는 경우 정규화가 필요함', '', 'false', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('5', '2', '2', '1', '한 개의 엔터티는 두 개 이상의 인스턴스의 집합이어야 한다.', 'FALSE', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('5', '2', '2', '2', '한 개의 엔터티는 두 개 이상의 속성을 갖는다.', 'FALSE', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('5', '2', '2', '3', '하나의 속성은 하나 이상의 속성값을 가진다.', 'TRUE', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('5', '2', '2', '4', '하나의 엔터티의 인스터스는 다른 엔터티의 인스턴스간의 관계인 Paring 을 가진다.', 'FALSE', now(), now());

-- V30.Q3
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, is_multi_answer, created_date, modified_date) values ('5', '2', '3', '다음주 엔터티의 종류가 아닌 것은?', '엔터티 기준<br> - 엔터티는 사람, 장소, 물건, 사건, 개념 등의 명사에 해당한다.<br> - 엔터티는 업무상 관리가 필요한 관심사에 해당한다.<br> - 엔터티는 저장이 되기 위한 어떤 것(Thing)이다.', '', 'false', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('5', '2', '3', '1', '교수', 'FALSE', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('5', '2', '3', '2', '학생', 'FALSE', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('5', '2', '3', '3', '청약자', 'TRUE', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('5', '2', '3', '4', '수강', 'FALSE', now(), now());

-- Template
-- Q20
-- insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, is_multi_answer, created_date, modified_date) values ('5', '1', '1', '', '', '', 'false', now(), now());
-- insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('5', '1', '1', '1', '', 'FALSE', now(), now());
-- insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('5', '1', '1', '2', '', 'FALSE', now(), now());
-- insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('5', '1', '1', '3', '', 'TRUE', now(), now());
-- insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('5', '1', '1', '4', '', 'FALSE', now(), now());