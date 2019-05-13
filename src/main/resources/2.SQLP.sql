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
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, is_multi_answer, created_date, modified_date) values ('2', '1', '4', '다음 중 아래 테이블 정의와 인덱스 현황을 참고하여, 인덱스를 효율적(또는 정상적)으로 액세스할 수 없는 검색조건을 2개 고르시오. (단, Oracle의 Index Unique Scan, Index Range Scan 또는 SQL Server의 Index Seek 이외의 액세스 방식은 모두 비효율적이라고 가정한다.)<br><br>
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

-- Q9
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, is_multi_answer, created_date, modified_date) values ('2', '1', '9', '다음 중 아래 SQL의 실행 결과로 가장 적절한 것은?<br><br>
<table border="1"><tbody>
<tr>
<th> 고객번호 </th>
<th> 판매일자 </th>
<th> 판매금액 </th>
</tr>
<tr>
<td> 100 </td>
<td> 20090701 </td>
<td> 1000 </td>
</tr>
<tr>
<td> 100 </td>
<td> 20090702 </td>
<td> 300 </td>
</tr>
<tr>
<td> 100 </td>
<td> 20090702 </td>
<td> 1000 </td>
</tr>
<tr>
<td> 200 </td>
<td> 20090701 </td>
<td> 2000 </td>
</tr>
<tr>
<td> 200 </td>
<td> 20090701 </td>
<td> 200 </td>
</tr>
</tbody></table>
<br>
<table border="1"><tr><td>
<pre>
SELECT CUSTCODE 고객번호,
       SALEDATE 판매일자,
       SALE_AMT 판매금액,
       SUM(SALE_AMT) OVER(PARTITION BY CUSTCODE ORDER BY SALEDATE
                          ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AMT1
FROM   SAL_TBL
</pre>
</td></tr></table>
', '윈도우 함수를 이용한 누적 합계(RUNNING SUMMARY)를 구하는 SQL이다.', '', 'false', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('2', '1', '9', '1', '<table border="1"><tbody>
<tr>
<th> 고객번호 </th>
<th> 판매일자 </th>
<th> 판매금액 </th>
<th> AMT1 </th>
</tr>
<tr>
<td> 100 </td>
<td> 20090701 </td>
<td> 300 </td>
<td> 2300 </td>
</tr>
<tr>
<td> 200 </td>
<td> 20090701 </td>
<td> 200 </td>
<td> 2200 </td>
</tr>
</tbody></table>', 'FALSE', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('2', '1', '9', '2', '<table border="1"><tbody>
<tr>
<th> 고객번호 </th>
<th> 판매일자 </th>
<th> 판매금액 </th>
<th> AMT1 </th>
</tr>
<tr>
<td> 100 </td>
<td> 20090702 </td>
<td> 1000 </td>
<td> 2300 </td>
</tr>
<tr>
<td> 200 </td>
<td> 20090701 </td>
<td> 2000 </td>
<td> 2200 </td>
</tr>
</tbody></table>', 'FALSE', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('2', '1', '9', '3', '<table border="1"><tbody>
<tr>
<th> 고객번호 </th>
<th> 판매일자 </th>
<th> 판매금액 </th>
<th> AMT1 </th>
</tr>
<tr>
<td> 100 </td>
<td> 20090701 </td>
<td> 1000 </td>
<td> 1000 </td>
</tr>
<tr>
<td> 100 </td>
<td> 20090702 </td>
<td> 300 </td>
<td> 1300 </td>
</tr>
<tr>
<td> 100 </td>
<td> 20090702 </td>
<td> 1000 </td>
<td> 2300 </td>
</tr>
<tr>
<td> 200 </td>
<td> 20090701 </td>
<td> 2000 </td>
<td> 2000 </td>
</tr>
<tr>
<td> 200 </td>
<td> 20090701 </td>
<td> 200 </td>
<td> 2200 </td>
</tr>
</tbody></table>', 'TRUE', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('2', '1', '9', '4', '<table border="1"><tbody>
<tr>
<th> 고객번호 </th>
<th> 판매일자 </th>
<th> 판매금액 </th>
<th> AMT1 </th>
</tr>
<tr>
<td> 100 </td>
<td> 20090701 </td>
<td> 1000 </td>
<td> 1000 </td>
</tr>
<tr>
<td> 100 </td>
<td> 20090702 </td>
<td> 300 </td>
<td> 2300 </td>
</tr>
<tr>
<td> 100 </td>
<td> 20090702 </td>
<td> 1000 </td>
<td> 2300 </td>
</tr>
<tr>
<td> 200 </td>
<td> 20090701 </td>
<td> 2000 </td>
<td> 2200 </td>
</tr>
<tr>
<td> 200 </td>
<td> 20090701 </td>
<td> 200 </td>
<td> 2200 </td>
</tr>
</tbody></table>', 'FALSE', now(), now());

-- Q10
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, is_multi_answer, created_date, modified_date) values ('2', '1', '10', '다음 중 아래 SQL에 대한 설명으로 가장 부적절한 것은?<br><br>
<table border="1"><tr><td>
<pre>
SELECT SUM(NVL(A.C2, 0))
FROM   TAB1 A, TAB2 B
WHERE  A.C1 = :V1
</pre>
</td></tr></table>', 'GROUP BY절이 없기 때문에 결과건수는 항상 1건이다. <br>
해당 SQL문에서는 조인 조건의 부재로 결과 건수가 아니라 답 자체가 틀려질 수 있다. <br>
즉, Cartesian Product으로 인해 합계가 틀려질 수 있다.', '', 'false', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('2', '1', '10', '1', '조인 조건이 없어서 결과 건수가 여러 건이 된다.', 'TRUE', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('2', '1', '10', '2', '조인 조건이 없다고 문법 오류가 발생하지는 않는다.', 'FALSE', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('2', '1', '10', '3', 'SUM(NVL(A.C2, 0))의 처리에 비효율이 존재한다.', 'FALSE', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('2', '1', '10', '4', '조인 조건이 없어서 CARTESIAN PRODUCT이 발생한다.', 'FALSE', now(), now());

-- Q12
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, is_multi_answer, created_date, modified_date) values ('2', '1', '12', '전체 사원이 1,000명인 회사에서 아래 쿼리를 수행하려고 한다. 다음 중 옵티마이저가 예상하는 건수로 가장 적절한 것은?<br><br>
<table border="1"><tr><td>
<pre>
select * from 사원 where 직급 = ''부장'' and 부서 = ''영업'';

* 직급은 { 부장, 과장, 대리, 사원 }의 집합이다.
* 부서는 { 인사, 총무, 회계, 마케팅, 영업 }의 집합이다.
* 두 칼럼 모두 히스토그램 정보가 수집되어 있지 않다.
</pre>
</td></tr></table>', '(직급의 Selectivity) × (부서의 Selectivity) × (전체 로우 수) = 1/4 × 1/5 × 1,000 = 50', '', 'false', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('2', '1', '12', '1', '48', 'FALSE', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('2', '1', '12', '2', '50', 'TRUE', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('2', '1', '12', '3', '55', 'FALSE', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('2', '1', '12', '4', '60', 'FALSE', now(), now());

-- Q13
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, is_multi_answer, created_date, modified_date) values ('2', '1', '13', '다음 중 아래 t_idx 인덱스가 해당하는 것으로 가장 적절한 것은?<br><br>
<table border="1"><tr><td>
<pre>
create table t ( a number, b char(3), c varchar2(10) )
partition by range(a) (
partition p1 values less than(100)
, partition p2 values less than(200)
, partition p3 values less than(maxvalue)
);

create index t_idx on t( b ) local ;
</pre>
</td></tr></table>', 'Local 인덱스이므로 t_idx의 파티션 키는 테이블과 똑같이 a 칼럼이다.<br>
그리고 파티션 키가 인덱스 선두 칼럼이 아니므로 NonPrefixed에 해당한다.', '', 'false', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('2', '1', '13', '1', 'Global Prefixed Partition Index', 'FALSE', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('2', '1', '13', '2', 'Global NonPrefixed Partition Index', 'FALSE', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('2', '1', '13', '3', 'Local Prefixed Partition Index', 'FALSE', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('2', '1', '13', '4', 'Local NonPrefixed Partition Index', 'TRUE', now(), now());

-- Q14
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, is_multi_answer, created_date, modified_date) values ('2', '1', '14', '다음 중 아래 데이터 현황을 참고하여 결과가 다르게 나오는 쿼리인 것은?<br><br>
<table border="1"><tr><td>
<pre>
select  EmployeeID, LastName, HireDate, Country
from    Employees
order by HireDate

EmployeeID   LastName       HireDate                  Country
-----------  ------------   -----------------------   --------
          3  Leverling      1992-04-01 00:00:00.000   USA
          1  Davolio        1992-05-01 00:00:00.000   USA
          2  Fuller         1992-08-14 00:00:00.000   USA
          4  Peacock        1993-05-03 00:00:00.000   USA
          5  Buchanan       1993-10-17 00:00:00.000   UK
          6  Suyama         1993-10-17 00:00:00.000   UK
          7  King           1994-01-02 00:00:00.000   UK
          8  Callahan       1994-03-05 00:00:00.000   USA
          9  Dodsworth      1994-11-15 00:00:00.000   UK
</pre>
</td></tr></table>', '<pre>1, 4번은 5번째와 6번째 레코드가 rnum으로 똑같이 5를 부여받기 때문에 HireDate 순으로 6개 레코드가 선택된다. 
참고로, 7번째 레코드는 각각 7과 6을 부여받는다 
3번은 서브쿼리에서 5개 레코드가 선택되지만, 메인쿼리와 조인하고 나면 최종적으로 6개 레코드가 선택된다.
2번은 HireDate 순으로 5개 레코드가 선택된다</pre>', '', 'false', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('2', '1', '14', '1', '<pre>select  EmployeeID, LastName, HireDate, Country
    from   (select  EmployeeID, LastName, HireDate, Country
                  , rank () over (order by HireDate) as rnum
            from    Employees
           ) a
    where   a.rnum &lt;= 5
    order by EmployeeID</pre>', 'FALSE', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('2', '1', '14', '2', '<pre>select  EmployeeID, LastName, HireDate, Country
    from   (select  EmployeeID, LastName, HireDate, Country
                  , row_number() over (order by HireDate) as rnum
            from    Employees
           ) a
    where   a.rnum &lt;= 5
    order by EmployeeID</pre>', 'TRUE', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('2', '1', '14', '3', '<pre>select  EmployeeID, LastName, HireDate, Country
    from    Employees a
    where   HireDate in (select top 5 HireDate
                         from   Employees
                         order by HireDate )
    order by EmployeeID</pre>', 'FALSE', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('2', '1', '14', '4', '<pre>select  EmployeeID, LastName, HireDate, Country
   from   (select  EmployeeID, LastName, HireDate, Country
                 , dense_rank() over (order by HireDate) as rnum
           from    Employees
          ) a
   where   a.rnum &lt;= 5
   order by EmployeeID</pre>', 'FALSE', now(), now());


-- Q16
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, is_multi_answer, created_date, modified_date) values ('2', '1', '16', '다음 중 아래 두 SQL에 대한 설명으로 가장 적절한 것은? (단, 국가는 100건, 수출실적은 100만 건. 국가 테이블 PK는 국가코드이다.)<br><br>
<table border="1"><tr><td>
<pre>
가. SELECT DISTINCT 국가명
    FROM 국가 x, 수출실적 y
    WHERE x.국가코드= y.국가코드
    AND y.수출년월 BETWEEN ''200001'' AND ''201012'';

나. SELECT 국가명
    FROM 국가 x
    WHERE EXISTS (SELECT 1
                  FROM  수출실적 y
                  WHERE y.국가코드= x.국가코드
                  AND y.수출년월 BETWEEN  ''200001'' AND ''201012'');
</pre>
</td></tr></table>', '두 SQL의 결과는 동일하며, OLTP 환경이냐 DW 환경이냐를 불문하고 두 번째 SQL이 더 효율적이다.', '', 'false', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('2', '1', '16', '1', '''가'' SQL은 부분범위 처리가 가능하다.', 'FALSE', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('2', '1', '16', '2', '''나'' SQL이 더 효율적이다.', 'TRUE', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('2', '1', '16', '3', 'OLTP 환경이냐, DW 환경이냐에 따라 두 SQL의 효율성이 다르다.', 'FALSE', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('2', '1', '16', '4', '두 SQL의 결과가 다르므로 효율성을 판단하는 것은 의미가 없다.', 'FALSE', now(), now());


-- Q18
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, is_multi_answer, created_date, modified_date) values ('2', '1', '18', '다음 중 테이블 tab1에 아래와 같은 데이터가 존재할 경우에 대한 설명으로 가장 적절한 것은? (각 칼럼의 타입은 number이다.)<br><br>
<table border="1"><tr><td>
<pre>
col1     col2     col3
=======================
  10       20     NULL
  15     NULL     NULL
  50       70       20
</pre>
</td></tr></table>', '칼럼끼리 연산할 때 null을 포함하면 결과는 null이다. 
레코드끼리 연산할 때 null을 포함하면 결과가 null이 아니며, 이유는 null을 연산에서 제외하기 때문이다.', '', 'false', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('2', '1', '18', '1', 'select sum(col2) from tab1 의 결과는 NULL이다.', 'FALSE', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('2', '1', '18', '2', 'select sum(col1 + col2 + col3) from tab1 의 결과는 185 이다.', 'FALSE', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('2', '1', '18', '3', 'select sum(col2 + col3) from tab1 의 결과는 90 이다.', 'TRUE', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('2', '1', '18', '4', 'select sum(col2) + sum(col3) from tab1 의 결과는 90 이다.', 'FALSE', now(), now());


-- Q19
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, is_multi_answer, created_date, modified_date) values ('2', '1', '19', '다음 중 NL(Nested Loops) Join의 특징을 설명한 것으로 가장 부적절한 것은?', '선행(Driving) 집합은 주어진 조건절에 따라 Full Table Scan이 유리할 수도 있다.', '', 'false', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('2', '1', '19', '1', '조인을 한 로우씩 차례대로 진행하므로 부분범위 처리에 자주 사용된다.', 'FALSE', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('2', '1', '19', '2', '먼저 액세스한 테이블의 처리 범위에 따라 전체 일량이 결정된다.', 'FALSE', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('2', '1', '19', '3', 'Inner쪽 조인 칼럼에 대한 인덱스 전략이 중요하지만, 조인 칼럼이 모두 포함되지 않은 인덱스라도 사용 가능하다.', 'FALSE', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('2', '1', '19', '4', '선행(Driving) 집합도 반드시 인덱스를 통해 액세스해야 효율적이다.', 'TRUE', now(), now());

-- Q20
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, is_multi_answer, created_date, modified_date) values ('2', '1', '20', '다음 중 Oracle에서 인덱스를 스캔하는 방식 중 하나인 Index Full Scan의 특징으로 가장 부적절한 것은?', '필요한 칼럼이 모두 인덱스에 포함돼 있을 때만 사용 가능한 것은 Index Fast Full Scan의 특징이다.', '', 'false', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('2', '1', '20', '1', '인덱스 구조를 따라 스캔하므로 결과집합의 순서가 보장된다(=일정하다).', 'FALSE', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('2', '1', '20', '2', 'Single Block Read 방식을 사용한다.', 'FALSE', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('2', '1', '20', '3', '파티션 돼 있지 않다면 병렬 스캔이 불가능하다.', 'FALSE', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('2', '1', '20', '4', '필요한 칼럼이 모두 인덱스에 포함돼 있을 때만 사용 가능하다.', 'TRUE', now(), now());

-- Q21
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, is_multi_answer, created_date, modified_date) values ('2', '1', '21', 'Oracle에서 TAB1, TAB2 순으로 NL 조인하도록 유도하고 싶다. 다음 중 ㉠ 안에 넣을 바른 힌트 사용법을 2개고르시오.<br><br>
<pre>
SELECT --+ (         ㉠         ) -- ...
FROM TAB1 A, TAB2 B
WHERE A.KEY = B.KEY
</pre>', '테이블 Alias가 있은 상황에선 반드시 Alias를 사용해야 한다.', '', 'true', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('2', '1', '21', '1', 'ORDERED USE_NL(B)', 'TRUE', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('2', '1', '21', '2', 'ORDERED USE_NL(TAB2)', 'FALSE', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('2', '1', '21', '3', 'LEADING(A) USE_NL(B)', 'TRUE', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('2', '1', '21', '4', 'DRIVING_SITE(A) USE_NL(B)', 'FALSE', now(), now());

-- Q22
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, is_multi_answer, created_date, modified_date) values ('2', '1', '22', '다음 중 아래 SQL문과 실행계획을 보고, 두 테이블의 조인 순서와 inner 테이블에 대한 조인 회수로 가장 적절한 것은?<br><br>
<pre>
select  *
from    t_small a, t_big b
where   a.id = b.id
and     a.colid = b.colid
and     a.number = b.number
and     b.name = ''password''
and     a.length &lt;= 10
order by a.length DESC

Rows   Executes   StmtText
----- ----------- ---------------------------------------------------------------
     0              1      select  *
     0              1        |--Sort(ORDER BY:([a].[length] DESC))
     0              1             |--Filter(WHERE:([t_small].[length] as [a].[length]&lt;=(10
    30              1                 |--Nested Loops(Inner Join, OUTER REFERENCES:([Bmk1
    30              1                  |--Nested Loops(Inner Join, OUTER REFERENCES:(
    30              1                    |   |--Table Scan(OBJECT:([t_big] AS [b]),
    30             30                    |   |--Index Seek(OBJECT:([t_small].[t_small_
    30             30                    |--RID Lookup(OBJECT:([t_small] AS [a]), SEEK:

(8개 행 적용됨)
</pre>', '실행계획 상 위 쪽에서 아래 쪽으로 조인이 진행된다.<br>
NL 조인의 경우 위쪽에 있는 Outer 집합에서 출력된 결과 건수(Rows)만큼 Inner 집합으로 조인 시도가 일어난다.', '', 'false', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('2', '1', '22', '1', '조인 순서 : t_small → t_big, inner 테이블 조인 횟수 : 30', 'FALSE', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('2', '1', '22', '2', '조인 순서 : t_big → t_small, inner 테이블 조인 횟수 : 60', 'FALSE', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('2', '1', '22', '3', '조인 순서 : t_small → t_big, inner 테이블 조인 횟수 : 1', 'FALSE', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('2', '1', '22', '4', '조인 순서 : t_big → t_small, inner 테이블 조인 횟수 : 30', 'TRUE', now(), now());

-- Q23
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, is_multi_answer, created_date, modified_date) values ('2', '1', '23', '다음 중 아래 SQL과 트레이스 결과를 분석하고, 보기에서 제시한 튜닝 방안 중 가장 적절한 것은?<br><br>
<pre>
SQL&gt; SELECT ...
  2  FROM  (SELECT DEII_DT, NEII_VAL, NACT_VAL, NSTD_VAL
  3              , NVL(ROUND(AVG(NACT_VAL/NSTD_VAL*100) OVER(), 2), 0.00) AVG_VAL
  4              , NVL(ROUND(STDDEV(NACT_VAL/NSTD_VAL*100) OVER(), 2), 0.00) STDDEV_VAL
  5              , ROWNUM RN
  6         FROM   EII_SUMMARY
  7         WHERE  TO_CHAR(DEII_DT, ''YYYYMMDDHH24MISS'') BETWEEN :B3 AND :B4
  8         ORDER BY DEII_DT) MR
  9         LEFT OUTER JOIN EII_TARGET ET
 10         ON   ET.DEII_DT BETWEEN TRUNC(MR.DEII_DT, ''MM'')
 11                             AND TRUNC(LAST_DAY(MR.DEII_DT)+1)-1/60/24/24
 12         AND  ET.NCODE_NO IN ( :B1, :B2 )
 13  GROUP BY FLOOR((MR.RN-1)/:B5 ), MR.AVG_VAL, MR.STDDEV_VAL
 14  ORDER BY FLOOR((MR.RN-1)/:B5 ) ;

call      count      cpu   elapsed    disk    query   current     rows
-------  ------  -------  --------  ------  -------  --------  -------
Parse       446     0.00      0.00       0        0         0        0
Execute    7578     0.03      0.12      22      564         2        8
Fetch     13522   128.03    129.16      22  6676902         0    10442
-------  ------  -------  --------  ------  -------  --------  -------
total     21546   128.06    129.30      44  6677466         2    10450

Rows   Row Source Operation
----  ---------------------------------------------------
   2   SORT GROUP BY (cr=7340 pr=7 pw=0 time=221191 us)
 240    NESTED LOOPS OUTER (cr=7340 pr=7 pw=0 time=221460 us)
 120     VIEW  (cr=20 pr=7 pw=0 time=90776 us)
 120      FILTER  (cr=20 pr=7 pw=0 time=90410 us)
 120       WINDOW SORT (cr=20 pr=7 pw=0 time=89447 us)
 120        COUNT  (cr=20 pr=7 pw=0 time=79490 us)
 120         TABLE ACCESS (FULL) OF ''EII_SUMMARY'' (TABLE) (cr=20 pr=7 pw=0 time=79250 us)
 240     VIEW  (cr=7320 pr=0 pw=0 time=74760 us)
 240      TABLE ACCESS FULL EII_TARGET (cr=7320 pr=0 pw=0 time=74414 us)


[인덱스 구성]
EII_SUMMARY_X01 : DEII_DT
EII_TARGET_X01 : DEII_DT
</pre>', '7번 라인에 대한 Row Source를 보면, 20개 블록을 읽어서 120개 로우를 반환하므로 굳이 인덱스를 사용하도록 튜닝하지 않아도 된다.<br/>
9번 라인에 대한 Row Source만 보고 Left Outer Join이 불필요하다고 판단할 수 없다. <br/>
10~11번 라인 조인 칼럼에 인덱스가 있는데도 옵티마이저가 이를 사용하지 않고 Full Table Scan으로 처리한 이유는, <br/>
NCODE_NO 필터링을 위해 다량의 테이블 랜덤 액세스가 발생하기 때문이다. <br/>
인덱스 뒤에 NCODE_NO만 추가해도 성능이 많이 개선되겠지만, <br/>
순서까지 바꿔 <span class="error">&#91;NCODE_NO + DEII_DT&#93; 순으로 구성하는 것이 최적이다. <br/>
14번 라인의 ORDER BY를 제거하면 결과집합의 출력순서가 달라질 수 있다.', '', 'false', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('2', '1', '23', '1', '7번 라인을 아래와 같이 수정한다.<br><pre>WHERE DEII_DT BETWEEN TO_DATE(:B3, ''YYYYMMDDHH24MISS'')
                  AND     TO_DATE(:B4, ''YYYYMMDDHH24MISS'')</pre>', 'FALSE', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('2', '1', '23', '2', '9번 라인의 ''LEFT OUTER JOIN''을 ''INNER JOIN''으로 변경함으로써<br>
   EII_TARGET 테이블이 먼저 드라이빙 될 수 있게 한다.<br>
   Row Source를 분석해 보면, Outer 집합에서 Inner 집합으로 조인 시도한<br>
   건수만큼 모두 성공하므로 Outer Join은 불필요하다.', 'FALSE', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('2', '1', '23', '3', '10~12번 라인을 위해 EII_TARGET_X01 인덱스를 [NCODE_NO + DEII_DT] 순으로 구성한다.', 'TRUE', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('2', '1', '23', '4', '14번 라인의 ORDER BY는 불필요하므로 제거한다.', 'FALSE', now(), now());

-- Q24
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, is_multi_answer, created_date, modified_date) values ('2', '1', '24', '일별고객별판매집계 테이블의 PK는 &lt;판매일시 + 고객번호&gt; 순으로 구성되었다. 이 테이블에 DML을 수행하는 다른 트랜잭션이 없는 상황에서 Oracle은 아래 ''가'', ''나'', ''다'' 문장을 어떤 순서로 수행하느냐에 따라 마지막 ''라'' 문장의 블록 I/O 횟수가 달라진다. 제시된 4가지 수행 순서 보기 중 마지막 ''라'' 문장을 수행했을 때 블록 I/O가 가장 적게 발생하는 것을 고르시오. (''라'' 문장은 PK 인덱스를 이용한다는 사실을 상기하기 바란다.)<br><br><pre>
가) 3일 이전에 발생한 판매 데이터를 삭제한다.
    delete from 일별고객별판매집계 where 판매일시 &lt; trunc(sysdate) - 2;

나) 고객별로 집계한 금일 판매 데이터를 추가한다.
    insert into 일별고객별판매집계
    select to_char(sysdate, ''yyyymmdd''), 고객번호, sum(판매량), sum(판매금액)
    from   판매
    where  판매일시 between trunc(sysdate) and trunc(sysdate+1)-1/24/60/60
    group by 고객번호;

다) commit;

라) select count(*) from 일별고객별판매집계;
</pre>', '''가''를 수행하고''다''를 수행하기 전에 commit을 수행하면, ''가''에서 삭제된 빈 공간을 ''다''에서 재사용하므로 Index Skew 현상을 방지할 수 있다.', '', 'false', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('2', '1', '24', '1', '가 &#45;&gt; 나 &#45;&gt; 다 &#45;&gt; 라', 'FALSE', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('2', '1', '24', '2', '가 &#45;&gt; 다 &#45;&gt; 나 &#45;&gt; 다 &#45;&gt; 라', 'TRUE', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('2', '1', '24', '3', '나 &#45;&gt; 가 &#45;&gt; 다 &#45;&gt; 라', 'FALSE', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('2', '1', '24', '4', '나 &#45;&gt; 다 &#45;&gt; 가 &#45;&gt; 다 &#45;&gt; 라', 'FALSE', now(), now());

-- Template
-- Q20
-- insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, is_multi_answer, created_date, modified_date) values ('2', '1', '19', '', '', '', 'false', now(), now());
-- insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('2', '1', '19', '1', '', 'FALSE', now(), now());
-- insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('2', '1', '19', '2', '', 'FALSE', now(), now());
-- insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('2', '1', '19', '3', '', 'TRUE', now(), now());
-- insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('2', '1', '19', '4', '', 'FALSE', now(), now());