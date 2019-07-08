-- TEST
insert into test (test_nm, created_date, modified_date) values ('SQLD', now(), now());

-- VERSION
insert into version (test_id, ver_nbr, ver_nm, created_date, modified_date) values ('5', '1', '기출 21회차', now(), now());
insert into version (test_id, ver_nbr, ver_nm, created_date, modified_date) values ('5', '2', '기출 30회차', now(), now());
insert into version (test_id, ver_nbr, ver_nm, created_date, modified_date) values ('5', '3', '기출 26회차', now(), now());

-- V21.Q1
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('5', '1', '1', '데이터 모델링에 대한 아래 보기 설명 중 알맞은 것은?', '논리 모델링의 외래키는 물리 모델에서 반드시 구현되지 않음. (선택 사항임)<br>
실제 데이터베이스 구축 시 참고되는 모델은 물리적 데이터 모델링이다<br>
개념 모델링에서 물리 모델링으로 가면서 더 구체적이며 개념 모델링이 가장 추상적이다<br>
데이터 모델링의 3요소는 Thing, Attributes, Relationship 이다', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('5', '1', '1', '1', '논리 모델링의 외래키는 물리 모델에서 반드시 구현되지는 않는다', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('5', '1', '1', '2', '실제로 데이터베이스를 구축할 때 참고되는 모델은 개념적 데이터 모델링이다', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('5', '1', '1', '3', '물리 모델링 -> 논리 모델링 -> 개념 모델링 단계로 갈수록 구체적이다', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('5', '1', '1', '4', '데이터 모델링의 3가지 요소는 Process, Attributes, Relationship 이다', 'N', now(), now());

-- V21.Q2
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('5', '1', '2', '데이터 모델링에 대한 단계 중 아래에서 설명하는 단계는 어떤 단계의 모델링인가?<br><br>추상화 수준이 높고 업무중심적이고 포괄적인 수준의 모델링 진행. 전사적 데이터 모델링.<br>EA 수립 시 많이 이용됨', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('5', '1', '2', '1', '개념적 데이터 모델링', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('5', '1', '2', '2', '논리적 데이터 모델링', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('5', '1', '2', '3', '물리적 데이터 모델링', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('5', '1', '2', '4', '추상적 데이터 모델링', 'N', now(), now());

-- V21.Q3
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('5', '1', '3', '비교연산자의 어느 한쪽이 VARCHAR 유형 타입인 경우 문자 유형 비교에 대한 설명 중 가장 알맞지 않 은 것은?', 'SAPCE 를 추가하여 길이를 맞춰 비교하는 방법은 CHAR 타입인 경우이다.', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('5', '1', '3', '1', '서로 다른 문자가 나올 때까지 비교한다', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('5', '1', '3', '2', '길이가 다르다면 짧은 것이 끝날 때까지만 비교한 후에 길이가 긴 것이 크다고 판단한다', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('5', '1', '3', '3', '길이가 같고 다른 것이 없다면 같다고 판단한다', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('5', '1', '3', '4', '길이가 다르다면 작은 쪽에 SPACE 를 추가하여 길이를 같게 한 후에 비교한다', 'Y', now(), now());

-- V21.Q4
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('5', '1', '4', '아래의 SQL 에서 FUNCTION 자리에 쓰인 함수에 의한 결과값이 다른 하나는?<br><br>SELECT function(3.46) FROM DUAL;', 'FLOOR: 숫자보다 작거나 같은 최대 정수를 리턴<br>CEIL/CEILING: 숫자보다 크거나 같은 최소 정수를 리턴<br>TRUNC: 숫자를 소수 m 자리에서 잘라서 리턴 (m default: 0)<br>ROUND: 숫자를 소수 m 자리에서 반올림하여 리턴 (m default: 0)', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('5', '1', '4', '1', 'TRUNC', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('5', '1', '4', '2', 'CEIL', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('5', '1', '4', '3', 'FLOOR', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('5', '1', '4', '4', 'ROUND', 'N', now(), now());

-- V21.Q5
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('5', '1', '5', '아래의 SQL 에 대해서 결과값이 다른 것은?', 'Oracle 의 결합 함수 : CONCAT / ||<br>SQL Server : +', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('5', '1', '5', '1', 'SELECT CONCAT (''RDBMS'', '' SQL'') FROM DUAL;', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('5', '1', '5', '2', 'SELECT ''RDMBS'' || '' SQL'' FROM DUAL;', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('5', '1', '5', '3', 'SELECT ''RDBMS'' + '' SQL'' FROM DUAL;', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('5', '1', '5', '4', 'SELECT ''RDBMS'' & '' SQL'' FROM DUAL;', 'N', now(), now());

-- V26.Q1
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('5', '3', '1', '아래와 같이 문자와 문자를 연결하는 함수에 대해서 작성하시오.<br><pre>SELECT (   ) (COL1, COL2)
FROM EMP
WHERE EMPID = 10;</pre>', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('5', '3', '1', '1', 'TRIM', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('5', '3', '1', '2', 'SUBSTR', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('5', '3', '1', '3', 'CONCAT', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('5', '3', '1', '4', 'LENGTH', 'N', now(), now());

-- V30.Q1
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('5', '2', '1', '데이터 모델링이 최종적으로 완료된 상태라고 정의할 수 있는, 즉 물리적인 스카마 설계를 하기 전 단계를 가리키는 말은?', '논리 데이터 모델링의 결과로 얻어지는 논리 데이터 모델은 데이터 모델링이 최종적으로 완료된 상태라고 정의할 수 있다. 즉 물리적인 스키마 설계를 하기 전 단계의 ‘데이터 모델’ 상태를 일컫는 말이다.', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('5', '2', '1', '1', '개괄 데이터 모델링', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('5', '2', '1', '2', '개념적 데이터 모델링', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('5', '2', '1', '3', '논리적 데이터 모델링', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('5', '2', '1', '4', '물리적 데이터 모델링', 'N', now(), now());

-- V30.Q2
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('5', '2', '2', '엔터티 - 인스턴스 - 속성 - 속성값에 대한 관계 설명중 틀린 것을 고르시오.', '하나의 속성은 하나의 속성값을 가지며 하나 이상의 속성값을 가지는 경우 정규화가 필요함', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('5', '2', '2', '1', '한 개의 엔터티는 두 개 이상의 인스턴스의 집합이어야 한다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('5', '2', '2', '2', '한 개의 엔터티는 두 개 이상의 속성을 갖는다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('5', '2', '2', '3', '하나의 속성은 하나 이상의 속성값을 가진다.', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('5', '2', '2', '4', '하나의 엔터티의 인스터스는 다른 엔터티의 인스턴스간의 관계인 Paring 을 가진다.', 'N', now(), now());

-- V30.Q3
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('5', '2', '3', '다음 중 엔터티의 종류가 아닌 것은?', '엔터티 기준<br> - 엔터티는 사람, 장소, 물건, 사건, 개념 등의 명사에 해당한다.<br> - 엔터티는 업무상 관리가 필요한 관심사에 해당한다.<br> - 엔터티는 저장이 되기 위한 어떤 것(Thing)이다.', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('5', '2', '3', '1', '교수', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('5', '2', '3', '2', '학생', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('5', '2', '3', '3', '청약자', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('5', '2', '3', '4', '수강', 'N', now(), now());

-- V30.Q4
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('5', '2', '4', '발생시점에 따른 엔터티 분류에 의한 중심 엔터티가 아닌 것은?', '사원， 부서， 고객， 상품， 자재 등이 기본엔터티가 될 수 있다', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('5', '2', '4', '1', '매출', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('5', '2', '4', '2', '계약', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('5', '2', '4', '3', '사원', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('5', '2', '4', '4', '주문', 'N', now(), now());

-- V30.Q5
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('5', '2', '5', '분산 데이터베이스의 특징 중 저장 장소 명시가 불필요 하다는 특성은 무엇인가?', '사용하려는 데이터의 저장 장소 명시 불필요. 위치정보가 System Catalog 에 유지되어야 함 지역 사상 투명성: 지역 DBMS와 물리적 DB사이의 Mapping 보장 각 지역시스템 이름과 무관한 이름 사용가능', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('5', '2', '5', '1', '분할 투명성', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('5', '2', '5', '2', '위치 투명성', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('5', '2', '5', '3', '지역사상 투명성', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('5', '2', '5', '4', '병행 투명성', 'N', now(), now());

-- V30.Q6
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('5', '2', '6', '아래와 같은 테이블이 있을 때 모든 SQL 이 수행된 이후의 결과는?<br><br><pre>[테이블]
TABLE : SQLD_D5
        COL1 VARCHAR2(30)
        COL2 NUMBER 
 
[SQL]
INSERT INTO SQLD_D5(COL1, COL2) VALUES(''ABCD'',NULL);
INSERT INTO SQLD_D5(COL1, COL2) VALUES(''BC'',NULL);
ALTER TABLE SQLD_D5 MODIFY COL2 DEFAULT 10;
INSERT INTO SQLD_D5(COL1, COL2) VALUES(''XY'',NULL);
INSERT INTO SQLD_D5(COL1) VALUES(''EXD'');
SELECT SUM(COL2) FROM SQLD_D5;</pre>', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('5', '2', '6', '1', '0', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('5', '2', '6', '2', '10', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('5', '2', '6', '3', '20', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('5', '2', '6', '4', '40', 'N', now(), now());


-- Template
-- Q20
-- insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('5', '1', '1', '', '', '', 'N', now(), now());
-- insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('5', '1', '1', '1', '', 'N', now(), now());
-- insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('5', '1', '1', '2', '', 'N', now(), now());
-- insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('5', '1', '1', '3', '', 'Y', now(), now());
-- insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('5', '1', '1', '4', '', 'N', now(), now());