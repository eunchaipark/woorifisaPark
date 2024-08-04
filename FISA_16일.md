### **16일차 네줄리뷰(Four Lines Review)** ###
- 사실(Facts): INTEGRITY(무결성), INDEX(인덱스),VIEW(뷰),윈도우 함수, 스토어드 프로시저
- 발견(Discovery):  CASCADE사용, 인데스에 따른 조회 결과의 차이, VIEW에 값추가에 따른 원본의 변경 여부
- 배운점(Lesson Learned): CASCADE와 무결성의 연관, PRIMARY KET와 UNIQUE의 차이(클러스터 인덱스, 비클러터형 인덱스)
- 선언(Daclaration): 데이터 무결성과 윈도우 함수, 스토어드 프로시저에 대한 이해가 부족하다. 더욱 공부해야 필요성을 느낀다.

### 잊었다가 다시 배운 개념  ###
```
TRUNCATE emp01;   --emp01에 잇는 값을들 없앤다
```  
- 테이블 생성시 default값 생성 및 변경
```
CREATE TABLE emp05(
	empno int primary key,
    ename varchar(10) not null,
    age int default 1 -- 0 
);-- 테이블 생성 할때 디폴트값 생성

alter table emp05 MODIFY age int DEFAULT 0;  -- 이미 디폴트값이 1로 설정된 age의 디폴트값을 0으로 변경
```
- CASCADE
```
ALTER TABLE emp 
ADD CONSTRAINT fk_emp_dept FOREIGN KEY ( deptno ) REFERENCES dept( deptno ) 
ON DELETE NO ACTION ON UPDATE NO ACTION; -- 참조하게 되는데 참조하는 값에 존재하지 않으면 아무런 동작도 하지 않는다.

ALTER TABLE emp 
ADD CONSTRAINT fk_emp_dept2 FOREIGN KEY ( deptno ) REFERENCES dept( deptno ) 
ON DELETE CASCADE ON UPDATE CASCADE;    -- cascade 조건 적용
-- cascade 조건을 적용하면 부모에서 데이터를 삭제되면 그에 참조되는 자식 데이터도 삭제된다.

 ```
 - view에도 데이터 추가 가능, 하지만 조인을 해서 view를 만든경우는 값을 함부로 삽입도 삭제도 안된다.
 - - 원본을 변경시 view에도 영향이 간다. 조인을 하지 않고 단순히 만든 view의 경우 변경시 원본도 변경된다.
 
 
 
### 몰랐던 개념 ###
```
create index idx_emp01_empno on emp01(empno); --인덱스 생성
alter table emp01 drop index idx_emp01_empno; -- 인덱스 제거
```
- 윈도우 함수(Rank,DENSE_RANK,ROW_NUMBER(),FIRST_VALUE,LAST_VALUE,LAG,LEAD)
```
-- 현재 회사에서 2번째로 돈을 많이 받는 사람은 누구일까요?
SELECT * from (select ename, job,deptno,sal,RANK() OVER (ORDER BY sal)as rn from emp) as r where rn =2;

-- 부서별로 돈을 가장 적게 받는 사람
select ename, job,deptno,sal,MIN(sal) over (PARTITION BY job ORDER BY sal) from emp ;


-- 부서별로 가장 돈을 많이 받는 사람만 확인할 수 있게 쿼리로 만들어서 결과를 출력해주세요
select ename,sal job,deptno,LAG(sal) over (PARTITION BY deptno order by sal DESC) from emp;

SELECT * FROM (SELECT ename, sal, deptno, RANK() OVER (PARTITION BY deptno ORDER BY sal ASC) 순위 FROM emp) AS S
WHERE S.순위 = 1;

-- 부서별로 가장 돈을 많이 받는 사람을 'MAXIMUM'이라는 컬럼에 별도로 출력해주세요 
SELECT * FROM (SELECT ename, sal, deptno, RANK() OVER (PARTITION BY deptno ORDER BY sal DESC) 순위 FROM emp) AS S
WHERE S.순위 = 1;
```
- 스토어드 프로시저(Stored Procedure) : 자주 사용하는 여러개의 SQL문을 한데 묶어 함수처럼 만들어 일괄적으로 처리하는 용도로 사용됩니다.
```
DELIMITER // --DELIMITER //로 procedure의 시작과 끝을 표현한다,
CREATE Procedure employees_hireyear(OUT employee_count int)  -- 프로시저이름(out 매개변수 자료형)
Begin
    select count(hiredate) into employee_count from emp where year(hiredate) < 1984;
END // 
DELIMITER;
-- 이거 할때 delimiter 처음부터 끝까지 한번에 잡고 실행해야 함
SET @employee_count = 0;
CALL employees_hireyear(@employee_count);
SELECT @employee_count;```

