### **15일차 네줄리뷰(Four Lines Review)** ###
- 사실(Facts): SQL-3(데이터 조회, 서브 쿼리), 데이터 조작어(INSERT,UPDATE,DELETE)
- 발견(Discovery):  서브쿼리의 사용(서브 쿼리에서의 GROUP BY 사용)
- 배운점(Lesson Learned): 서브쿼리를 사용한 데이터 조회 ,(ANY,ALL,IN)사용, 데이터 조작어 사용
- 선언(Daclaration): 서브쿼리, 데이터 조작어등을 사용한 데이터 조회에 대한 익숙함이 필요하다

### 잊었다가 다시 배운 개념  ###
- (ANY,ALL,IN)사용
```
SELECT e.ename, e.sal, e.deptno
FROM emp e, dept d
WHERE e.sal>=3000 AND e.deptno IN (10, 20);
```  
- WHERE절에서의 서브쿼리 사용
```
SELECT movie_name,ranks,director FROM box_office 
where YEAR(release_date) = 2019 and movie_name not in (
select movie_name from box_office where YEAR(release_date)=2018); 

```
-  from 절에서의 서브쿼리
	- 모든 부서의 부서이름과, 지역, 부서내의 평균 급여를 조회해 보세요.
```
SELECT u.deptno, u.dname, MAX(u.sal) as max_sal, MIN(u.sal) as min_sal, AVG(u.sal) as avg_sal
FROM (
    SELECT e.deptno, e.ename, d.loc, e.sal, d.dname
    FROM emp e
    JOIN dept d ON e.deptno = d.deptno
) AS u
GROUP BY u.deptno, u.dname;
```
- INSERT
```
INSERT INTO dept VALUES(99,'교육','상암');  --컬럼 개수와 자료형에 맞게 값을 넣기
INSERT INTO dept (deptno, loc) VALUES(98,'강동'); --컬럼을 지정해서 넣는다.
INSERT INTO dept (deptno, loc) VALUES(97,'양천'),(96,'강서'); --여러개를 넣을떄 ,로 몆개든 넣을수 있다.
select * from emp01; --값을 고대로 뜯어와서 만들었다. 테이블을 복제하면 제약조건들은 가지고 오지 않는다. 
CREATE table emp02 select empno, ename, deptno from emp where 1=0; --거짓을 써서 뜯어올 데이터를 버린다 즉 텅빈 테이블을 만든다
```
- UPDATE
```
  UPDATE emp02 set deptno =1;
update emp02 set deptno = 10; --기본적으로 모든 행에 적용이 된다.
update emp02 set deptno =20 where deptno=60;
update emp02 set deptno = deptno + 40;
```
- DELETE 
```
DELETE FROM emp01 WHERE empno =0;
```
  
### 몰랐던 개념 ###
- 테이블을 복제시 다른 테이블에 영향을 주는 조건들 (primary key, forigien key)는 복제안됨
-- 자기테이블/ 자기 컬럼에만 영향을 주는 조건들 (not null, 자료형)은 복제가 된다.select * from emp e
--숫자형으로 값을 받는 컬럼의 경우 not null이 조건으로 걸려있는데 아무것도 넣지 않으면 0을 default값을 넣어주도록 구현된다.
