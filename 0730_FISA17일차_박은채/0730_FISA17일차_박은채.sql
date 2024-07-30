DELIMITER // --DELIMITER //로 procedure의 시작과 끝을 표현한다,구분자로 사용한다.
CREATE Procedure employees_hireyear(OUT employee_count int)  -- 프로시저이름(out 매개변수 자료형)
Begin
    select count(hiredate) into employee_count from emp where year(hiredate) < 1984;
END // 
DELIMITER;
-- 이거 할때 delimiter 처음부터 끝까지 한번에 잡고 실행해야 함
SET @employee_count = 0;
CALL employees_hireyear(@employee_count);
SELECT @employee_count;
-- 여기서는 사실 //로 쓰지만 무엇을 쓰던 상관은 없다 하지만 끝부분과 일치 해야한다.
-------------------------------------------------------------------


DROP DATABASE IF EXISTS student_mgmt;
CREATE DATABASE student_mgmt DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

USE student_mgmt;
DROP TABLE IF EXISTS students;
CREATE TABLE students (
  id TINYINT NOT NULL AUTO_INCREMENT, -- 숫자 자동 생성 하나씩 증가시키면서 생성
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





use student_mgmt;

-- gender가 'man'인 학생들의 수를 세는 스토어드 프로시저 예제
DELIMITER //
CREATE PROCEDURE count_men()
BEGIN
    DECLARE count INT; --지역변수 선언
    SELECT COUNT(*) INTO count FROM students WHERE gender = 'man';
    IF count > 3 THEN
        SELECT 'Many men' AS result;
    ELSE
        SELECT 'Few men' AS result;
    END IF;
END //
DELIMITER ;

select * from students;
call count_men();


--------------------------------------------------------------
USE fisa;

DELIMITER $$

CREATE FUNCTION employees_hireyear()
RETURNS INT 
DETERMINISTIC
BEGIN
	DECLARE employee_count INT;
    
	-- emp 테이블의 hiredate가 1984-01-01 00:00:00 보다 먼저인지 확인해서 개수를 세는 쿼리를 작성해주세요. 
    SELECT COUNT(*) INTO  employee_count
    FROM emp WHERE hiredate < '1984-01-01 00:00:00'; 

	RETURN employee_count;
END $$

-- ; 으로 sql 쿼리문의 마침표를 원복하겠음
DELIMITER ;


-- ?? 함수를 호출하여 결과를 확인합니다.

SELECT employees_hireyear();
select count(*) from emp where hiredate > employees_hireyear();



-----------------------------------------------------------------------------
3. TRIGGER
- 사전적 의미로 '방아쇠'라는 뜻으로, MySQL에서 트리거는 테이블에서 어떤 이벤트가 발생했을 때 자동으로 실행되는 것을 말합니다.
- 즉, 어떤 테이블에서 특정한 이벤트(update, insert, delete)가 발생했을 때, 실행시키고자 하는 추가 쿼리 작업들을 자동으로 수행할 수 있게끔 트리거를 미리 설정해 두는 것입니다. 
- 트리거는 직접 실행시킬 수 없고 오직 해당 테이블에 이벤트가 발생할 경우에만 실행됩니다. 
- DML에만 작동되며, MySQL에서는 VIEW에는 트리거를 사용할 수 없습니다.

CREATE DATABASE market;
USE market;

CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(30),
    email VARCHAR(30)
);

CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(30),
    price DECIMAL(10, 2)
);

CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    order_date DATETIME,
    quantity INT,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

CREATE TABLE backup_order (
    backup_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    customer_id INT,
    product_id INT,
    order_date DATETIME,
    quantity INT
);

INSERT INTO customers (name, email) VALUES 
('김철수', 'chulsoo.kim@example.com'),
('박영희', 'younghee.park@example.com'),
('이민수', 'minsoo.lee@example.com');

INSERT INTO products (name, price) VALUES 
('노트북', 1200.00),
('스마트폰', 800.00),
('헤드폰', 150.00);

INSERT INTO orders (customer_id, product_id, order_date, quantity) VALUES 
(1, 1, '2024-07-21 10:30:00', 1),
(2, 3, '2024-07-21 11:00:00', 2),
(3, 2, '2024-07-21 11:30:00', 1);

-- 주문을 취소할떄 order테이블에서 주문정보가 삭제되면, backup_order

DROP TABLE IF EXISTS backup_order;
CREATE TABLE backup_order
	(backup_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    customer_id INT,
    product_id INT,
    order_date DATETIME,
    cancle_date DATETIME,
    quantity INT);



DROP TRIGGER IF EXISTS test_trg;

DELIMITER // 
CREATE TRIGGER test_trg  -- 트리거 이름
    AFTER DELETE -- 삭제후에 작동하도록 지정
    ON market.orders -- 트리거를 부착할 테이블
    FOR EACH ROW -- 각 행마다 적용시킴
BEGIN
	SET @msg = '주문 정보가 삭제됨' ; -- 트리거 실행시 작동되는 코드들
END // 
DELIMITER ;

SELECT * FROM orders;

DELETE FROM market.orders WHERE order_id=3;

SELECT @msg;
-- database에서 확인할수가 없다 트리거는
-- 테이블 기준으로 테이블에 붙어있는 트리거를 확인하는 명령어
SHOW TRIGGERS LIKE 'orders';
-------------------------------------------------------------------
use market;

DROP TRIGGER IF EXISTS backtable_update_trg;

DELIMITER // 
CREATE TRIGGER backtable_update_trg  -- 트리거 이름
    AFTER DELETE -- 삭제후에 작동하도록 지정
    ON market.orders -- 트리거를 부착할 테이블
    FOR EACH ROW -- 각 행마다 적용시킴
BEGIN
	INSERT INTO backup_order (order_id, customer_id, product_id, order_date, quantity)
    VALUES (OLD.order_id, OLD.customer_id, OLD.product_id, OLD.order_date, OLD.quantity);
	-- OLD / NEW 
END // 

DELIMITER ;

DELETE FROM orders WHERE order_id=2;

SELECT * FROM backup_order;


-- 트리거는 테이블에 몇개라도 부착할 수 있습니다.
SELECT @msg;


----------------------------------------------------------------------
/* 9. Partition
- 특정한 기준을 가지고 논리적으로 나뉘는것
MySQL에서 테이블 파티션은 큰 테이블을 더 작은, 더 관리하기 쉬운 부분으로 나누는 방법입니다. 이를 통해 쿼리 성능을 향상시키고 데이터 관리를 용이하게 할 수 있습니다. 파티션은 물리적으로는 하나의 테이블이지만, 논리적으로는 여러 개의 작은 테이블처럼 동작합니다.

주요 파티션 유형

- RANGE 파티션
    특정 범위의 값을 기준으로 데이터를 분할합니다.
    예: 날짜 범위, 숫자 범위 등.

- LIST 파티션
    특정 값 목록을 기준으로 데이터를 분할합니다.
    예: 특정 지역 코드, 상태 코드 등.

- HASH 파티션
    해시 함수를 사용하여 데이터를 균등하게 분할합니다.
    예: 특정 열의 해시 값을 기준으로 분할.

- KEY 파티션
    MySQL의 내부 해시 함수를 사용하여 데이터를 분할합니다.
    HASH 파티션과 유사하지만, MySQL이 해시 함수를 자동으로 선택합니다.


파티션의 장점
- 성능 향상: 특정 파티션만 스캔하여 쿼리 성능을 향상시킬 수 있습니다.
- 관리 용이성: 데이터 삭제, 백업, 복구 작업이 더 쉬워집니다.
- 병렬 처리: 여러 파티션에서 동시에 작업을 수행할 수 있습니다.

파티션의 단점
- 테이블 설계와 관리가 더 복잡해질 수 있습니다.
  파티션 키를 신중하게 선택해야 하며, 잘못된 선택은 성능 저하를 초래할 수 있습니다. 
- 외래 키제약 조건을 사용할 수 없습니다. 
- 파티션된 테이블의 유지 관리가 더 복잡할 수 있습니다.
- 파티션된 테이블은 인덱스와 메타데이터를 각 파티션마다 유지해야 하므로 디스크 공간 사용이 증가할 수 있습니다.
*/ 
use fisa;
CREATE TABLE emp_p (
    ㅁㄴㅇ PRIMARY ke
    empno INT NOT NULL AUTO_INCREMENT,
    ename VARCHAR(50),
    hiredate DATE,
    PRIMARY KEY (empno, hiredate)
)
PARTITION BY RANGE (YEAR(hiredate)) (
    PARTITION p0 VALUES LESS THAN (1980),
    PARTITION p1 VALUES LESS THAN (1982),
    PARTITION p2 VALUES LESS THAN (1984),
    PARTITION p3 VALUES LESS THAN (1986),
    PARTITION p4 VALUES LESS THAN (1988),
    PARTITION p5 VALUES LESS THAN MAXVALUE  
) 
SELECT empno, ename, hiredate FROM emp;

SHOW CREATE TABLE emp_p;

SELECT 
    PARTITION_NAME, 
    PARTITION_ORDINAL_POSITION, 
    PARTITION_METHOD, 
    PARTITION_EXPRESSION, 
    PARTITION_DESCRIPTION 
FROM 
    INFORMATION_SCHEMA.PARTITIONS 
WHERE 
    TABLE_NAME = 'emp_p' 
    AND TABLE_SCHEMA = 'fisa'; -- 파티션에 대한 간단한 정보

EXPLAIN select * FROM emp;
EXPLAIN select ename from emp WHERE year(hiredate) =1982; --15개의 행을 다 돌아서 찾는다
EXPLAIN select ename from emp_p WHERE year(hiredate) =1982; 
EXPLAIN select * FROM emp_p; --파티션부분이 다르다
-- 실습2
USE fisa;
SELECT years FROM box_office WHERE years BETWEEN 2014 AND 2017;

DROP TABLE IF EXISTS box_office_p;

CREATE TABLE box_office_p AS
SELECT * FROM box_office;


ALTER TABLE box_office_p
    PARTITION BY RANGE(years) (
        PARTITION p0 VALUES LESS THAN (2004),
        PARTITION p1 VALUES LESS THAN (2005),
        PARTITION p2 VALUES LESS THAN (2006),
        PARTITION p3 VALUES LESS THAN (2007),
        PARTITION p4 VALUES LESS THAN (2008),
        PARTITION p5 VALUES LESS THAN (2009),
        PARTITION p6 VALUES LESS THAN (2010),
        PARTITION p7 VALUES LESS THAN (2011),
        PARTITION p8 VALUES LESS THAN (2012),
        PARTITION p9 VALUES LESS THAN (2013),
        PARTITION p10 VALUES LESS THAN (2014),
        PARTITION p11 VALUES LESS THAN (2015),
        PARTITION p12 VALUES LESS THAN (2016),
        PARTITION p13 VALUES LESS THAN (2017),
        PARTITION p14 VALUES LESS THAN (2018),
        PARTITION p15 VALUES LESS THAN (2019),
        PARTITION p16 VALUES LESS THAN (MAXVALUE)  -- Catch-all partition
    );
   
    SELECT years FROM box_office_p WHERE years BETWEEN 2014 AND 2017; --모든 행을 전부 다 돌 필요없이 밑 파티션부터 올라오면서 찾기에 효율적이다

    ------------------------뷰,파티션 프로시저 등등은 데이터를 효과적으로 사용하기 위한 것들이라 이것들을
    -- sql튜닝이라고 한다.



💡 **ERD,** Entity Relationship Diagram

- Entity는 테이블을 뜻합니다.
- 즉, ERD는 **테이블 간의 관계를 다이어그램으로 그려 놓은 것을 말합니다**
    - Entity : 물체, 개념, ***데이터베이스에서 표현하려는 객체***, 테이블을 말한다.
    - Relationship: Entity와 Entity 사이의 관계
    - Attribute: 객체의 속성, 테이블안의 컬럼

ex) 회원가입을 안하면 주문정보를 만들수 없다. 고객 /상품/ 주문정보의 관계를 생각
https://www.erdcloud.com/d/7Y6zDAmWdL8xyfayW --ERD클라우드 연습