-- 다른 사람과함께 정형데이터 를 관리할 때 (CRUD) SQL을사용한다.
== 스키마에는 테이블과 테이블을 효과적으로 사용하기 위한 객체들

use student_mgmt

select sale_amt FROM student_mgmt.box_office;

select movie_type, SUM(sale_amt) from student_mgmt.box_office GROUP BY movie_type;


select years,count(*) from student_mgmt.box_office GROUP BY years;

SELECT release_date, count(movie_name) from student_mgmt.box_office GROUP BY release_date  --date 으로 그룹을 나누면 일자별로 나눈다. 
-- 연도 별로 나누기 위해서는 

SELECT YEAR(release_date), count(movie_name) from student_mgmt.box_office GROUP BY YEAR(release_date) ORDER BY YEAR(release_date) LIMIT 10;

 --이러철 YEAR함수를 통과시킨다.

SELECT movie_type,sum(sale_amt),MAX(sale_amt) as '최대매출액', MIN(sale_amt) '최소매출액' from student_mgmt.box_office WHERE YEAR(release_date) =2019 and movie_type IS Not NULL GROUP BY movie_type HAVING MAX(sale_amt)>2000000 ORDER BY movie_type, SUM(sale_amt) DESC ; --영화타입중 에서 NULL이 아니고 개봉연도가 2019년인 영화의 매출액 최고 매출액, 최소매출액 
--having 은 group by로 묶어 놓은 것을 가지고 다시 조건을 가지게 한다.

SELECT movie_type,sum(sale_amt),MAX(sale_amt) as '최대매출액', MIN(sale_amt) '최소매출액' from student_mgmt.box_office WHERE YEAR(release_date) =2019 and movie_type IS Not NULL GROUP BY movie_type   WITH ROLLUP ;
-- 명시한 컬럼별로 GROUP BY한 결과를 전체 집계해주는 명령어

--SQL함수

SELECT CHAR_LENGTH('SQL'), LENGTH('SQL'), CHAR_LENGTH('홍길동🤣'), LENGTH('홍길동🤣'); -- 3,3,4,13 으로 결과가 나온다 한글은 1개당 3바이트 이모지는 1바이트. 
# SQL에서 한글 1글자 : 3바이트 LENGTH로 확인 


SELECT CONCAT('This', 'Is', 'MySQL', '.') AS CONCAT1, 
       CONCAT('SQL', NULL, 'Books') AS CONCAT2, # NULL과 문자열을 연결하면 그 결과는 NULL
       CONCAT_WS('/', 'This', 'Is', 'MySQL') AS CONCAT_WS; 
		# CONCAT_WS() 함수는 구분자인 첫 번째 매개변수가 콤마(,)이므로 두 번째부터 네 번째 매개변수를 연결하면서 그 사이에 구분자 콤마 기입

-- SQL은 언어가 거의 유사합니다. 회사마다 사용하는 서버의 종류도 다양합니다. 
-- 문법이나 함수명이 여러 서버에서 혼용할 수 있도록 


SELECT FORMAT(123456789.123456, 3) fmt, -- FORMAT(숫자를 3개씩 끊어서 ,로 출력, 소수점이후 N번째 자리까지 반올림 출력)
       INSTR('ThisIsSQL', 'sql') instring, -- index string, MySQL은 1부터 시작, 윈도우서버 SQL은 대소문자 구분 없음 
       LOCATE('my', 'TheMyDBMSMySQL') locates, -- 'TheMyDBMSMySQL'에서 'my'를 찾아줘 5번째인덱스 이후에서 
       POSITION('my' IN 'TheMyDBMSMySQL') pos; -- LOCATE('my', 'TheMyDBMSMySQL', 1) 과 같은 동작
       

SELECT LOWER('ABcD'), LCASE('ABcD'),
       UPPER('abcD'), UCASE('abcD');
       
SELECT REPEAT('SQL', 3),
       REPLACE('생일 축하해 철수야', '철수', '영희') REP,
       REVERSE('SQL');

# SUBSTR() 함수는 첫 번째 매개변수 str의 문자열에서 두 번째 매개변수 pos로 지정된 위치부터 세 번째 매개변수 len만큼 잘라 반환합니다.
-- len은 생략 가능하며, 생략하면 str의 오른쪽 끝까지 잘라냅니다. 또한 pos 값에 음수도 넣을 수 있는데, 이때는 시작 위치를 왼쪽이 아닌 오른쪽 끝을 기준으로 잡습니다. 
-- 그리고 SUBSTRING(), MID() 함수는 SUBSTR() 함수와 사용법이 같습니다.
SELECT SUBSTR('This Is MySQL', 6, 2) FIRST,
        SUBSTR('This Is MySQL', 6),
       SUBSTRING('This Is MySQL', 6, 2) SECOND,
       MID('This Is MySQL', -5) THIRD; -- 음수인덱싱

SELECT CURDATE(), CURRENT_DATE(), CURRENT_DATE,
       CURTIME(), CURRENT_TIME(), CURRENT_TIME,
       NOW(), CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP;
       --now이는 이 줄이 실행되는 상태의 시간

       
SELECT DATE_FORMAT('2024-07-22 13:42:54', '%d-%b-%Y') Fmt1,
       DATE_FORMAT('2024-07-22 13:42:54', '%U %W %j') Fmt2;

SELECT STR_TO_DATE('21,07,2024', '%d,%m,%Y') CONV1,
       STR_TO_DATE('19:30:17', '%H:%i:%s') CONV2,
       STR_TO_DATE('09:30:17', '%h:%i:%s') CONV3,
       STR_TO_DATE('17:30:17', '%h:%i:%s') CONV4;  
       -- ‘19:30:17’에서 시간이 19시로 24시간 형태인데, %h는 12시간 형태이므로 변환에 실패해 결국 NULL을 반환

SELECT SYSDATE(), SLEEP(2), SYSDATE(); -- 매번 함수 호출시의 시간

SELECT NOW(), SLEEP(2), NOW(); -- 문장 단위로 실행됨

SELECT DATE_ADD('2024-07-22', INTERVAL 5 DAY) DATEADD,
	   ADDDATE('2024-07-22', INTERVAL 5 MONTH) ADD_DATE1,
       ADDDATE('2024-07-22', 5 ) ADD_DATE2,
       ADDDATE('2024-07-22', INTERVAL '1 1' YEAR_MONTH) ADD_DATE3;
       -- INTERVAL 을통해 5일 5달 더하기

SELECT DATE_SUB('2024-07-22', INTERVAL 5 DAY) DATEADD,
	   SUBDATE('2024-07-22', INTERVAL 5 MONTH) ADD_DATE1,
       SUBDATE('2024-07-22', 5 ) ADD_DATE2,
       SUBDATE('2024-07-22', INTERVAL '1 1' YEAR_MONTH) ADD_DATE3;
       -- INTERVAL 을통해 5일 5달 빼기


-- EXTRACT() -- 매개변수의 date에서 특정 날짜 단위를 추출한 결과 반환
SELECT EXTRACT(YEAR_MONTH    FROM '2024-07-22 13:32:03') YEARMON,
       EXTRACT(DAY_HOUR      FROM '2024-07-22 13:32:03') DAYHOUR,
       EXTRACT(MINUTE_SECOND FROM '2024-07-22 13:32:03') MINSEC;


-- int('10') type casting 형변환
SELECT CAST(10 AS CHAR)                 CONV_CHAR, ---10을 CHAR으로 형변환
       CAST('-10' AS SIGNED)           CONV_INT, -- 양수, 음수 다 받는 자료형 
       CAST('10.2131' AS DECIMAL)       CONV_DEC1, --고정소수점
       CAST('10.2131' AS DECIMAL(6, 2)) CONV_DEC2, -- 고정소수점(최대자리, 소수점이하 N자리)
       CAST('10.2131' AS DOUBLE)        CONV_DOUBLE, -- 부동소수점 -> 앞으로는 뺄거래요 
       CAST('2021-10-31' AS DATE)       CONV_DATE,
       CAST('2021-10-31' AS DATETIME)   CONV_DATETIME;

/*  CONVERT() 함수도 CAST() 함수와 마찬가지로 형 변환하나,
 CAST() 함수와 달리 AS type 대신 type을 두 번째 매개변수로 받음 */
SELECT CONVERT(10, CHAR)                 CONV_CHAR,
       CONVERT('-10', SIGNED)            CONV_INT,
       CONVERT('10.2131', DECIMAL)       CONV_DEC1,
       CONVERT('10.2131', DECIMAL(6, 4)) CONV_DEC2,
       CONVERT('10.2131', DOUBLE)        CONV_DOUBLE,
       CONVERT('2021-10-31', DATE)       CONV_DATE,
       CONVERT('2021-10-31', DATETIME)   CONV_DATETIME;
       
 
 -- 흐름제어 함수
# 흐름 제어(flow control) 함수란 특정 조건을 확인해 조건에 부합하는 경우와 그렇지 않은 경우에 다른 값을 반환하는 함수
# 흐름 제어 함수에는 IF(), IFNULL(), NULLIF() 함수가 있고, 흐름 제어 함수와 비슷한 역할을 하는 CASE 연산자도 있다
SELECT IF(2 < 1, 1, 0) IF1,  -- IF(조건, 참일때 리턴값, 거짓일 때 리턴값)
       IF('A' = 'a', 'SAME', 'NOT SAME') IF2, -- window의 MYSQL에서는 대소문자 구분 X 
       IF(1 = 2, 1, 'A') IF3;

-- NULLIF() 함수는 두 매개변수 expr1과 expr2 값이 같으면 NULL을, 같지 않으면 expr1을 반환
SELECT NULLIF(1, 1) NULLIF1,
       NULLIF(1, 0) NULLIF2,
       NULLIF(NULL, NULL) NULLIF3;

SELECT CASE 1 WHEN 0 THEN 'A' -- CASE 값 WHEN 첫번째 명제 THEN 첫번째 명제가 참일 경우 출력할 값
              WHEN 1 THEN 'B' --         WHEN 두번째 명제 THEN 두번째 명제가 참일 경우 출력할 값
       END CASE1,             --         ELSE 앞의 모든 명제가 거짓인 경우 출력할 값 
							  -- END 해당 조건을 부르기 위한 ALIAS
       CASE 9 WHEN 0 THEN 'A'
              WHEN 1 THEN 'B'
              ELSE 'None'
       END CASE2,
       CASE WHEN 25 BETWEEN 1 AND 19 THEN '10대' -- 범위 지정도 가능합니다
            WHEN 25 BETWEEN 20 AND 29 THEN '20대'
            WHEN 25 BETWEEN 30 AND 39 THEN '30대'
            ELSE '30대 이상'
       END CASE3;
       
-- DATABASE()와 SCHEMA() 함수는 현재 접속해 있는 데이터베이스 이름을, USER() 함수는 현재 로그인한 사용자 이름을 반환   
use student_mgmt;    
SELECT DATABASE(), SCHEMA(), USER(); -- MYSQL에서는 DATABASE(), SCHEMA()가 동일합니다 

-- 실습.
-- # 1. box_office 테이블에서 2015년 이후 개봉한 영화 중 연도별로 2번 이상 
-- # 관객수 100만을 넘긴 영화의 감독과 해당 관객의 영화를 본 관객수를 
-- # 연도별, 감독별로 구하는 쿼리를 작성하세요.

select YEAR(release_date), SUM(audience_num), director FROM student_mgmt.box_office 
WHERE YEAR(release_date) >= 2015 and audience_num >= 1000000 GROUP BY YEAR(release_date),director 
HAVING count(director) ORDER BY 2 desc LIMIT 10;

-- # 2. 2019년 1분기(QUARTER 함수 사용) 개봉 영화 중 
-- # 매출액이 천만 원 이상인 영화의 
-- # 월별, 영화 유형별 매출액 소계를 구하는 쿼리
SELECT MONTH(release_date),sum(sale_amt), movie_type FROM student_mgmt.box_office
WHERE QUARTER(release_date) = 1 and YEAR(release_date)= 2019 GROUP BY MONTH(release_date),movie_type 
WITH ROLLUP ORDER BY 2 DESC;

SELECT QUARTER(release_date) from student_mgmt.box_office WHERE QUARTER(release_date)=1;


/* 3. 2019년 개봉 영화 중 매출액이 천만 원 이상인 영화의 월별(MONTH), 영화 유형별 매출액 소계를 구하되
	7월 1일 전에 개봉한 영화이면 상반기,
	7월 1일 이후에 개봉한 영화이면 하반기라고 함께 출력하는 쿼리 */
SELECT MONTH(release_date) 월별, movie_type 영화유형, SUM(sale_amt) 총계, IF(MONTH(release_date) > 6, '하반기', '상반기')
FROM box_office
WHERE YEAR(release_date) = 2019 
 AND sale_amt >= 10000000
GROUP BY MONTH(release_date), movie_type, IF(MONTH(release_date) > 6, '하반기', '상반기')
ORDER BY 1; 
;--WITH ROLLUP ORDER BY 2 DESC;

-- 4. 부제가 있는 영화 찾기 ':' 2015년 이후의 개봉영화 중에서 부제가 달려있는 영화의 개수 세어보기 
SELECT YEAR(release_date), COUNT(*)
FROM student_mgmt.box_office
WHERE YEAR(release_date)>= 2015 AND movie_name LIKE "%:%"
GROUP BY YEAR(release_date) ORDER BY 1;


SELECT year(release_date), COUNT(movie_name) 전체개봉편수, 
SUM(IF(movie_name LIKE '%:%', 1, 0)) 부제있는편수,  
ROUND(SUM(IF(movie_name LIKE '%:%', 1, 0))/COUNT(movie_name)*100, 2) "전체영화 중 부제있는 영화 비율" -- 총 영화의 개수로 한번 나눠서 비율을 봐야 
FROM box_office
WHERE year(release_date) >= 2015 -- _ 는 딱 한개
GROUP BY  year(release_date)
ORDER BY 1;

/*  5. 감독이 두 명 이상이면 콤마(,)로 이어져 있습니다(예, ‘홍길동,김감독’). 감독이 1명이면 그대로, 
   두 명 이상이면 콤마 대신 ‘/’ 값으로 대체해(예, ‘홍길동/김감독’) 출력하는 쿼리를 작성해 보세요. */

SELECT REPLACE(director,',','/')
FROM student_mgmt.box_office


-- 6. 부제가 있는 영화 찾기 ':' 2015년 이후의 개봉영화 중에서 부제가 달려있는 영화의 개수 세어보기 
set @country_name ='AGO';
SELECT * FROM world.country WHERE Code = "AGO";
SELECT * FROM world.country WHERE Code = @country_name;

-- SQL 변수는 테이블명, 컬럼명과 구분하기 위해 @를 앞에 달아줍니다.
-- SQL 변수는 SET 문을 사용하여 값을 설정하고, SELECT 문에서 사용할 수 있습니다.

SET @count = 5;
SELECT code, name, continent, region, population
  FROM world.country
 WHERE population > 100000000
 ORDER BY @count ASC; 


SET @count = 5;
PREPARE mySQL FROM 'SELECT code, name, continent, region, population
  FROM world.country
 WHERE population > 100000000
 ORDER BY ? ASC
 LIMIT 5';
EXECUTE mySQL USING @count;

-----------------------join---------------------------------------------


USE fisa;

drop table IF EXISTs emp;
drop table IF EXISTs dept;
DROP TABLE IF EXISTS salgrade;

CREATE TABLE dept (
    deptno               int  NOT NULL ,
    dname                varchar(20),
    loc                  varchar(20),
    CONSTRAINT pk_dept PRIMARY KEY ( deptno )
 );
 
CREATE TABLE emp (
    empno                int  NOT NULL  AUTO_INCREMENT,
    ename                varchar(20),
    job                  varchar(20),
    mgr                  smallint ,
    hiredate             date,
    sal                  numeric(7,2),
    comm                 numeric(7,2),
    deptno               int,
    CONSTRAINT pk_emp PRIMARY KEY ( empno )
 );
 
CREATE TABLE salgrade
 ( 
	GRADE INT,
	LOSAL numeric(7,2),
	HISAL numeric(7,2) 
);

--이미 만들어진 테이블의 내용(구조)를 변경할 때 사용되는 명령어
ALTER TABLE emp 
ADD CONSTRAINT fk_emp_dept FOREIGN KEY ( deptno ) REFERENCES dept( deptno ) 
ON DELETE NO ACTION ON UPDATE NO ACTION;

insert into dept values(10, 'ACCOUNTING', 'NEW YORK');
insert into dept values(20, 'RESEARCH', 'DALLAS');
insert into dept values(30, 'SALES', 'CHICAGO');
insert into dept values(40, 'OPERATIONS', 'BOSTON');

SELECT * from emp;
desc dept;
desc emp;
desc salgrade;

SELECT * from salgrade;

-----------------------------------------------------------------------------
/*
1. 조인이란?
	다수의 table간에  공통된 데이터를 기준으로 검색하는 명령어
	
	다수의 table이란?
		동일한 table을 논리적으로 다수의 table로 간주
			- self join
			- emp의 mgr 즉 상사의 사번으로 이름(ename) 검색
				: emp 하나의 table의 사원 table과 상사 table로 간주

		물리적으로 다른 table간의 조인
			- emp의 deptno라는 부서번호 dept의 부서번호를 기준으로 부서의 이름/위치 정보 검색
  
2. 사용 table 
	1. emp & dept 
	  : deptno 컬럼을 기준으로 연관되어 있음

	 2. emp & salgrade
	  : sal 컬럼을 기준으로 연관되어 있음

  
3. table에 별칭 사용 
	검색시 다중 table의 컬럼명이 다를 경우 table별칭 사용 불필요, 
	서로 다른 table간의 컬럼명이 중복된 경우,
	컬럼 구분을 위해 오라클 엔진에게 정확한 table 소속명을 알려줘야 함

	- table명 또는 table별칭
	- 주의사항 : 컬럼별칭 as[옵션], table별칭 as 사용 불가


4. 조인 종류 
	1. 동등 조인
		 = 동등비교 연산자 사용
		 : 사용 빈도 가장 높음
		 : 테이블에서 같은 조건이 존재할 경우의 값 검색 

	2. not-equi 조인
		: 100% 일치하지 않고 특정 범위내의 데이터 조인시에 사용
		: between ~ and(비교 연산자)

	3. self 조인 
		: 동일 테이블 내에서 진행되는 조인
		: 동일 테이블 내에서 상이한 칼럼 참조
			emp의 empno[사번]과 mgr[사번] 관계

	4. outer 조인 
		: 조인시 조인 조건이 불충분해도 검색 가능하게 하는 조인 
		: 두개 이상의 테이블이 조인될때 
		특정 데이터가 모든 테이블에 존재하지 않고 컬럼은 존재하나 
		null값을 보유한 경우 검색되지 않는 문제를 해결하기 위해 사용되는 조인
*/		




----------------------------------------------------------------------------------------
SELECT * FROM dept;
SELECT * FROM emp;
SELECT * FROM salgrade;
select * FROM dept


-- 	1. 동등 조인
-- 		 = 동등비교 연산자 사용
-- 		 : 사용 빈도 가장 높음
-- 		 : 테이블에서 같은 조건이 존재할 경우의 값 검색 

SELECT * 
FROM emp,dept 
WHERE emp.deptno = dept.deptno;


-- 조인하는 두 테이블에 중복된 컬럼명이 있으면 컬럼이 속한 테이블을 명시해주셔야 합니다

SELECT empno,ename,job,mgr,hiredate,sal,comm,emp.deptno,dname,loc 
FROM emp,dept 
WHERE emp.deptno = dept.deptno;


-- 출처를 명시해야 좋은 쿼리입니다.
--별명을 지어준다,
-- from 테이블 --> where -> select ,, as는 생략 가능
SELECT empno,ename,job,mgr,hiredate,sal,comm,e.deptno,dname,loc 
FROM emp as e,dept  d    
WHERE e.deptno = d.deptno AND ename='SMITH';

-- 2. SMITH 의 이름(ename), 사번(empno), 근무지역(부서위치)(loc) 정보를 검색
SELECT ename,e.empno, d.loc ,e.sal
FROM emp as e,dept  d    
WHERE e.deptno = d.deptno AND e.ename='SMITH';


/* 	2. not-equi 조인
		: 100% 일치하지 않고 특정 범위내의 데이터 조인시에 사용
		: between ~ and(비교 연산자) */
SELECT e.ename,e.empno ,e.sal,s.losal,s.hisal,s.GRADE
FROM emp as e,salgrade as s    
WHERE e.sal BETWEEN s.LOSAL and s.HISAL;


-- SMITH 씨의 GRADE를 출력해주시고
SELECT e.ename,e.empno ,e.sal,s.losal,s.hisal,s.GRADE
FROM emp as e,salgrade as s    
WHERE e.ename = 'SMITH' and e.sal BETWEEN s.LOSAL and s.HISAL;


-- 부서번호 30인 사람들의 각 이름, GRADE와 SAL, 상한선, 하한선 출력해주세요
SELECT e.deptno,e.ename,e.empno ,e.sal,s.losal,s.hisal,s.GRADE
FROM emp as e,salgrade as s    
WHERE e.deptno = 30 AND e.sal BETWEEN s.LOSAL and s.HISAL;

/*
	3. self 조인 
		: 동일 테이블 내에서 진행되는 조인
		: 동일 테이블 내에서 상이한 칼럼 참조
			emp의 empno[사번]과 mgr[사번] 관계
*/
SELECT e.empno,e.ename,e.mgr,m.ename FROM emp e, emp m
WHERE e.mgr = m.empno;


-- SMITH 직원의 매니저 이름 검색
-- emp e : 사원 table로 간주 / emp m : 상사 table로 간주
*/ 

SELECT m.ename FROM emp e, emp m
WHERE e.ename = "SMITH" AND e.mgr = m.empno;


-- 매니저 이름이 KING(m ename='KING')인 
-- 사원들의 이름(e ename)과 직무(e job) 검색

SELECT e.ename, e.job FROM emp e, emp m
WHERE m.ename = "KING" AND e.mgr = m.empno;
 



/*
	4. outer 조인 
		: 조인시 조인 조건이 불충분해도 검색 가능하게 하는 조인 
		: 두개 이상의 테이블이 조인될때 
		특정 데이터가 모든 테이블에 존재하지 않고 컬럼은 존재하나 
		null값을 보유한 경우 검색되지 않는 문제를 해결하기 위해 사용되는 조인
*/		
-- 40번부서에서 일하는 직원 

SELECT * FROM emp e WHERE deptno=40;

SELECT * FROM dept d LEFT OUTER JOIN emp e 
ON e.deptno = d.deptno;

--- outer 를 생략해도 된다

SELECT * FROM dept d LEFT JOIN emp e 
ON e.deptno = d.deptno;

-- 6. 조인을 사용해서 뉴욕('NEW YORK')에 근무하는 사원의 이름(ename)과 급여(sal)를 검색 

SELECT ename, sal from emp e, dept d
WHERE e.deptno = d.deptno AND d.loc ='NEW YORK'


-- 7. 조인 사용해서 ACCOUNTING 부서(dname)에 소속된 사원의
-- 이름과 입사일 검색
SELECT ename, hiredate from emp e, dept d
WHERE e.deptno = d.deptno AND d.dname ='ACCOUNTING'

-- 8. 직급(job)이 MANAGER인 사원의 이름(ename), 부서명(dname) 검색
SELECT e.ename, d.dname from emp e, dept d
WHERE e.deptno = d.deptno AND e.job ='MANAGER';

-- 9. 사원(emp) 테이블의 부서 번호(deptno)로 
-- 부서 테이블(dept)을 참조하여 사원명(ename), 부서번호(deptno),
-- 부서의 이름(dname) 검색
SELECT e.ename, e.deptno,d.dname from emp e, dept d
WHERE e.deptno = d.deptno;

-- 10. 부서번호 30인 사람들의 각 이름, GRADE와 SAL, 상한선, 하한선 출력해주세요
SELECT e.ename, e.sal,s.HISAL,s.LOSAL,s.GRADE from emp e, salgrade s
WHERE e.deptno = 30 and e.sal BETWEEN s.LOSAL AND s.HISAL ORDER BY 5 DESC;

-- 11. SMITH 직원의 매니저 이름 검색
-- emp e : 사원 table로 간주 / emp m : 상사 table로 간주

select m.ename
FROM emp e, emp m
WHERE e.ename = 'SMITH' and e.mgr = m.empno

-- 12. SMITH와 동일한 부서에서 근무하는 사원의 이름 검색
-- 단, SMITH 이름은 제외하면서 검색

select m.ename 팀원, e.deptno 부서번호
FROM emp e, emp m
WHERE e.ename = 'SMITH' and e.deptno = m.deptno and m.ename !='SMITH'


-- 13. 모든 사원명, 매니저 명 검색,  
select e.ename 팀원, m.ename 매니저명
FROM emp e , emp m 
WHERE e.mgr = m.empno;




-- 14. 모든 사원명(KING포함), 매니저 명 검색, 
-- 단 매니저가 없는 사원(KING)도 검색되어야 함
-- LEFT JOIN 사용

select e.ename
FROM emp e left join dept d
ON e.deptno = d.deptno;

-- 15. 모든 직원명(ename), 부서번호(deptno), 부서명(dname) 검색
-- 부서 테이블의 40번 부서와 조인할 사원 테이블의 부서 번호가 없지만,
-- outer join이용해서 40번 부서의 부서 이름도 검색하기 

SELECT e.ename, e.deptno, d.dname
FROM emp e RIGHT join dept d
on e.deptno = d.deptno;



-- 16. 모든 부서번호가 검색(40)이 되어야 하며 급여가 3000이상(sal >= 3000)인 사원의 정보 검색
-- 특정 부서에 소속된 직원이 없을 경우 사원 정보는 검색되지 않아도 됨
-- 검색 컬럼 : deptno, dname, loc, empno, ename, job, mgr, hiredate, sal, comm


--from -> where-> groupby -> having -> select -> orderby -> Limit

select * from emp e
where (sal + IFNULL(comm,0)) >= 2000;
-- sal, comm 둘중에 하나가 null(값없음)이면 어떤 연산/함수 이건 결과가 NULL이 되어버린다.