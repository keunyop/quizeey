-- TEST
insert into test (test_nm, created_date, modified_date) values ('SQLP', now(), now());

-- VERSION
insert into version (test_id, ver_nbr, ver_nm, created_date, modified_date) values ('2', '1', 'v2013', now(), now());

-- Q1
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, is_multi_answer, created_date, modified_date) values ('2', '1', '1', '다음 중 아래 스키마를 보고 평점이 3.0 이상인 학생들의 이름을 보여주는 SQL을 표현한 것으로 가장 적절한 것은?<br>
<br><table border="1"><tr><td><스키마><br>※ 밑줄친 속성은 기본키(Primary Key)이며 ENROLL의 학번은 STUDENT의 학번을 참조하는 외래키(Foreign Key)이고, ENROLL의 강좌번호는 CLASS의 강좌번호를 참조하는 외래키이다.<br>
<br>STUDENT(<u>학번</u>, 학과, 이름)<br>CLASS(<u>강좌번호</u>, 시간, 강좌이름)<br>ENROLL(<u>학번</u>, <u>강좌번호</u>, 학점)</td></tr></table>', 'GROUP BY 절 이후에 조건을 적용하는 경우는 HAVING 절이 사용된 경우이다.
그룹핑된 값에 조건을 적용하는 경우 HAVING 절을 사용한다.JOIN 절에 ALIAS를 사용한 경우, 2개 이상의 테이블에 공통적으로 사용되고 SELECT 절에 사용되는 칼럼에는 ALIAS 접두사를 붙여야 한다.', '', 'false', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('2', '1', '1', '1', 'SELECT 학번,<br>
       MIN(이름)<br>FROM   STUDENT S,<br>       ENROLL  E<br>GROUP  BY E.학번<br>HAVING AVG(E.학점) >= 3.0', 'FALSE', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('2', '1', '1', '2', 'SELECT S.학번,<br>
       MIN(이름)<br>FROM   STUDENT S,<br>       ENROLL  E<br>WHERE  S.학번 = E.학번<br>HAVING AVG(E.학점) >= 3.0', 'FALSE', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('2', '1', '1', '3', 'SELECT S.학번,<br>
       MIN(이름)<br>FROM   STUDENT S,<br>       ENROLL  E<br>WHERE  S.학번 = E.학번<br>GROUP  BY S.학번<br>HAVING AVG(E.학점) >= 3.0', 'TRUE', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('2', '1', '1', '4', 'SELECT 학번,<br>
       MIN(이름)<br>FROM   STUDENT S,<br>       ENROLL  E<br>WHERE  S.학번 = E.학번<br>GROUP  BY S.학번<br>HAVING AVG(E.학점) > 3.0', 'FALSE', now(), now());

-- Q2
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, is_multi_answer, created_date, modified_date) values ('2', '1', '2', '다음 중 아래와 같은 테이블에서 Full Outer Join의 결과로 가장 적절한 것은?<br>
DEPT<br><table border="1"><tr><th>DEPT</th><th>DNAME</th></tr><tr><td>10</td><td>RESEARCH</td></tr><tr><td>30</td><td>SALES</td></tr></table><br>EMP<br>
<table border="1"><tr><th>DEPT</th><th>DNAME</th></tr><tr><td>30</td><td>KING</td></tr><tr><td>40</td><td>WARD</td></tr></table><br><table border="1"><tr><td>SELECT D.DEPTNO, E.DEPTNO<br>
FROM DEPT D FULL OUTER JOIN EMP E<br>ON (D.DEPTNO = E.DEPTNO)</td></tr></table>', 'FULL OUTER JOIN은 DEFT와 EMP 사이에서 조인이 성공한 건과 DEPT, EMP 건 중 조인이 실패한 건을 함께 표시한다.', '', 'false', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('2', '1', '2', '1', '<table border="1"><tr><td>DEPTNO</td><td>DEPTNO</td></tr><tr><td>30</td><td>30</td></tr></table>', 'FALSE', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('2', '1', '2', '2', '<table border="1"><tr><td>DEPTNO</td><td>DEPTNO</td></tr><tr><td>10</td><td></td></tr><tr><td>30</td><td>30</td></tr></table>', 'FALSE', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('2', '1', '2', '3', '<table border="1"><tr><td>DEPTNO</td><td>DEPTNO</td></tr><tr><td>30</td><td>30</td></tr><tr><td></td><td>40</td></tr></table>', 'FALSE', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('2', '1', '2', '4', '<table border="1"><tr><td>DEPTNO</td><td>DEPTNO</td></tr><tr><td>10</td><td></td></tr><tr><td>30</td><td>30</td></tr><tr><td></td><td>40</td></tr></table>', 'TRUE', now(), now());

-- Q3
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, is_multi_answer, created_date, modified_date) values ('2', '1', '3', '아래 테이블은 어느 회사의 사원들과 이들이 부양하는 가족에 대한 것으로 밑줄 친 칼럼은 기본키(Primary Key)를 표시한 것이다. 다음 중 ''현재 부양하는 가족들이 없는 사원들의 이름을 구하라'' 는 질의에 대해 아래 SQL 문장의 ㉠, ㉡ 에 들어 갈 내용으로 가장 적절한 것은?<br><br><table border="1"><tr><td>[테이블]<br>
사원 (사번, 이름, 나이)<br>
가족 (이름, 나이, 부양사번)<br>
※ 가족 테이블의 부양사번은 사원 테이블의 사번을 참조하는 외래키(Foreign Key)이다.<br><br>
[SQL 문장]<br>
SELECT 이름<br>
FROM 사원<br>
WHERE ㉠ (SELECT * FROM 가족 WHERE ㉡ )</td></tr></table>', '''가족들이 없는'' 조건 : NOT EXISTS<br>''현재 부양하는 가족들'' 조건 : 사번 = 부양사번', '', 'false', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('2', '1', '3', '1', '㉠ : EXISTS ㉡ : 사번 = 부양사번', 'FALSE', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('2', '1', '3', '2', '㉠ : EXISTS ㉡ : 사번 <> 부양사번', 'FALSE', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('2', '1', '3', '3', '㉠ : NOT EXISTS ㉡ : 사번 = 부양사번', 'TRUE', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('2', '1', '3', '4', '㉠ : NOT EXISTS ㉡ : 사번 <> 부양사번', 'FALSE', now(), now());

-- Q4
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, is_multi_answer, created_date, modified_date) values ('2', '1', '3', '다음 중 아래 테이블 정의와 인덱스 현황을 참고하여, 인덱스를 효율적(또는 정상적)으로 액세스할 수 없는 검색조건을 2개 고르시오. (단, Oracle의 Index Unique Scan, Index Range Scan 또는 SQL Server의 Index Seek 이외의 액세스 방식은 모두 비효율적이라고 가정한다.)<br>
<table border="1"><tr><td>create table 주문 (<br>
    주문번호    int            not null<br>
  , 주문자명    varchar(20)     null<br>
  , 주문금액    money         null<br>
  , 주문일자    varchar(8)      null<br>
)<br>
<br>
create unique index 주문_pk on 주문 (주문번호)<br>
create index 주문_x01 on 주문 (주문자명)<br>
create index 주문_x02 on 주문 (주문일자 , 주문금액)</td></tr></table>', '2번은 LIKE 검색 문자열 앞뒤에 모두 ''%'' 기호를 붙였으므로 정상적인 Index Range Scan이 불가능하다.<br> 
4번은 내부적 형변환이 발생하므로 Index Range Scan이 불가능하다.', '', 'true', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('2', '1', '4', '1', 'where 주문번호 between 1 and 10', 'FALSE', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('2', '1', '4', '2', 'where 주문자명 like ''홍길동''', 'TRUE', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('2', '1', '4', '3', 'where 주문일자 >= ''20100901''', 'FALSE', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('2', '1', '4', '4', 'where 주문일자 = 20100901', 'TRUE', now(), now());