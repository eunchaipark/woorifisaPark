### **11일차 네줄리뷰(Four Lines Review)** ###
- 사실(Facts): SQL-2(데이터 조회, 집계 쿼리,SQL 함수, 조인)
- 발견(Discovery): SQL변수의 사용, 조인 사용법
- 배운점(Lesson Learned): 문자형함수, 시간함수, 형변환 
- 선언(Daclaration): 알고 있었으나 까먹은 쿼리문과 문법이 많다.  

### 잊었다가 다시 배운 개념  ###
- 문자형함수(FORMAT, CONCAT,LOWWER,UPPER 등등)
```
SELECT FORMAT(123456789.123456, 3) fmt, -- FORMAT(숫자를 3개씩 끊어서 ,로 출력, 소수점이후 N번째 자리까지 반올림 출력)
       INSTR('ThisIsSQL', 'sql') instring, -- index string, MySQL은 1부터 시작, 윈도우서버 SQL은 대소문자 구분 없음 
       LOCATE('my', 'TheMyDBMSMySQL') locates, -- 'TheMyDBMSMySQL'에서 'my'를 찾아줘 5번째인덱스 이후에서 
       POSITION('my' IN 'TheMyDBMSMySQL') pos; -- LOCATE('my', 'TheMyDBMSMySQL', 1) 과 같은 동작
```  
- 시간함수(INTERVAL, ADD_DATE 등등)
- 형변환 (CAST) ```SELECT CAST(10 AS CHAR)                 CONV_CHAR, ---10을 CHAR으로 형변환```
- 변수 사용
```
SET @count = 5;
SELECT code, name, continent, region, population
  FROM world.country
 WHERE population > 100000000
 ORDER BY @count ASC;
```
- 조인(동등조인, NOT-EQUAL조인, SELF조인, OUTER조인) 가장 헷갈렸던 LIFT,RIGHT조인
```
-- 15. 모든 직원명(ename), 부서번호(deptno), 부서명(dname) 검색
-- 부서 테이블의 40번 부서와 조인할 사원 테이블의 부서 번호가 없지만,
-- outer join이용해서 40번 부서의 부서 이름도 검색하기 

SELECT e.ename, e.deptno, d.dname
FROM emp e RIGHT join dept d
on e.deptno = d.deptno;
```
  
### 몰랐던 개념 ###
- 흐름 제어함수: IF(), IFNULL(), NULLIF() 함수가 있고, 흐름 제어 함수와 비슷한 역할을 하는 CASE 연산자도 있다
```
SELECT IF(2 < 1, 1, 0) IF1,  -- IF(조건, 참일때 리턴값, 거짓일 때 리턴값)
       IF('A' = 'a', 'SAME', 'NOT SAME') IF2, -- window의 MYSQL에서는 대소문자 구분 X 
       IF(1 = 2, 1, 'A') IF3;
```
- QUARTER(시간DATA) 사용
- 연산결과로 NULL이 나올때
```
select * from emp e
where (sal + IFNULL(comm,0)) >= 2000;
-- sal, comm 둘중에 하나가 null(값없음)이면 어떤 연산/함수 이건 결과가 NULL이 되어버린다.
```
