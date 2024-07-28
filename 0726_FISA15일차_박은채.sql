USE fisa;
-- 서브쿼리
-- 조인으로도 가능하지만 join은 모든행을 돌면서 결과를 찾지만 서브쿼리는 내부 쿼리의 결과로 행을 도출하기에 속도가 빠른경우가 많다.
--SQL 실행순서
-- FROM -> WHERE -> GROUP BY -> HAVING -> SELECT -> ORDER BY -> LIMIT

select * FROM emp;
select * FROM dept;
select * FROM salgrade;

-- 부서가 accounting 인 사람의 이름
select e.ename, e.deptno
from  emp as e,(SELECT deptno from dept as d WHERE d.dname = 'ACCOUNTING') as d
WHERE e.deptno = d.deptno;
SELECT * FROM dept d 

SELECT d.dname
FROM dept d
WHERE d.deptno=(SELECT e.deptno -- 스미스의 부서번호를 조회한 결과
   FROM emp e
    WHERE e.ename='SMITH');


-- SMITH씨와 동일한 RESEARCH 부서 가진 모든 사원의 이름을 출력해보세요

SELECT e.ename
FROM emp e,dept d
WHERE e.deptno=(SELECT e.deptno -- 스미스의 부서번호를 조회한 결과
   FROM emp e
    WHERE e.ename='SMITH') AND e.ename != "SMITH";

SELECT e.deptno -- 스미스의 부서번호를 조회한 결과
   FROM emp e
    WHERE e.ename='SMITH';   --위의 서브쿼리인데 단독으로도 돌아간다.

SELECT e.ename,
(SELECT d.dname FROM dept d WHERE e.deptno = d.deptno) as deptno
FROM emp e;   --서브 쿼리만 단독적으로 돌아가지 않는다. emp를 사용하기 떄문이다. 즉 외부쿼리와 서브쿼리의 연관성이 존재한다.

-- 서브쿼리가 있으면 고치기가 좀 어렵다.




-- 2. FROM 절에서의 서브쿼리
-- 파생(derived) 서브쿼리
-- 꼭 별칭을 붙여서 외부 쿼리문에서는 별칭으로 사용합니다.
-- 서브쿼리가 반환하는 결과 집합을 하나의 테이블처럼 사용하는 쿼리문
-- 서브쿼리 안에서 사용해도 된다 
-- FROM -> WHERE -> SELECT 


SELECT b.deptno, b.empno, c.ename
					  FROM emp b,
					       emp c
					 WHERE b.empno = c.empno;

SELECT a.deptno, a.dname
  FROM dept a
 ORDER BY 1;
 -- join으로 해결
 -- emp 테이블에서 SMITH 직원명 검색해서 
 -- 어떤 부서인지 dept 테이블에서 찾아서 출력하기


select * FROM emp e where e.ename ='SMITH'

select d.dname from dept d,
 (select deptno FROM emp e where e.ename ='SMITH') as s WHERE s.deptno = d.deptno;


-- 3. WHERE절의 서브쿼리
-- - 특정 데이터를 걸러내기 위한 일반 조건이나 조회 조건을 기술 
-- 비교 연산자 또는 ANY(~ 중 하나), SOME(하나라도 있으면), ALL(모두) 연산자를 사용하기도 함
-- where절에서 서브쿼리를 쓰려면 컬럼의 개수가 맞아야한다.
SELECT e.ename FROM emp e WHERE e.ename='SMITH';

SELECT d.dname
FROM dept d
WHERE d.deptno=(SELECT e.deptno FROM emp e WHERE e.ename='SMITH');

-- SMITH 씨랑 급여가 같거나 더 많은 사원명과 급여를 검색해주세요
SELECT * FROM emp where ename = "SMITH";
SELECT e.ename, e.sal
FROM emp e
WHERE e.sal>=(SELECT e.sal FROM emp e WHERE e.ename='SMITH') AND ename != 'SMITH';


-- 급여가 3000불 이상인 사원이 소속된 부서(10, 20)에 속한 사원이름, 급여 검색
SELECT d.deptno FROM dept d where (d.deptno =10) or (d.deptno=20);
SELECT e.ename, e.sal, e.deptno
FROM emp e
WHERE e.sal>=3000 AND e.deptno = ANY(SELECT d.deptno FROM dept d where (d.deptno =10) or (d.deptno=20));

-- EXISTS 연산자는 메인쿼리 테이블의 값 중에서 서브쿼리의 결과 집합에
-- 존재하는 건이 있는지를 확인하는 역할

-- EXISTS                  
-- 서브쿼리의 결과값이 존재하면 참
SELECT e.ename, e.sal, e.deptno
FROM emp e, dept d
WHERE e.sal>=3000 AND e.deptno IN (10, 20)
EXISTS
-- 각 부서별로 SAL가 가장 높은 사람은 누구일까요? 
-- 서브쿼리에 group by를 사용할 수 있다 
				  -- group by로는 볼 수 없던 행별 정보를 서브쿼리로 추출한 테이블로 필터링해서 꺼낼 수 있다 

select max(e.sal),e.deptno from emp e, dept d GROUP BY e.deptno;

SELECT ename, sal, deptno from emp where sal in (select max(e.sal) from emp e, dept d GROUP BY e.deptno);

SELECT ename, sal, deptno from emp where (e.sal,e.deptno) in (select max(e.sal),e.deptno from emp e, dept d GROUP BY e.deptno);
-- IN 연산자는 여러개 컬럼의 값을 비교해서 꺼낼 수 있습니다
-- 단 순서가 맞아야 합니다 


-- 실습

-- 2018년에 가장 많은 매출을 기록한 영화보다 더 많은 매출을 기록한 2019년도 영화를 검색해주세요    
use student_mgmt;
select * from box_office;
select Max(sale_amt) from box_office WHERE years = 2018; 
select b.movie_name from box_office b WHERE b.sale_amt >=(select Max(sale_amt) from box_office WHERE years = 2018); 


-- 2019년에 개봉한 영화 중 2018년에는 개봉하지 않았던 영화의 순위, 영화명, 감독을 검색해주세요
select movie_name,release_date from box_office where YEAR(release_date)=2018;
SELECT movie_name,ranks,director FROM box_office 
where YEAR(release_date) = 2019 and movie_name not in (
select movie_name from box_office where YEAR(release_date)=2018); 

-- 2018년에도 개봉했고, 2019년에 다시 개봉한 영화의 순위, 영화명, 감독을 검색해주세요.

SELECT movie_name,ranks,director,years FROM box_office 
where YEAR(release_date) = 2019 and movie_name in (
select movie_name from box_office where YEAR(release_date)=2018);



------------------------------------------------------------------------------------
--# from 절에서의 서브쿼리
-- emp 테이블에서 급여가 2000이 넘는 사람들의 이름과 부서번호, 부서이름, 지역 조회해 보세요.
USE fisa;
select * FROM emp WHERE sal >=2000;
select e.deptno, e.ename, d.dname, d.loc,e.sal
from dept d,(select * FROM emp m WHERE sal >2000) as e WHERE e.deptno = d.deptno;
-- emp 테이블에서 커미션이 있는 사람들의 이름과 부서번호, 부서이름, 지역을 조회해 보세요.
select * FROM emp m WHERE sal >=2000;
-- join 절에서의 서브쿼리

-- 모든 부서의 부서이름과, 지역, 부서내의 평균 급여를 조회해 보세요.
select e.deptno, e.ename,d.loc,e.sal,d.dname from emp e JOIN dept d ON e.deptno = d.deptno;
select * from emp e JOIN dept d on e.deptno = d.deptno;
select * from emp e, dept d WHERE e.deptno = d.deptno; 
select u.deptno, u.dname, AVG(u.sal) FROM (
    select e.deptno, d.dname, e.sal from emp e, dept d WHERE e.deptno = d.deptno
) as u GROUP BY u.deptno, u.dname;


SELECT u.deptno, u.dname, MAX(u.sal) as max_sal, MIN(u.sal) as min_sal, AVG(u.sal) as avg_sal
FROM (
    SELECT e.deptno, e.ename, d.loc, e.sal, d.dname
    FROM emp e
    JOIN dept d ON e.deptno = d.deptno
) AS u
GROUP BY u.deptno, u.dname;



use fisa;
-- CTE는 FROM 절에서만 쓸 수 있다 


## SQL 실행순서
-- FROM -> WHERE -> GROUP BY -> HAVING -> SELECT -> ORDER BY -> LIMIT

-- 모든 부서의 정보와 함께 커미션이 있는 직원들의 커미션과 이름을 조회해 보세요.
select * from emp;
SELECT deptno,AVG(sal) from emp GROUP BY deptno WHERE EXISTS (comm>=0);
-- 모든 부서의 부서별 연봉에 대한 총합과 평균과 표준편차를 구하고
-- 모든 부서의 사원수를 구해 보세요.
select count(*) from emp e join dept d on e.deptno = d.deptno;
select AVG(i.sal) 평균, STDDEV(i.sal) 표준편차, SUM(i.sal) 총합
from (select e.sal,e.ename,e.deptno,d.dname from emp e join dept d on e.deptno = d.deptno) as i
GROUP BY i.deptno,i.dname;




-- 각 관리자의 부하직원수와 부하직원들의 평균연봉을 구해 보세요.

SELECT mgr, SUM(sal), COUNT(*)
FROM emp
WHERE mgr IS NOT NULL
GROUP BY mgr;


# Sub-Query 
-- 쿼리 안쪽에 쿼리를 넣을수 있다.
-- where 절에서의 서브쿼리
-- scott과 같은 부서에 있는 직원 이름을 검색해 보세요.
SELECT ename, deptno
FROM emp
WHERE deptno = (SELECT deptno
				FROM emp
				WHERE ename='SCOTT')
	AND ename != 'SCOTT';



-- 직무(job)가 Manager인 사람들이 속한 부서의 부서번호와 부서명 , 지역을 조회해 보세요.
	-- manager 사람들이 다수이기 때문에 where절에 in 을 활용!
SELECT deptno, dname, loc
FROM dept
WHERE deptno IN (SELECT deptno
				FROM emp
				WHERE job='MANAGER');



# from 절에서의 서브쿼리
-- emp 테이블에서 급여가 2000이 넘는 사람들의 이름과 부서번호, 부서이름, 지역 조회해 보세요.
SELECT e.ename, d.deptno, d.dname, d.loc -- FROM절의 파생테이블은 외부쿼리에서도 사용할 수 있습니다 
FROM (SELECT ename, deptno
		FROM emp
		WHERE sal>=2000) e, dept d -- 별칭을 꼭 가집니다 
WHERE e.deptno=d.deptno;



-- emp 테이블에서 커미션이 있는 사람들의 이름과 부서번호, 부서이름, 지역을 조회해 보세요.
SELECT e.ename, e.deptno, d.dname, d.loc
FROM (SELECT *
		FROM emp
		WHERE comm>0) e, dept d
WHERE e.deptno=d.deptno;




-- join 절에서의 서브쿼리
-- 모든 부서의 부서이름과, 지역, 부서내의 평균 급여를 조회해 보세요.
-- 모든 부서의 부서이름과, 지역, 부서내의 평균 급여를 조회해 보세요.
SELECT d.dname, d.loc, e.sal_avg -- 해당 컬럼명으로 호출해서 외부에서도 값을 사용할 수 있습니다 
FROM (SELECT e.deptno, AVG(e.sal) AS sal_avg -- FROM 절 안에서 컬럼명을 만들어주면 
	FROM emp e
	GROUP BY e.deptno) e, dept d
WHERE d.deptno=e.deptno;






-------------------------------------------------------------------------------
/*
1. insert sql문법
	1-1. 모든 칼럼에 데이터 저장시 
		insert into table명 values(데이터값1, ...)

	1-2.  특정 칼럼에만 데이터 저장시,
		명확하게 칼럼명 기술해야 할 경우 
		insert into table명 (칼럼명1, ...) values(칼럼과매핑될데이터1...)


2. update -> 특정 조건에 맞는 행을 찾아서 수정 
	2-1. 모든 table(다수의 row)의 데이터 한번에 수정
		- where조건문 없는 문장
		- update table명 set 칼럼명=수정데이타; -- job이라는 컬럼을 만들고 : 회사원, 연봉 컬럼에 모두 100만원을 올려주는 경우 

	2-2. 특정 row값만 수정하는 방법
		- where조건문으로 처리하는 문장
		- update table명 set 칼럼명=수정데이타[, 컬럼명2=수정데이터2,..] where 조건sql;
		
		
3. delete		
	- 존재하는 데이터 삭제

*/
SELECT @@autocommit; ---즉시 변경이 반영된다.
use fisa;

select * FROM dept;
desc dept;
INSERT INTO dept VALUES(99,'교육','상암');  --컬럼 개수와 자료형에 맞게 값을 넣기

INSERT INTO dept (deptno, loc) VALUES(98,'강동'); --컬럼을 지정해서 넣는다.

INSERT INTO dept (deptno, loc) VALUES(97,'양천'),(96,'강서'); --여러개를 넣을떄 ,로 몆개든 넣을수 있다.


-- 데이터 구조만 복제해서 새로 생성
-- empno, ename, deptno emp 테이블을 가지고오되 구조만 가져와 보세요.
CREATE table emp01 select empno, ename, deptno from emp;
select * from emp01; --값을 고대로 뜯어와서 만들었다. 테이블을 복제하면 제약조건들은 가지고 오지 않는다. 
--자료형만 가져온다
desc emp01; 
CREATE table emp02 select empno, ename, deptno from emp where 1=0; --거짓을 써서 뜯어올 데이터를 버린다 즉 텅빈 테이블을 만든다
select * from emp02;
drop table if EXISTS emp02;

set @@autocommit =0; --거짓이라는 뜻
CREATE table emp02 select empno, ename, deptno from emp where 1=0;
INSERT into emp02 VALUES(1,'은채',10);
select * from emp02;


-- null을 허용하는 컬럼에 값 미저장시 특정 컬럼만 명시해서 값 저장 가능
-- DEFALUT 값이 정해진 컬럼을 명시해서 값을 넣지 않으면 DEFAULT 값이 들어갑니다 
desc emp01;--테이블을 복제시 다른 테이블에 영향을 주는 조건들 (primary key, forigien key)는 복제안됨
-- 자기테이블/ 자기 컬럼에만 영향을 주는 조건들 (not null, 자료형)은 복제가 된다.

-- 3. 0으로 들어가는 부분들은 '일단 채워넣음'  
INSERT INTO emp01 VALUES(NULL,'박은채2',20); --이건 안들어감
INSERT INTO emp01 (ename,deptno) VALUES('박은채2',20);
 --숫자형으로 값을 받는 컬럼의 경우 not null이 조건으로 걸려있는데 아무것도 넣지 않으면 0을 default값을 넣어주도록 구현된다.
select * from emp01;




-----------------------------------
-- 4. 데이터만 삭제 - rollback으로 복구 불가능한 데이터 삭제 명령어
-- DELETE 명령어로 empno가 0인 사람들의 행만 삭제해주세요 

DELETE FROM emp01 WHERE empno =0;
select * from emp01;

select * from emp02;
-----------------------------------------------

-- *** update ***
-- 1. 테이블의 모든 행 변경 UPDATE 테이블명 SET 컬럼명=값
UPDATE emp02 set deptno =1;
update emp02 set deptno = 10; --기본적으로 모든 행에 적용이 된다.
update emp02 set deptno =20 where deptno=60;
update emp02 set deptno = deptno + 40;

select * from emp;
drop table emp01;

-- emp01 table의 모든 사원의 급여를 10%(sal*1.1) 인상하기
-- ? emp table로 부터 empno, sal, hiredate, ename 순으로 table 생성

create table emp01 select empno, sal, hiredate, ename from emp;
select * from emp01 ;
update emp01 set sal=sal*1.1;
