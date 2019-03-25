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
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, is_multi_answer, created_date, modified_date) values ('2', '1', '3', '다음 중 아래 테이블 정의와 인덱스 현황을 참고하여, 인덱스를 효율적(또는 정상적)으로 액세스할 수 없는 검색조건을 2개 고르시오. (단, Oracle의 Index Unique Scan, Index Range Scan 또는 SQL Server의 Index Seek 이외의 액세스 방식은 모두 비효율적이라고 가정한다.)<br><br>
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

-- Q5
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, is_multi_answer, created_date, modified_date) values ('2', '1', '5', '총 건수가 1,000만 건인 연도별지역별상품매출 테이블에 <출시연도 + 크기>, <색상 + 출시연도> 순으로 구성된 두 개의 B*Tree인덱스가 있었다. 다음 중 이 두 인덱스를 제거하고 아래와 같이 세 개의 비트맵(Bitmap) 인덱스를 생성했을 때, 개별 쿼리의 블록 I/O 측면에서 개선 효과가 가장 미미한 것은?<br><br>
<table border="1"><tr><td>
create bitmap index 연도별지역별상품매출_bx1 on 연도별지역별상품매출(크기);<br>
create bitmap index 연도별지역별상품매출_bx2 on 연도별지역별상품매출(색상);<br>
create bitmap index 연도별지역별상품매출_bx3 on 연도별지역별상품매출(출시연도);<br><br>

■ Distinct Value<br>
   크기 = { NULL, SMALL, MEDIUM, BIG }<br>
   색상 = { NULL, RED, GREEN, BLUE, BLACK, WHITE }<br>
   출시연도 = { NULL, 2001, 2002, 2003, 2004, 2005 2006, 2007, 2008, 2009, 2010 }<br><br>

■ 데이터 분포는 모두 균일
</td></tr></table>', '1번과 3번은 기존에 Full Table Scan으로 처리됐을 것이므로 비트맵 인덱스를 생성하고 나면 블록 I/O가 크게 감소한다.<br>
3번의 경우 만약 ''색상is not null'' 조건을 추가하면 인덱스만 읽고 처리할 수 있지만 그렇더라도 B*Tree 인덱스는 비트맵 인덱스에 비해 블록 I/O는 더 많이 발생한다.<br> 
2번은 Bitmap Conversion이 발생하지 않는 한, 기존에 두 B*Tree 인덱스 중 어느 하나만 사용되고, 나머지 필터 조건을 처리하기 위해 테이블 랜덤 액세스가 불가피하므로 성능이 매우 안 좋았을 것이다.<br> 
반면, 비트맵 인덱스를 생성하고 나면 두 개의 비트맵 인덱스를 동시에 사용할 수 있고, 테이블을 랜덤 액세스도 생략되므로 성능 개선 효과가 클 것이다.<br> 
4번은 색상 = ''BLUE''에 해당하는 건수만큼 대량의 테이블 액세스가 불가피하다.<br> 
비트맵 인덱스를 생성하고 나면 인덱스 스캔 단계에서 다소 블록 I/O가 감소하겠지만 테이블 랜덤 I/O는 줄지 않으므로 성능 개선 효과가 미미하게 나타난다.', '', 'false', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('2', '1', '5', '1', 'select count(*) from 연도별지역별상품매출 where 색상 is null;', 'FALSE', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('2', '1', '5', '2', 'select count(*) from 연도별지역별상품매출<br>
      where (크기 = ''SMALL'' or 크기 is null)<br>
      and   색상 = ''GREEN''<br>
      and    출시연도 = ''2010'';', 'FALSE', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('2', '1', '5', '3', 'select 색상, count(*) from 연도별지역별상품매출 group by 색상;', 'FALSE', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('2', '1', '5', '4', 'select sum(판매량), sum(판매금액)<br>
      from 연도별지역별상품매출<br>
      where  색상 = ''BLUE'';', 'TRUE', now(), now());

-- Q6
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, is_multi_answer, created_date, modified_date) values ('2', '1', '6', '다음 중 Syntax 오류가 있는 SQL문 2개를 고르시오.', 'GROUP BY 절 없이 HAVING을 사용할 수 없다.<br>
USING 조건절을 이용한 EQUI JOIN에서도 NATURAL JOIN과 마찬가지로 JOIN 칼럼에 대해서는 ALIAS나 테이블 이름과 같은 접두사를 붙일 수 없다. <br>
(부서.부서번호 → 부서번호)', '', 'true', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('2', '1', '6', '1', 'SELECT 부서번호<br>   FROM 직원 HAVING COUNT(*) > 3;', 'TRUE', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('2', '1', '6', '2', 'SELECT 직원이름<br>   FROM 직원 JOIN 부서<br>   ON (직원.부서번호 = 부서.부서번호)<br>   WHERE 부서명 = ''인사과''', 'FALSE', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('2', '1', '6', '3', 'SELECT 전화번호<br>   FROM 직원<br>   WHERE 전화번호 = ''777''<br>   GROUP BY 전화번호', 'FALSE', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('2', '1', '6', '4', 'SELECT 직원이름<br>   FROM 직원 JOIN 부서<br>   USING (부서.부서번호)<br>   WHERE 부서명 = ''인사과''', 'TRUE', now(), now());

-- Q7
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, is_multi_answer, created_date, modified_date) values ('2', '1', '7', '다음 중 각 SQL 실행 결과를 가장 올바르게 설명한 것을 2개 고르시오.', '조건절에 해당하는 결과집합이 없다고 에러가 발생하지는 않는다.<br> 
그리고 공집합에 NVL 함수를 사용한다고 값이 얻을 수 있는 것은 아니다.', '', 'true', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('2', '1', '7', '1', 'SELECT COL1, COL2 FROM TAB1 WHERE 1 = 2 ;<br>    → 실행 시 에러가 발생한다.', 'FALSE', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('2', '1', '7', '2', 'SELECT NVL(COL1,''X'') FROM TAB1 WHERE 1 = 2 ;<br>    → 실행 결과로 ''X''를 반환한다.', 'FALSE', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('2', '1', '7', '3', 'SELECT NVL(MIN(COL1), ''X'') FROM TAB1 WHERE 1 = 2;<br>    → 실행 결과로 ''X''를 반환한다.', 'TRUE', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('2', '1', '7', '4', 'SELECT COL1, COL2 FROM TAB1 WHERE 1 = 2 ;<br>    → 실행 결과가 없다.(공집합)', 'TRUE', now(), now());

-- Q8
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, is_multi_answer, created_date, modified_date) values ('2', '1', '8', 'Oracle에서 no_merge 힌트를 사용하지 않고도 아래 SQL문에 뷰 머징(View Merging)이 발생하지 않게 하려고 한다. 다음 중 ㉠ 안에 들어갈 키워드로 가장 적절한 것은?<br><br><table border="1"><tr><td>SELECT *<br>
FROM (SELECT ㉠ , EMP_NAME, HIRE_DATE, SAL, DEPT_NO<br>
      FROM EMP<br>
      WHERE DEPTNO = 30) X<br>
WHERE HIRE_DATE BETWEEN TO_DATE(''20100101'',''YYYYMMDD'') AND TO_DATE(''20101231'',''YYYYMMDD'')</td></tr></table>', '뷰(View) 안에 rownum을 사용하면 뷰 머징(View Merging)을 방지하는 효과가 나타난다.', '', 'false', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('2', '1', '8', '1', 'TO_DATE(SYSDATE,''YYYYMMDD'')', 'FALSE', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('2', '1', '8', '2', 'ROWNUM', 'TRUE', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('2', '1', '8', '3', 'EMPNO', 'FALSE', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('2', '1', '8', '4', 'ROWID', 'FALSE', now(), now());