
/*
123123
*/  
--  1부터 순서가 시작된다. 명령어는 대문자, DB/컬럼명/함수 등은 소문자로 작성
-- 리눅스에서는 대/소 문자  
-- 주로 세가지를 사용하게 되는데 데이터 정의어
SELECT *from sakila.actor;
SELECT COUNT(*) FROM sakila.actor;   --CTRL + enter 현재 커서가 있는 쿼리문만 돌아감
-- CTRL + enter +shift 현재 파일에 있는 모든 쿼리문 가동
CREATE DATABASE fisa;  --DB생성, CRTL+B는 쿼리를 보기 좋게 정렬
CREATE table hello(컬럼이름 자료형 제약조건,컬럼이름2 자료형2 제약조건2);   --RDBMS 정형 데이터 컬럼에 대한 상세 내용까지 적어줘야함

CREATE Table fisa.hello
    (name VARCHAR(20) not NULL
    ,age INT);

DROP Table if EXISTS fisa.hello;  --FISA에 HELLO가 있으면 떨구고 없으면 경고메시지만

DROP DATABASE fisa;
--만약에 있으면 fisa DB를 그대로 두고 없으면 만들어주세요
CREATE DATABASE IF NOT EXISTS fisa;

USE fisa;  --특정 위치로 커서를 가져간다
use sakila;

SHOW TABLES;
SHOW DATABASES;

CREATE DATABASE if NOT EXISTS second_line;
use second_line;
drop Table t1;

CREATE TABLE if NOT EXISTS t1 
( 
 st_id VARCHAR(50), 
 st_name VARCHAR(100), 
 st_grade INT,
 st_class VARCHAR(10),
 st_sex VARCHAR(10),
 st_age INT,
 st_admission_date DATE
);
INSERT INTO t1 (st_name) VALUES('park')

DROP DATABASE IF EXISTS student_mgmt;
CREATE DATABASE student_mgmt DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
--- charset
--- collastion : 텍스트 데이터를 정렬할때 사용한다, utf8mb4_unicode_ci : 오름차순뿐만이 아니라 사람의 기준에 맞게 여러특수문자까지 정렬한다.


USE student_mgmt;
DROP TABLE IF EXISTS students;
CREATE TABLE students (
  id TINYINT NOT NULL AUTO_INCREMENT, -- 숫자 자동 생성
  name VARCHAR(10) NOT NULL, 
  gender ENUM('man','woman') NOT NULL,
  birth DATE NOT NULL,
  english TINYINT NOT NULL,
  math TINYINT NOT NULL,
  korean TINYINT NOT NULL,
  PRIMARY KEY (id) -- 기본키
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO students (name, gender, birth, english, math, korean) VALUES ('dave', 'man', '1983-07-16', 90, 80, 71);
INSERT INTO students (name, gender, birth, english, math, korean) VALUES ('minsun', 'woman', '1982-10-16', 30, 88, 60);
INSERT INTO students (name, gender, birth, english, math, korean) VALUES ('david', 'man', '1982-12-10', 78, 77, 30);
INSERT INTO students (name, gender, birth, english, math, korean) VALUES ('jade', 'man', '1979-11-1', 45, 66, 20);
INSERT INTO students (name, gender, birth, english, math, korean) VALUES ('jane', 'man', '1990-11-12', 65, 32, 90);
INSERT INTO students (name, gender, birth, english, math, korean) VALUES ('wage', 'woman', '1982-1-13', 76, 30, 80);
INSERT INTO students (name, gender, birth, english, math, korean) VALUES ('tina', 'woman', '1982-12-3', 87, 62, 71);



--------------------------------------------------------------------------------------------------------------------



-- box_office 테이블 생성 
create table box_office (
     seq_no          INT PRIMARY KEY,
     years           SMALLINT,
     ranks           INT,
     movie_name      VARCHAR(200),
     release_date    DATETIME,
     sale_amt        DOUBLE,
     share_rate      DOUBLE,
     audience_num    INT,
     screen_num      SMALLINT,
     showing_count   INT,
     rep_country     VARCHAR(50),
     countries       VARCHAR(100),
     distributor     VARCHAR(300),
     movie_type      VARCHAR(100),
     genre           VARCHAR(100),
     director        VARCHAR(1000)
);

select *from sakila.actor;
select *from box_office;


select seq_no,years from box_office where years=2004;
select count(years) from box_office where years=2004 between 2004 and 2005;
select count(years) from box_office where 2004 <= years and years <= 2005;
select count(years) from box_office where 2004 <= years && years <= 2005;

-- LIKE :일부 일치 탐색. % 는 0개 이상의 모든 숫자 / _ 는 한 개당 한 글자
SELECT movie_name FROM student_mgmt.box_office WHERE movie_name LIKE '천년';
SELECT movie_name FROM student_mgmt.box_office WHERE movie_name LIKE '%천년'; -- 천년으로 끝나는
SELECT movie_name FROM student_mgmt.box_officee WHERE movie_name LIKE '천년%'; -- 천년으로 시작하는
SELECT movie_name FROM student_mgmt.box_office WHERE movie_name LIKE '%천년%'; -- 천년이라는 문자열이 들어가는 

SELECT movie_name FROM student_mgmt.box_office WHERE movie_name LIKE '천년_'; -- 천년+한글자
SELECT movie_name FROM student_mgmt.box_office WHERE movie_name LIKE '%천년_'; -- 몇글자 + 천년 + 한글자

SELECT years,movie_name FROM student_mgmt.box_office WHERE movie_name LIKE '%여우%';

SELECT COUNT(*) FROM student_mgmt.box_office WHERE release_date LIKE '2018%' AND audience_num >= 5000000;
select years,movie_name from student_mgmt.box_office  where years = 2018;
select years,movie_name from student_mgmt.box_office  where  audience_num >= 5000000;
select years,movie_name from student_mgmt.box_office  where  years = 2019 and (audience_num >= 5000000 or sale_amt >= 40000000000);
select years,movie_name from student_mgmt.box_office  where  years = 2012 and release_date = 2019;

SELECT * from student_mgmt.box_office WHERE release_date LIKE '2018%' ORDER BY seq_no;    ---order by 정렬하기 기본적으로는 오름차순으로 정렬한다.


SELECT * from student_mgmt.box_office WHERE release_date LIKE '2018%' ORDER BY seq_no,years DESC;

SELECT * from student_mgmt.box_office WHERE release_date LIKE '2018%' ORDER BY 5,1;   --select절에 선택된 컬럼의 기재 순서대로 1부터 넘버링


SELECT * from student_mgmt.box_office WHERE release_date LIKE '2018%' AND audience_num >= 5000000 ORDER BY sale_amt,ranks

-- 2019년 개봉하고 500만 명 이상의 관객을 동원한 매출액 기준 상위 5편의 영화만 조회
SELECT * from student_mgmt.box_office WHERE release_date LIKE '2018%' AND audience_num >= 5000000 ORDER BY sale_amt DESC LIMIT 5


select * from student_mgmt.box_office WHERE years LIKE '2019%' ORDER BY audience_num DESC LIMIT 10;

select COUNT(*) from student_mgmt.box_office WHERE years LIKE '2019%' AND movie_type NOT LIKE '장편' ORDER BY ranks asc;
select COUNT(*) from student_mgmt.box_office WHERE years LIKE '2019%' AND movie_type != '장편' ORDER BY ranks asc;



USE student_mgmt;
DROP TABLE IF EXISTS students;
CREATE TABLE students (
  id TINYINT NOT NULL AUTO_INCREMENT,
  name VARCHAR(10) NOT NULL,
  gender ENUM('man','woman') NOT NULL,
  birth DATE NOT NULL,
  english TINYINT NOT NULL,
  math TINYINT NOT NULL,
  korean TINYINT NOT NULL,
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO students (name, gender, birth, english, math, korean) VALUES ('dave', 'man', '1983-07-16', 90, 80, 71);
INSERT INTO students (name, gender, birth, english, math, korean) VALUES ('minsun', 'woman', '1982-10-16', 30, 88, 60);
INSERT INTO students (name, gender, birth, english, math, korean) VALUES ('david', 'man', '1982-12-10', 78, 77, 30);
INSERT INTO students (name, gender, birth, english, math, korean) VALUES ('jade', 'man', '1979-11-1', 45, 66, 20);
INSERT INTO students (name, gender, birth, english, math, korean) VALUES ('jane', 'man', '1990-11-12', 65, 32, 90);
INSERT INTO students (name, gender, birth, english, math, korean) VALUES ('wage', 'woman', '1982-1-13', 76, 30, 80);
INSERT INTO students (name, gender, birth, english, math, korean) VALUES ('tina', 'woman', '1982-12-3', 87, 62, 71);



select gender, count(math) from student_mgmt.students GROUP BY gender;  --성별로 구분을 해서 count를 써서 집계를 해
select gender, AVG(math),COUNT(math),SUM(math) from student_mgmt.students GROUP BY gender;
-- 원본을 가지고 연산한 값을 보여준다.
select gender, AVG(math),COUNT(math),SUM(math) from student_mgmt.students GROUP BY gender ORDER BY AVG(math);

select gender, AVG(math),COUNT(math),SUM(math) from student_mgmt.students  GROUP BY gender HAVING AVG(math) >60
--where절은 원본에 대한 것인데 group by는 원본을 사용해서 연산한 값이다. 이떄 HAVING절을 사용한다.

SELECT COUNT(*) from box_office;

--고유한 값을 골라낼떄 DISTINCT를 사용한다.
SELECT COUNT(DISTINCT movie_name) from box_office;


