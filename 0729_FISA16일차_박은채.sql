use fisa;
select * from emp01;
TRUNCATE emp01;   --emp01에 잇는 값을들 없앤다
INSERT INTO emp01 VALUES (1,2,'1998-09-14','park')
 on DUPLICATE KEY UPDATE empno =99;  --만약 현재 empno가 primary 키인데 1이 중복되면 99로 바꾼다.
--primary키로 설정하면 그를 중심으로 index가 된다.
INSERT INTO emp01 VALUES (2,2,'1998-09-14','park')
 on DUPLICATE KEY UPDATE empno =99;

ALTER TABLE emp01 add constraint PRIMARY KEY (empno); 
INSERT into emp01 VALUES (1,2,'1998-09-14','park');

-------------------------------------------------------여기 까지가 dml
-- 5.integrity.sql  무결성

-- CREATE table 생성시 마지막 부분에 생성
/*
1.  1-1 CREATE TABLE people(
        컬럼명, 자료형 제약조건
    )
    CREATE TABLE people(
        컬럼명, 자료형 
    )constraint 제약조건명 제약조건 (컬러명)

	1-2. alter 명령어로 제약조건 추가
	- 이미 존재하는 table의 제약조건 수정(추가, 삭제)명령어
		alter table 테이블명 add/modify 컬럼명 타입 제약조건;
		
	1-3. 제약조건 삭제(drop)
		- table삭제 
		alter table 테이블명 alter 컬럼명 drop 제약조건;
2. 제약 조건 종류
	emp와 dept의 관계
		- dept 의 deptno가 원조 / emp 의 deptno는 참조
		- dept : 부모 table / emp : 자식 table(dept를 참조하는 구조)
		- dept의 deptno는 중복 불허(not null) - 기본키(pk, primary key)
		- emp의 deptno - 참조키(fk, foreign key, 외래키)
	
	
	2-1. PK[primary key] - 기본키, 중복불가, null불가, 데이터들 구분을 위한 핵심 데이터
		: not null + unique
	2-2. not null - 반드시 데이터 존재
	2-3. unique - 중복 불가, null 허용
	2-4. check - table 생성시 규정한 범위의 데이터만 저장 가능 
	2-5. default - insert시에 특별한 데이터 미저장시에도 자동 저장되는 기본 값
				- 자바 관점에는 멤버 변수 선언 후 객체 생성 직후 멤버 변수 기본값으로 초기화
	* 2-6. FK[foreign key] 
		- 외래키[참조키], 다른 table의 pk를 참조하는 데이터 
		- table간의 주종 관계가 형성
		- pk 보유 table이 부모, 참조하는 table이 자식*/

		
-- fk_emp_dept 
-- 참조하는 테이블(emp)에 해당 외래 키 값이 존재하면 삭제를 허용하지 않습니다.
-- 즉, dept 테이블에서 deptno 값이 삭제되려 할 때, emp 테이블에 동일한 deptno 값이 존재하면 삭제가 실패합니다.
-- 참조하는 테이블(emp)에 해당 외래 키 값이 존재하면 업데이트를 허용하지 않습니다.
-- 즉, dept 테이블에서 deptno 값이 변경되려 할 때, emp 테이블에 동일한 deptno 값이 존재하면 업데이트가 실패합니다.*/
--------------------------------------------------------------------------------------

ALTER TABLE emp 
ADD CONSTRAINT fk_emp_dept FOREIGN KEY ( deptno ) REFERENCES dept( deptno ) 
ON DELETE NO ACTION ON UPDATE NO ACTION; 


SELECT * from emp;
desc emp; --MUL: 값을 참조해서 들어간다.
INSERT INTO fisa.emp VALUES (1, '신짱구', '유치원생', 2, now(), 800, null, 40);
INSERT INTO fisa.emp VALUES (2, '신짱구', '유치원생', 2, now(), 800, null, 50);
--50으로 바꿔서 넣어도 dept talbe에서 deptno의 값에 50이 존재하지 않기에 들어가지지 않는다. 

SELECT * from dept;
INSERT into dept VALUES (50,'SALES','KOREA');
INSERT INTO fisa.emp VALUES (2, '신짱구', '유치원생', 2, now(), 800, null, 50);  --위에 deptno 50짜리를 dept테이블에 만들었기에 들어가진다.
select * FROM emp;
select * FROM dept;
DELETE from dept where deptno =40;
--Cannot delete or update a parent row: a foreign key constraint fails (fisa.emp, CONSTRAINT fk_emp_dept FOREIGN KEY (deptno) REFERENCES dept (deptno))





-- CASCADE : 폭포
-- 참조하는 테이블(emp)에 해당 외래 키 값이 존재하면 삭제를 허용합니다.
-- 즉, dept 테이블에서 deptno 값이 삭제되려 할 때, emp 테이블에 동일한 deptno 값이 존재하면 삭제가 성공합니다.
-- 참조하는 테이블(emp)에 해당 외래 키 값이 존재하면 업데이트를 허용합니다.
-- 즉, dept 테이블에서 deptno 값이 변경되려 할 때, emp 테이블에 동일한 deptno 값이 존재하면 업데이트가 성공합니다.
-- 부모한테 영향이 생기면 자식에게도 미친다.

ALTER Table emp drop constraint fk_emp_dept;

ALTER TABLE emp 
ADD CONSTRAINT fk_emp_dept2 FOREIGN KEY ( deptno ) REFERENCES dept( deptno ) 
ON DELETE CASCADE ON UPDATE CASCADE;    -- cascade 조건 적용 

SELECT * from emp;
desc emp; --MUL: 값을 참조해서 들어간다.
INSERT INTO fisa.emp VALUES (3, '신짱구', '유치원생', 2, now(), 800, null, 50);
--50으로 바꿔서 넣어도 dept talbe에서 deptno의 값에 50이 존재하지 않기에 들어가지지 않는다. 
UPDATE dept set deptno = 50 where deptno=40;

DELETE from dept where deptno = 50;  -- 부모에서 50에 해당하는 값을 없앴더니 자식에서 50을 가지고 있는 값들도 사라진다.
SELECT * from dept;
select * FROM emp;
---------------------------------
use fisa;
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
    CONSTRAINT pk_emp PRIMARY KEY ( empno ) -- 중복되지 않고, 고유한 값을 가지고 있는 컬럼 '기본키' 
 );
 
CREATE TABLE salgrade
 ( 
	GRADE INT,
	LOSAL numeric(7,2),
	HISAL numeric(7,2) 
);

insert into dept values(10, 'ACCOUNTING', 'NEW YORK');
insert into dept values(20, 'RESEARCH', 'DALLAS');
insert into dept values(30, 'SALES', 'CHICAGO');
insert into dept values(40, 'OPERATIONS', 'BOSTON');

desc dept;
desc emp;
desc salgrade;

-- STR_TO_DATE() : 단순 문자열을 날짜 형식의 타입으로 변환 
insert into emp values( 7839, 'KING', 'PRESIDENT', null, STR_TO_DATE ('17-11-1981','%d-%m-%Y'), 5000, null, 10);
insert into emp values( 7698, 'BLAKE', 'MANAGER', 7839, STR_TO_DATE('1-5-1981','%d-%m-%Y'), 2850, null, 30);
insert into emp values( 7782, 'CLARK', 'MANAGER', 7839, STR_TO_DATE('9-6-1981','%d-%m-%Y'), 2450, null, 10);
insert into emp values( 7566, 'JONES', 'MANAGER', 7839, STR_TO_DATE('2-4-1981','%d-%m-%Y'), 2975, null, 20);
insert into emp values( 7788, 'SCOTT', 'ANALYST', 7566, DATE_ADD(STR_TO_DATE('13-7-1987','%d-%m-%Y'), INTERVAL -85 DAY)  , 3000, null, 20);
insert into emp values( 7902, 'FORD', 'ANALYST', 7566, STR_TO_DATE('3-12-1981','%d-%m-%Y'), 3000, null, 20);
insert into emp values( 7369, 'SMITH', 'CLERK', 7902, STR_TO_DATE('17-12-1980','%d-%m-%Y'), 800, null, 20);
insert into emp values( 7499, 'ALLEN', 'SALESMAN', 7698, STR_TO_DATE('20-2-1981','%d-%m-%Y'), 1600, 300, 30);
insert into emp values( 7521, 'WARD', 'SALESMAN', 7698, STR_TO_DATE('22-2-1981','%d-%m-%Y'), 1250, 500, 30);
insert into emp values( 7654, 'MARTIN', 'SALESMAN', 7698, STR_TO_DATE('28-09-1981','%d-%m-%Y'), 1250, 1400, 30);
insert into emp values( 7844, 'TURNER', 'SALESMAN', 7698, STR_TO_DATE('8-9-1981','%d-%m-%Y'), 1500, 0, 30);
insert into emp values( 7876, 'ADAMS', 'CLERK', 7788, DATE_ADD(STR_TO_DATE('13-7-1987', '%d-%m-%Y'),INTERVAL -51 DAY), 1100, null, 20);
insert into emp values( 7900, 'JAMES', 'CLERK', 7698, STR_TO_DATE('3-12-1981','%d-%m-%Y'), 950, null, 30);
insert into emp values( 7934, 'MILLER', 'CLERK', 7782, STR_TO_DATE('23-1-1982','%d-%m-%Y'), 1300, null, 10);


INSERT INTO SALGRADE VALUES (1,700,1200);
INSERT INTO SALGRADE VALUES (2,1201,1400);
INSERT INTO SALGRADE VALUES (3,1401,2000);
INSERT INTO SALGRADE VALUES (4,2001,3000);
INSERT INTO SALGRADE VALUES (5,3001,9999);

COMMIT;
SELECT * FROM DEPT;
SELECT * FROM EMP;
SELECT * FROM SALGRADE;

COMMIT;


use information_schema;
SELECT * FROM fisa.emp;
 
 -- mysql에 사전 table 검색 : 테이블에 대한 테이블 (현재 DB에 대한 메타데이터)
select TABLE_SCHEMA, TABLE_NAME 
from information_schema.TABLES

where TABLE_SCHEMA = 'information_schema';

-- EMP와 DEPT 테이블에 모두 deptno라는 열이 존재한다면, 쿼리 결과는 다음과 같습니다
SELECT COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME IN ('EMP', 'DEPT')
GROUP BY COLUMN_NAME
HAVING COUNT(TABLE_NAME) > 1;   


SELECT *
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
WHERE TABLE_NAME IN ('EMP');   

SELECT *
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
WHERE TABLE_NAME IN ('SALGRADE');  --SALGRADE를 보면 아무런 제약조건이 없다.   


ADD CONSTRAINT fk_emp_dept FOREIGN KEY ( deptno ) REFERENCES dept( deptno ) 
ON DELETE NO ACTION ON UPDATE NO ACTION; 


use fisa;
desc emp01;
select * from emp01;
ALTER TABLE emp01 DROP empno NOT NULL; --문법에러
ALTER table emp01 MODIFY empno int NOT NULL;
--2번 같은 값을 넣기
--pk이면 중복도 불가 NULL도 불가
INSERT into emp01 VALUES (1,800,now(),'은채')


-- *** unique ***
-- 5. unique : 고유한 값만 저장 가능, null 허용  
-- UNIQUE는 제약조건을 거는 순간 INDEX(색인)이 들어갑니다

drop Table emp01;
create table emp01(
	empno int NOT NULL,
	ename varchar(10)
);
desc emp01;
INSERT into emp01 VALUES (1,'은채');
select * from emp01; -- 보면 중복된 값도 들어간다.
drop table emp02;
CREATE TABLE emp02 select * from emp01 where 1=0;
DESC emp02;
-- ?? empno 컬럼에 UNIQUE라는 제약조건을 걸기
ALTER table emp02 MODIFY empno int UNIQUE;
INSERT into emp02 VALUES (2,'은채'); --위의 코드로 인해 중복된 값으로 안들어간다.
INSERT into emp02 VALUES (NULL,'은채'); --NULL값도 들어간다
select * from emp02;


-- 6. alter 명령어로 ename에 unique 적용

ALTER Table emp02 add UNIQUE(ename);  --이미 컬럼에도 적용되어야하는데 이미 중복된 값이 들어가있음
DELETE from emp02 WHERE empno is NULL;

ALTER Table emp02 add UNIQUE(ename);  --중복된 값을 없애니 실행됨

DROP TABLE IF EXISTS emp03;

CREATE table emp03 select * from emp02 where 1=0;
desc emp03;
ALTER table emp03 MODIFY empno int PRIMARY KEY;
ALTER table emp03 MODIFY ename VARCHAR(10) UNIQUE;


INSERT into emp03 VALUES(2,NULL);
INSERT into emp03 VALUES(1,'master');
SELECT * from emp03;

-- *** foreign key ***

-- emp table 기반으로 emp04 복제 단 제약조건은 적용되지 않음
-- alter 명령어로 table의 제약조건 추가 


-- *** check ***	
-- 13. check : if 조건식과 같이 저장 직전의 데이터의 유효 유무 검증하는 제약조건 

DROP TABLE IF EXISTS emp05;
CREATE TABLE emp05(
	empno int primary key,
    ename varchar(10) not null,
    age int,
    check (age >0)
);

desc emp05;

insert into emp05 (1, 'master', -3);  --값이 안들어감 check로 인해서
select * from information_schema.TABLE_CONSTRAINTS where table_name='emp05'; 
select * from information_schema.TABLE_CONSTRAINTS where table_name='emp'; -- 다른 테이블 / 다른 컬럼과의 조건
drop table emp05;
CREATE TABLE emp05(
	empno int primary key,
    ename varchar(10) not null,
    age int,
    check (age >0 and age<101)
);--age가 0보다 크고 101보다 작은 값만 들어올수 있음
select * from information_schema.TABLE_CONSTRAINTS where table_name='emp05'; 
select * from information_schema.TABLE_CONSTRAINTS where table_name='emp'; -- 다른 테이블 / 다른 컬럼과의 조건

ALTER table emp05 add check (age>0); --이 방식으로도 가능

-- *** default ***
-- 18. 컬럼에 기본값 자동 설정
-- insert시에 데이터를 저장하지 않아도 자동으로 기본값으로 초기화(저장)
/* java 관점에선 멤버 변수가 있는 클래스를 기반으로 객체 생성시에
 * 자동 초기화 되는 원리와 흡사
 * 단지, table 생성시에 기본 초기값 지정 
 */

DROP TABLE IF EXISTS emp05;
CREATE TABLE emp05(
	empno int primary key,
    ename varchar(10) not null,
    age int default 1 -- 0 
);
desc emp05;   --보면 age의 기본값이 1로 설정되어있다 
SELECT * FROM emp05;
insert into emp05 (empno, ename) VALUES (7, 'master'); -- 자리수 일치해야 값이 들어간다 
-- age 컬럼에 데이터 저장 생략임에도 1이라는 값 자동 저장


-- 20. alter & default
alter table emp05 MODIFY age int DEFAULT 0;  --이미 디폴트값이 1로 설정된 age의 디폴트값을 0으로 변경
desc emp05;
insert into emp05 (empno, ename) VALUES (10, 'king');
SELECT * FROM emp05;

-- 제약조건 한번에 2가지 이상 추가
alter table emp05 MODIFY age int NOT NULL  DEFAULT 0;
insert into emp05 (empno, ename) VALUES (10, 'king');
--NOT NULL조건도 넣어서 이제 이건 안들어감

alter Table emp05 MODIFY ename VARCHAR(20); --제약조건이 아닌 자료형 변경 자료형 변경시에는 제약조건 생략가능

desc emp05;






------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 6.index.sql

/*
1. db의 빠른 검색을 위한 색인 기능의 index 학습
    - primary key에는 기본적으로 자동 index로 설정됨 
    
    - DB 자체적으로 빠른 검색 기능 부여
        이 빠른 검색 기능 - index
    - 어설프게 사용자 정의 index 설정시 오히려 검색 속도 다운
    - 데이터 셋의 15% 이상의 데이터들이 잦은 변경이 이뤄질 경우 index 설정 비추

2. 주의사항
    - index가 반영된 컬럼 데이터가 수시로 변경되는 데이터라면 index 적용은 오히려 부작용
    
3. 문법
    CREATE INDEX index_name
    ON table_name (column1, column2, ...);
*/
-- 클러스터형 인덱스(PK)와 보조 인덱스(UNIQUE)
-- 인덱스는 where절에 많이 사용되는 열에 사용해야 속도가 빠름, 자주사용하는 컬럼에 사용되어야하 가치가 있다.
-- 중복된 데이터가 많은 곳에 하면 성능이 나빠짐, 컬럼의 크기가 너무 커서 저장공간이 인덱스를 추가할때 더 커질때

use fisa;
drop table if exists emp01;
create table emp01 as select * from emp;
desc emp01;
create index idx_emp01_empno on emp01(empno);-- empno로 검색시에 빠른 검색이 가능하게 색인 기능 적용
desc emp01;

-- drop index
alter table emp01 drop index idx_emp01_empno;

-- 코드 참고: <이것이 MYSQL이다>, 한빛출판사, 9장
DROP DATABASE IF EXISTS sqldb;
CREATE DATABASE sqldb;

USE sqldb;
CREATE TABLE usertbl 
( userID  CHAR(8) NOT NULL PRIMARY KEY, 
  name    VARCHAR(10) NOT NULL, 
  birthYear   INT NOT NULL,  
  addr    CHAR(2) NOT NULL,
  mobile1   CHAR(3) NULL, 
  mobile2   CHAR(8) NULL, 
  height    SMALLINT NULL, 
  mDate    DATE NULL 
);
show INDEX from usertbl;
-- <실습 1> --

USE sqldb;
CREATE TABLE  tbl1
    (   a INT PRIMARY KEY,
        b INT,
        c INT
    );

SHOW INDEX FROM tbl1;
/* 
1. Table  테이블명 표기
2. Non_unique  인덱스가 중복된 값이 가능하면 1 중복값이 허용되지 않는 UNIQUE INDEX이면 0을 표시함
3. Key_name  인덱스의 이름을 표시하며 인덱스가 해당 테이블의 기본키라면 PRIMARY로 표시함.
4. Seq_in_index  멀티컬럼이 인덱스인 경우 해당 필드의 순서를 표시함.
5. Column_name  해당 필드의 이름을 표시함.
6. Collation  인덱스에서 해당 필드가 정렬되는 방법을 표시함.
7. Cardinality  인덱스에 저장된 유일한 값들의 수를 표시함.
                (해당 컬럼의 중복된 수치. 중복도가 낮으면 카디널리티가 높다고 표현하고, 중복도가 높으면 카디널리티가 낮다고 표현)
8. Sub_part  인덱스 접두어.
9. Packed  키가 압축되는packed 방법.
10. Null  해당 필드가 NULL을 저장할 수 있으면 YES, 아니면 NO.
11. Index_type  인덱스가 어떤 형태로 구성되어 있는지 나타내며 MySQL은 대부분 B-tree 자료구조를 사용.
12. Comment  해당 필드를 설명하는 것이 아닌 인덱스에 관한 기타 정보.
13. Index_comment  인덱스에 관한 모든 기타 정보를 표시함.
*/



CREATE TABLE  tbl2
    (   a INT PRIMARY KEY, 
        b INT UNIQUE,
        c INT UNIQUE,
        d INT
    );
SHOW INDEX FROM tbl2;

CREATE TABLE  tbl3
    (   a INT UNIQUE,
        b INT UNIQUE,
        c INT UNIQUE,
        d INT
    );

CREATE TABLE  tbl4
    (   a INT UNIQUE NOT NULL,
        b INT UNIQUE,
        c INT UNIQUE,
        d INT
    );
SHOW INDEX FROM tbl4;

CREATE TABLE  tbl5
    (   a INT UNIQUE NOT NULL,
        b INT UNIQUE ,
        c INT UNIQUE,
        d INT PRIMARY KEY
    );
SHOW INDEX FROM tbl5;
CREATE DATABASE IF NOT EXISTS sqldb;
USE sqldb;
DROP TABLE IF EXISTS usertbl;
CREATE TABLE usertbl 
( userID  char(8) NOT NULL PRIMARY KEY, 
  name    varchar(10) NOT NULL,
  birthYear   int NOT NULL,
  addr    nchar(2) NOT NULL 
 );
desc usertbl;
INSERT INTO usertbl VALUES('LSG', '이승기', 1987, '서울');
INSERT INTO usertbl VALUES('KBS', '김범수', 1979, '경남');
INSERT INTO usertbl VALUES('KKH', '김경호', 1971, '전남');
INSERT INTO usertbl VALUES('SSK', '성시경', 1979, '서울');
SELECT * FROM usertbl;

ALTER TABLE usertbl DROP PRIMARY KEY ;
ALTER TABLE usertbl 
    ADD CONSTRAINT pk_name PRIMARY KEY(name);
SELECT * FROM usertbl; --primary key를 바꿔서 name순으로 보여준다.



CREATE DATABASE IF NOT EXISTS sqldb;
USE sqldb;
DROP TABLE IF EXISTS clustertbl;
CREATE TABLE clustertbl -- Cluster Index를 가진 테이블 생성
( userID  CHAR(8) ,
  name    VARCHAR(10) 
);
INSERT INTO clustertbl VALUES('LSG', '이승기');
INSERT INTO clustertbl VALUES('KBS', '김범수');
INSERT INTO clustertbl VALUES('KKH', '김경호');
INSERT INTO clustertbl VALUES('JYP', '조용필');
INSERT INTO clustertbl VALUES('SSK', '성시경');
INSERT INTO clustertbl VALUES('LJB', '임재범');
INSERT INTO clustertbl VALUES('YJS', '윤종신');
INSERT INTO clustertbl VALUES('EJW', '은지원');
INSERT INTO clustertbl VALUES('JKW', '조관우');
INSERT INTO clustertbl VALUES('BBK', '바비킴');

SELECT * FROM clustertbl; -- 입력한 순서대로 값이 들어갑니다
desc clustertbl;



ALTER TABLE clustertbl
    ADD CONSTRAINT PK_clustertbl_userID
        PRIMARY KEY (userID);

SELECT * FROM clustertbl;  -- PK가 걸린 ID의 ABCD 순으로 정렬됩니다 (클러스터 인덱스 설정됨)


DROP TABLE IF EXISTS secondarytbl;
CREATE TABLE secondarytbl -- Secondary Table 약자
( userID  CHAR(8),
  name    VARCHAR(10)
);
INSERT INTO secondarytbl VALUES('LSG', '이승기');
INSERT INTO secondarytbl VALUES('KBS', '김범수');
INSERT INTO secondarytbl VALUES('KKH', '김경호');
INSERT INTO secondarytbl VALUES('JYP', '조용필');
INSERT INTO secondarytbl VALUES('SSK', '성시경');
INSERT INTO secondarytbl VALUES('LJB', '임재범');
INSERT INTO secondarytbl VALUES('YJS', '윤종신');
INSERT INTO secondarytbl VALUES('EJW', '은지원');
INSERT INTO secondarytbl VALUES('JKW', '조관우');
INSERT INTO secondarytbl VALUES('BBK', '바비킴');

ALTER TABLE secondarytbl
    ADD CONSTRAINT UK_secondarytbl_userID
        UNIQUE (userID); -- UNIQUE가 걸리면 보조 인덱스가 자동 생성됩니다

SELECT * FROM secondarytbl; --넣은 순서대로 조회된다.

INSERT INTO clustertbl VALUES('FNT', '푸니타');
INSERT INTO clustertbl VALUES('KAI', '카아이');

INSERT INTO secondarytbl VALUES('FNT', '푸니타');
INSERT INTO secondarytbl VALUES('KAI', '카아이');
SELECT * FROM secondarytbl; --입력한 순서대로

SELECT * FROM clustertbl; --여기는 userid 순서로 조회된다.




DROP TABLE IF EXISTS mixedtbl;
CREATE TABLE mixedtbl
( userID  CHAR(8) NOT NULL ,
  name    VARCHAR(10) NOT NULL,
  addr     char(2)
);
INSERT INTO mixedtbl VALUES('LSG', '이승기', '서울');
INSERT INTO mixedtbl VALUES('KBS', '김범수', '경남');
INSERT INTO mixedtbl VALUES('KKH', '김경호', '전남');
INSERT INTO mixedtbl VALUES('JYP', '조용필',  '경기');
INSERT INTO mixedtbl VALUES('SSK', '성시경', '서울');
INSERT INTO mixedtbl VALUES('LJB', '임재범',  '서울');
INSERT INTO mixedtbl VALUES('YJS', '윤종신',  '경남');
INSERT INTO mixedtbl VALUES('EJW', '은지원', '경북');
INSERT INTO mixedtbl VALUES('JKW', '조관우', '경기');
INSERT INTO mixedtbl VALUES('BBK', '바비킴',  '서울');

SHOW INDEX from mixedtbl; -- 아무것도 안뜸
ALTER TABLE mixedtbl
    ADD CONSTRAINT UK_mixedtbl_name
        UNIQUE (name) ;
SHOW INDEX FROM mixedtbl;  -- 보조키로서 UK_mixedtbl_name가 나온다.
SELECT addr FROM mixedtbl WHERE name = '임재범';  --보조인덱스로 서치

SELECT addr FROM mixedtbl WHERE `userID` = 'LSG'; --클러스터 인덱스.

-- </실습 2> --



-- <실습 3> --
USE sqldb;
SELECT * FROM usertbl;

USE sqldb;
SHOW INDEX FROM usertbl;

SHOW TABLE STATUS LIKE 'usertbl';

CREATE INDEX idx_usertbl_addr 
   ON usertbl (addr);
   
SHOW INDEX FROM usertbl;

SHOW TABLE STATUS LIKE 'usertbl';

ANALYZE TABLE usertbl; -- 최적화를 위한
SHOW TABLE STATUS LIKE 'usertbl';

CREATE UNIQUE INDEX idx_usertbl_birtyYear
    ON usertbl (birthYear);

CREATE UNIQUE INDEX idx_usertbl_name
    ON usertbl (name);

SHOW INDEX FROM usertbl;
desc usertbl;
INSERT INTO usertbl VALUES('GPS', '김범수', 1983, '미국', NULL  , NULL  , 162, NULL);

select * from usertbl;
CREATE INDEX idx_usertbl_name_birthYear
    ON usertbl (name,birthYear);
DROP INDEX idx_usertbl_name ON usertbl;

SHOW INDEX FROM usertbl;

SELECT * FROM usertbl WHERE name = '이승기' and birthYear = '1987';

CREATE INDEX idx_usertbl_mobile1
    ON usertbl (mobile1);

SELECT * FROM usertbl WHERE mobile1 = '011';

SHOW INDEX FROM usertbl;

DROP INDEX idx_usertbl_addr ON usertbl;
DROP INDEX idx_usertbl_name_birthYear ON usertbl;
DROP INDEX idx_usertbl_mobile1 ON usertbl;

ALTER TABLE usertbl DROP INDEX idx_usertbl_addr;
ALTER TABLE usertbl DROP INDEX idx_usertbl_name_birthYear;
ALTER TABLE usertbl DROP INDEX idx_usertbl_mobile1;

ALTER TABLE usertbl DROP PRIMARY KEY;

SELECT table_name, constraint_name
    FROM information_schema.referential_constraints
    WHERE constraint_schema = 'sqldb';

ALTER TABLE buyTbl DROP FOREIGN KEY buytbl_ibfk_1;
ALTER TABLE usertbl DROP PRIMARY KEY;

-- </실습 3> --


-- union

-- 중복 제거: UNION은 기본적으로 중복된 행을 제거합니다. 
-- 모든 행 포함: 중복된 행을 포함하려면 UNION ALL을 사용합니다.
-- 컬럼 수와 데이터 타입: 결합되는 각 SELECT 문은 동일한 수의 컬럼을 가져야 하며, 
-- 각 컬럼의 데이터 타입이 호환되어야 합니다.
-- tbl1 테이블 생성 및 데이터 삽입
DROP TABLE IF EXISTS tbl1, tbl2;
CREATE TABLE tbl1 (col1 INT, col2 VARCHAR(20));

CREATE TABLE tbl2 (col1 INT, col2 VARCHAR(20));

INSERT INTO tbl1 VALUES (1, '가'), (2, '나'), (3, '다');

INSERT INTO tbl2 VALUES (1, 'A'), (2, 'B');

-- tbl1의 모든 데이터 조회
SELECT * FROM tbl1;

-- tbl2의 모든 데이터 조회
SELECT * FROM tbl2;

-- tbl1과 tbl2의 데이터를 UNION으로 결합하여 조회
SELECT col1, col2
FROM tbl1
UNION
SELECT col1, col2
FROM tbl2;

-- UNION ALL : 중복되는 행 포함
SELECT col1, col2
FROM tbl1
UNION ALL
SELECT col1, col2
FROM tbl2;

-- 컬럼의 개수가 맞지 않으면 에러
SELECT col1
FROM tbl1
UNION ALL
SELECT col1, col2
FROM tbl2;

-- 각 컬럼의 데이터 타입이 호환되어야 합니다. 
CREATE TABLE tbl3 AS
SELECT col1
FROM tbl1
UNION ALL
SELECT col2
FROM tbl2;

desc tbl3; --col1은 int col2는 varchar였는데 알아서 1,2를 모두 감을수 있는 형변환을 해서 varchar로 바꿈
select * from tbl3;
EXPLAIN select * from tbl1;  --explain을 쓰면 실행 순서등 알려줌
select * from tbl2;



----------------------------------------------------------------------------------------------------------------------------------------------------
-- 7.view.sql

/*
1. view 
	- 물리적으로는 미 존재, 단 논리적으로 존재
	- 하나 이상의 테이블을 조회한 결과 집합의 독립적인 데이터베이스 객체
	- 논리적(존재하는 table들에 종속적인 가상 table)

2. 개념
	- 보안을 고려해야 하는 table의 특정 컬럼값 은닉
	또는 여러개의 table의 조인된 데이터를 다수 활용을 해야 할 경우
	특정 컬럼 은닉, 다수 table 조인된 결과의 새로운 테이블 자체를 
	가상으로 db내에 생성시킬수 있는 기법 

3. 문법
	- create와 drop : create view/drop view
	- crud는 table과 동일
	
	CREATE VIEW view_name AS
	SELECT column1, column2, ...
	FROM table_name
	WHERE condition;
*/

-- ?? mysql 테이블 복사 -> 원본이 새로 생겨나는 개념
use fisa;
select * from emp;
CREATE VIEW emp_ as SELECT * from emp; --view생성
SELECT * FROM emp_; 
INSERT into emp_ VALUES(9999,'박은채','학생',NULL,now(),1800,NULL,10); --view에도 값 추가 가능
delete from emp_ where empno=9999;


-- ?? mysql 테이블 복사 -> 원본이 새로 생겨나는 개념
create view emp_dept_v as select e.empno,e.ename,d.deptno, d.dname 
from emp e, dept d where d.deptno = e.deptno;
select * from emp_dept_v;
desc emp_dept_v;
insert into emp_dept_v VALUES (111,'박은채',1231231,'호두까기');
-- 두개의 테이블을 가져와서 조인을 했기 때문에 값을 함부로 삽입할수가 없다
DELETE from emp_dept_v where empno = 7934; --심지어 delete도 안됨
-- 목적상 view는 조회용으로만 사용하는 것을 권장합니다.

-- dept table의 SALES라는 데이터를 영업으로 변경 후 view 검색
UPDATE dept set dname="영업" where dname ='SALES';
select * from emp_dept_v; --원본 변경은 view에도 반영이 된다.


-- 2. view 삭제
drop view emp_dept_v;


-- 3. ? emp table에서 comm을 제외한 emp01_v 라는 view 생성
desc emp;
drop view emp01_v;
CREATE view emp01_v as select e.empno,e.ename,e.job,e.mgr,e.hiredate,e.sal,d.dname,d.deptno from emp e, dept d where d.deptno = e.deptno;
SELECT * from emp01_v;

-- ALLEN 이름을 한국어 알렌으로 변경
-- 월급도 100불 올려주시고 확인해보세요.
update emp01_v set ename ='알렌', sal=sal+100 where ename = 'ALLEN';
SELECT * from emp01_v;
insert into  emp01_v values( 7499, 'ALLEN', 'SALESMAN', 7698, STR_TO_DATE('20-2-1981','%d-%m-%Y'), 1600, 30);
--조인한것이기에 삽입 불가


-- 4. dept01_v에 crud : dep01_v와 dept01 table 변화 동시 검색
-- view만 수정해도 원본 table의 데이터가 동기화
-- *** DML은 view에 적용 가능, 원본 table에도 적용 
-- dept01_v에서 50번 부서, '교육', '상암' 
-- emp01_v에다가 여러분의 정보를 넣어주십시오 50번
select * from dept;
create View dept01_v as select * from dept;
select * from dept01_v;
update dept01_v
 set dname = 'SALES' where dname= '영업' ; -- view를 통한 수정이 가능하고 원본또한 달라진다.
INSERT into dept01_v VALUES(50,'교육', '상암');
select * from emp01_v;
INSERT into emp01_v (empno,ename,job,mgr,hiredate,sal,dname,deptno) VALUES(5781,'은채', '학생',1111,now(),10000,'교육','상암');
---위에 꺼 안됨 조인이 된 것에 넣는거 안됨

-- 5. 모든 end user(클라이언트, 실제로 가장 마지막 단에서 데이터를 조회하게 되는 사용자들) 가 
-- 빈번히 사용하는 sql문장으로 "해당 직원의 모든 정보 검색"하기
-- 내 이름이 아니라 다른 직원 정보를 조회할 때도 보여줘야 할 것 같은 정보와
-- 그렇지 않은 정보를 구분해서 관리해보세요 



/* 윈도우 함수 - 익숙해지면 참 좋아요! 
 행과 행 간을 비교, 연산, 정의하기 위한 함수. -- 2019년, 2018년, 2020년 
 분석함수 또는 순위함수라고 부릅니다.
 다른 함수들처럼 중첩해서 사용할 수는 없지만 서브쿼리에서는 사용가능합니다.
 
SELECT WINDOW_FUNCTION(ARGUMENTS) OVER([PARTITION BY 컬럼] [ORDER BY 컬럼] [WINDOWING 절])
FROM 테이블명;

순위 함수:	RANK, DENSE_RANK, ROW_NUMBER	 
   90     1
80 80     2      
   75     4 

3000
2000
1000
1800
1222
4000   3000

일반 집계 함수:	SUM, MAX, MIN, AVG, COUNT	
그룹 내 행 순서 함수: FIRST_VALUE, LAST_VALUE, LAG(뒤쳐진), LEAD
그룹 내 비율 함수:	RATIO_TO_REPROT, PERCENT_RANK, CUME_DIST, NTILE 등
*/
-- 용량이 아주 큰 DB를 만들어야 할 때 
-- PARTITION BY 라는 구문을 이용하면 80년생 이하는 사람은 emp01, 85년생 이하인 사람 emp02 
-- 논리적으로는 하나의 테이블이지만, 공간을 나누어서 저장을 하게 하는 경우도 있습니다 

# 1) RANK
-- ORDER BY를 포함한 쿼리문에서 특정 컬럼의 순위를 구하는 함수
-- PARTITION 내에서 순위를 구할 수도 있고 전체 데이터에 대한 순위를 구할 수도 있다. 
-- 동일한 값에 대해서는 같은 순위를 부여하며 중간 순위를 비운다.
select ename, job,deptno,sal,rank() OVER (PARTITION BY job ORDER BY sal DESC) from emp ;
-- 부서별 인금순위 , 공동 2위가 있으면 다음 순위는 4위가 된다.

/* 2) DENSE_RANK (밀집, 밀도)
1
2 2
3 

RANK와 작동법은 동일, 동일한 값에 대해서는 
같은 순위를 부여하고 중간 순위를 비우지 않는다. 
동일한 값이 있는 경우 순위는 1,1,2,3,3,4*/
select ename, job,deptno,sal,DENSE_RANK() OVER (PARTITION BY job ORDER BY sal DESC) from emp ;



/* 3) ROW_NUMBER
RANK, DENSE_RANK는 동일한 값에 대해 동일 순위를 부여하지만 
ROW_NUMBER은 동일한 값이어도 고유한 순위를 부여한다.
-- 'A1234' 이전에는 -> 1, 2, 3, 4, 5 -> PK를 임의로 만들어줄 때 사용한다 
*/

select ename, job,deptno,sal,ROW_NUMBER() OVER (PARTITION BY job ORDER BY sal DESC) from emp ;

select ename, job,deptno,sal,ROW_NUMBER() OVER (ORDER BY ename) from emp ;
-- 겹치지 않는 번호를 부여해야 할 때, 순위별로 나눌 때도 사용을 하긴 합니다 
-- 순서는 먼저 테이블에 들어간 값이 우선 순위를 부여받습니다 



/* 윈도우 안에서 특정 값을 찾아내는 함수 
1) FIRST_VALUE
파티션별 윈도우에서 가장 먼저 나온 값을 구한다. MIN과 같음.*/
select ename, job,deptno,sal,FIRST_VALUE(sal) OVER (PARTITION BY job ORDER BY sal) from emp ;
/*
2) LAST_VALUE
파티션별 윈도우에서 가장 마지막에 나온 값을 구한다.*/
select ename, job,deptno,sal,LAST_VALUE(sal) OVER (PARTITION BY job ORDER BY sal) from emp ;
/*3) LAG
이전 몇 번째 행의 값을 가져오는 함수. 인자를 최대 3개까지 가진다.
두번째 인자는 몇 번째 앞의 행을 가져올지 결정하는 것이며 DEFAULT값은 1이다. 
세번째 인자는 가져올 행이 없을 경우 DEFAULT값을 지정해준다.
*/
select ename, job,deptno,sal,LAG(sal) OVER (PARTITION BY job ORDER BY sal) from emp ;
/*
4) LEAD
이후 몇 번째 행의 값을 가져오는 함수로 LAG와 마찬가지로 인자를 최대 3개까지 갖는다. */

-- LAG / LEAD : 2번째 인자로는 지금 기준으로 몇개 밀려난 순서에서 값을 가지고 올 것인지를 정해줍니다 
select ename, job,deptno,sal,LEAD(sal,2,0) OVER (PARTITION BY job ORDER BY sal) from emp ;


 -- LAG / LEAD : NULL인 경우 들어갈 디폴트값이 세번째 인자로 



 

/* 4. 그룹 내 비율 함수
-- 백분위 PERCENT_RANK, 누적비율 CUME_DIST, 상위에서 몇번째-NTILE  
*/

-- 최대값 기준으로 현재 행의 값이 몇 퍼센트 백분위인지 

select ename, job,deptno,sal,PERCENT_RANK() OVER (PARTITION BY job ORDER BY sal) from emp ;
-- 부서별로 직원들이 최대임금 대비 몇퍼센트 정도 임금을 받고 있는지
select ename, job,deptno,sal,round(PERCENT_RANK() OVER (PARTITION BY job ORDER BY sal),2) from emp ;

-- 누적비율 CUME_DIST
select ename, job,deptno,sal,round(CUME_DIST() OVER (PARTITION BY job ORDER BY sal),2) from emp ;

-- NTILE : 전체 데이터를 특정 기준으로 N개의 그룹으로 나눌 때 
select ename, job,deptno,sal,NTILE(3) OVER (PARTITION BY job ORDER BY sal) from emp ;
-- 3개의 그룹으로 나눴음, 무조권 3개로 나눠지게 대략적인 분위를 나뉘기에는 좋지만 동점의 경우 문제가 생길수도 있다.
select ename, job,deptno,sal,NTILE(5) OVER (ORDER BY sal) from emp ;




select ename, job,deptno,sal,RANK() OVER (ORDER BY sal) as rn from emp;

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



---------------------------------------------------------------------------------------------------------
/* 
1. 스토어드 프로시저(Stored Procedure)
- SQL에서 프로그래밍이 가능해 주는 서버의 기능
- 자주 사용하는 여러개의 SQL문을 한데 묶어 함수처럼 만들어 일괄적으로 처리하는 용도로 사용됩니다.
- 첫 행과 마지막 행에 구분문자라는 의미의 DELIMITER ~ DELIMITER 문으로 감싼 후 사이에 BEGIN과 END 사이에 SQL문을 넣습니다.
- DELIMITER에는 $$ // && @@ 등의 부호를 구분문자로 많이 사용합니다.
- 위와 같이 작성해놓으면 CALL 프로시저명(); 으로 위의 SQL 묶음을 호출할 수 있습니다.

- 장점
    - 하나의 요청으로 여러 SQL문을 실행 할 수 있습니다.
    - 독립적으로 실행됩니다. SELECT 문이나 다른 SQL 문에서 직접 사용할 수 없습니다.
    - 데이터베이스 상태를 변경할 수 있습니다. INSERT, UPDATE, DELETE 문을 사용할 수 있습니다.
    - 네트워크 소요 시간을 줄일 수 있습니다.
        - 긴 여러개의 쿼리를 SP를 이용해서 구현한다면 SP를 호출할 때
          한 번만 네트워크를 경유하기 때문에 네트워크 소요시간을 줄이고 성능을 개선할 수 있습니다.
    - 개발 업무를 구분해 개발 할 수 있습니다.
        - 순수한 애플리케이션만 개발하는 조직과 DBMS 관련 코드를 개발하는 조직이 따로 있다면,
          DBMS 개발하는 조직에서는 데이터베이스 관련 처리하는 SP를 만들어 API처럼 제공하고 
          애플리케이션 개발자는 SP를 호출해서 사용하는 형식으로 역할을 구분한 개발이 가능합니다.
          
          SHOW PROCEDURE STATUS; -- 프로시저 목록 확인
		  SHOW CREATE PROCEDURE film_not_in_stock; -- 프로시저 내용 확인
		  DROP PROCEDURE 프로시저이름; -- 프로시저 삭제
		  CALL 프로시저이름(변수1, 변수2, 변수3);
*/
SHOW PROCEDURE STATUS;
SHOW CREATE PROCEDURE sakila.film_not_in_stock;


-- OUT 매개변수를 저장할 변수를 선언합니다.
set @count = 0;
-- 저장 프로시저를 호출합니다.
use sakila;
-- 2번 필름에 비디오테이프이 2번 store에 몆개 남아 있는지 @count에 넣어줘라
call film_not_in_stock(2,2,@count);  --인벤토리 ID가 9번

SELECT @count;  -- 1개가 남았다
use fisa;
select * from emp;
select count(hiredate) from emp where year(hiredate) < 1984;
-- 주문취소가 일어나면 -> 주문테이블에서 행하나 삭제 -> 배송 테이블에서도 주문번호로 join한 행 삭제 / 상품의 재고가 취소수량만큼 추가
-- 이 모든것을 하나하나 할수 없기에 procedure로 해결한다.COMMENT
DELIMITER // 
CREATE Procedure employees_hireyear(OUT employee_count int)
Begin
    select count(hiredate) into employee_count from emp where year(hiredate) < 1984;
END // 
DELIMITER;
-- 이거 할때 delimiter 처음부터 끝까지 한번에 잡고 실행해야 함
SET @employee_count = 0;
CALL employees_hireyear(@employee_count);
SELECT @employee_count;
