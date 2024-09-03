### **17일차 네줄리뷰(Four Lines Review)** ###
- 사실(Facts): 스토어드 프로시저, 데이터베이스 생성 및 테이블 생성, 파티션 테이블, 트리거, ERD
- 발견(Discovery):  파티션 테이블을 사용하면 특정 조건의 데이터를 더 빠르게 조회할 수 있음, 트리거를 사용하여 테이블의 특정 이벤트에 자동으로 작업 수행 가능, ERD를 통해 테이블 간의 관계를 시각적으로 이해할 수 있음
- 배운점(Lesson Learned): 파티션의 다양한 유형과 장단점, 트리거 사용 시 주의점, 스토어드 프로시저의 활용법, ERD의 중요성
- 선언(Daclaration): 파티션과 트리거에 대한 이해가 부족하다고 느낀다. 더욱 공부할 필요성을 느낀다

### 잊었다가 다시 배운 개념  ###
- 프로시저 employees_hireyear: 1984년 이전에 고용된 직원 수를 반환하는 프로시저.
```
DELIMITER //
CREATE PROCEDURE employees_hireyear(OUT employee_count INT)
BEGIN
    SELECT COUNT(hiredate) INTO employee_count 
    FROM emp 
    WHERE YEAR(hiredate) < 1984;
END //
DELIMITER ;

SET @employee_count = 0;
CALL employees_hireyear(@employee_count);
SELECT @employee_count;

```  
- 함수 employees_hireyear: 1984년 이전에 고용된 직원 수를 반환하는 함수.
```
DELIMITER $$
CREATE FUNCTION employees_hireyear() RETURNS INT DETERMINISTIC
BEGIN
    DECLARE employee_count INT;
    SELECT COUNT(*) INTO employee_count 
    FROM emp 
    WHERE hiredate < '1984-01-01 00:00:00';
    RETURN employee_count;
END $$
DELIMITER ;

SELECT employees_hireyear();
SELECT COUNT(*) FROM emp WHERE hiredate > employees_hireyear();
```

- 프로시저 count_men: 남학생 수에 따라 결과를 반환하는 프로시저.
```
DELIMITER //
CREATE PROCEDURE count_men()
BEGIN
    DECLARE count INT;
    SELECT COUNT(*) INTO count FROM students WHERE gender = 'man';
    IF count > 3 THEN
        SELECT 'Many men' AS result;
    ELSE
        SELECT 'Few men' AS result;
    END IF;
END //
DELIMITER ;

CALL count_men();

 ```
 
### 몰랐던 개념 ###
- 트리거
- 주문 삭제 시 백업: 주문 삭제 시 백업 테이블에 데이터 삽입.
```
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
    cancle_date DATETIME,
    quantity INT
);

DROP TRIGGER IF EXISTS backtable_update_trg;
DELIMITER //
CREATE TRIGGER backtable_update_trg AFTER DELETE ON market.orders
FOR EACH ROW
BEGIN
    INSERT INTO backup_order (order_id, customer_id, product_id, order_date, quantity)
    VALUES (OLD.order_id, OLD.customer_id, OLD.product_id, OLD.order_date, OLD.quantity);
END //
DELIMITER ;

DELETE FROM orders WHERE order_id = 2;
SELECT * FROM backup_order;
```

- 학생 관련 데이터 삭제 트리거: 학생 삭제 시 관련 데이터 삭제.
```
USE fisa_erd;

DROP TRIGGER IF EXISTS student_atten_delete_trg;
DELIMITER //
CREATE TRIGGER student_atten_delete_trg AFTER DELETE ON fisa_erd.attendant
FOR EACH ROW
BEGIN
    DELETE FROM fisa_erd.attendant WHERE stud_index = OLD.stud_index;
END //
DELIMITER ;

DROP TRIGGER IF EXISTS class_trg;
DELIMITER //
CREATE TRIGGER class_trg AFTER DELETE ON fisa_erd.student
FOR EACH ROW
BEGIN
    DELETE FROM fisa_erd.student WHERE class_index = OLD.class_index;
END //
DELIMITER ;
```
- ERD (Entity Relationship Diagram) 기반 테이블 생성과 데이터 삽입

```
CREATE DATABASE fisa_erd;
USE fisa_erd;

CREATE TABLE `STUDENT` (
    `stud_index` VARCHAR(20) NOT NULL,
    `class_index` VARCHAR(20) NOT NULL,
    `teach_index` VARCHAR(20) NOT NULL,
    `stud_name` VARCHAR(255) NULL,
    `gender` VARCHAR(255) NULL,
    `age` VARCHAR(255) NULL,
    PRIMARY KEY (`stud_index`, `class_index`, `teach_index`)
);

CREATE TABLE `CLASS` (
    `class_index` VARCHAR(20) NOT NULL,
    `mng_index` VARCHAR(20) NOT NULL,
    `class_name` VARCHAR(255) NULL,
    PRIMARY KEY (`class_index`, `mng_index`)
);

CREATE TABLE `MANAGER` (
    `mng_index` VARCHAR(20) NOT NULL,
    `mng_name` VARCHAR(10) NOT NULL,
    `Field` VARCHAR(255) NULL,
    PRIMARY KEY (`mng_index`)
);

CREATE TABLE `TEACHER` (
    `teach_index` VARCHAR(20) NOT NULL,
    `class_index` VARCHAR(20) NOT NULL,
    `teach_name` VARCHAR(255) NULL,
    PRIMARY KEY (`teach_index`, `class_index`)
);

CREATE TABLE `ATTENDANT` (
    `stud_index` VARCHAR(20) NOT NULL,
    `atten_date` DATE NULL,
    `special` VARCHAR(255) NULL,
    PRIMARY KEY (`stud_index`)
);

CREATE TABLE `STUFF` (
    `stuff_id` VARCHAR(20) NOT NULL,
    `stuff_type` VARCHAR(255) NULL,
    PRIMARY KEY (`stuff_id`)
);

CREATE TABLE `SNACK` (
    `snack_name` VARCHAR(20) NOT NULL,
    `snack_price` VARCHAR(255) NULL,
    PRIMARY KEY (`snack_name`)
);

-- 외래 키 제약 조건 설정
ALTER TABLE `STUDENT` ADD CONSTRAINT `FK_CLASS_TO_STUDENT_1` FOREIGN KEY (`class_index`) REFERENCES `CLASS` (`class_index`) ON DELETE CASCADE;
ALTER TABLE `STUDENT` ADD CONSTRAINT `FK_TEACHER_TO_STUDENT_1` FOREIGN KEY (`teach_index`) REFERENCES `TEACHER` (`teach_index`) ON DELETE CASCADE;
ALTER TABLE `CLASS` ADD CONSTRAINT `FK_MANAGER_TO_CLASS_1` FOREIGN KEY (`mng_index`) REFERENCES `MANAGER` (`mng_index`) ON DELETE CASCADE;
ALTER TABLE `TEACHER` ADD CONSTRAINT `FK_CLASS_TO_TEACHER_1` FOREIGN KEY (`class_index`) REFERENCES `CLASS` (`class_index`) ON DELETE CASCADE;
ALTER TABLE `ATTENDANT` ADD CONSTRAINT `FK_STUDENT_TO_ATTENDANT_1` FOREIGN KEY (`stud_index`) REFERENCES `STUDENT` (`stud_index`) ON DELETE CASCADE;

-- 데이터 삽입
INSERT INTO MANAGER (mng_index, mng_name, Field) VALUES ('M001', 'Manager1', 'Field1');
INSERT INTO CLASS (class_index, mng_index, class_name) VALUES ('C001', 'M001', 'Class1');
INSERT INTO TEACHER (teach_index, class_index, teach_name) VALUES ('T001', 'C001', 'Teacher1');
INSERT INTO STUDENT (stud_index, class_index, teach_index, stud_name, gender, age) VALUES ('S001', 'C001', 'T001', 'Student1', 'Male', '20');
INSERT INTO ATTENDANT (stud_index, atten_date, special) VALUES ('S001', '2023-07-30', 'None');
INSERT INTO STUFF (stuff_id, stuff_type) VALUES ('ST001', 'Type1');
INSERT INTO SNACK (snack_name, snack_price) VALUES ('Snack1', '10');

-- 데이터 삭제 및 확인
DELETE FROM CLASS WHERE class_index = 'C001';

-- 테이블 데이터 확인
SELECT * FROM ATTENDANT;
SELECT * FROM STUDENT;
SELECT * FROM CLASS;
SELECT * FROM TEACHER;
```
