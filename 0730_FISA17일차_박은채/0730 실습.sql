CREATE DATABASE fisa_erd;
USE fisa_erd;
CREATE TABLE `STUDENT` (
	`stud_index`	varchar(20) NOT NULL,
	`class_index`	varchar(20) NOT NULL,
	`teach_index`	varchar(20) NOT NULL,
	`stud_name`	VARCHAR(255)	NULL,
	`gender`	VARCHAR(255)	NULL,
	`age`	VARCHAR(255)	NULL
);

CREATE TABLE `CLASS` (
	`class_index`	varchar(20) NOT NULL,
	`mng_index`	varchar(20) NOT NULL,
	`class_name`	VARCHAR(255)	NULL
);

CREATE TABLE `MANAGER` (
	`mng_index`	varchar(20) NOT NULL,
	`mng_name`	VARCHAR(10)	NOT NULL,
	`Field`	VARCHAR(255)	NULL
);

CREATE TABLE `TEACHER` (
	`teach_index`	varchar(20) NOT NULL,
	`class_index`	varchar(20) NOT NULL,
	`teach_name`	VARCHAR(255)	NULL
);

CREATE TABLE `ATTENDANT` (
	`stud_index`	varchar(20) NOT NULL,
	`atten_date`	DATE	NULL,
	`special`	VARCHAR(255)	NULL
);

CREATE TABLE `STUFF` (
	`stuff_id`	varchar(20) NOT NULL,
	`stuff_type`	VARCHAR(255)	NULL
);

CREATE TABLE `SNACK` (
	`snack_name`	varchar(20) NOT NULL,
	`snack_price`	VARCHAR(255)	NULL
);

ALTER TABLE `STUDENT` ADD CONSTRAINT `PK_STUDENT` PRIMARY KEY (
	`stud_index`,
	`class_index`,
	`teach_index`
);

ALTER TABLE `CLASS` ADD CONSTRAINT `PK_CLASS` PRIMARY KEY (
	`class_index`,
	`mng_index`
);

ALTER TABLE `MANAGER` ADD CONSTRAINT `PK_MANAGER` PRIMARY KEY (
	`mng_index`
);

ALTER TABLE `TEACHER` ADD CONSTRAINT `PK_TEACHER` PRIMARY KEY (
	`teach_index`,
	`class_index`
);

ALTER TABLE `ATTENDANT` ADD CONSTRAINT `PK_ATTENDANT` PRIMARY KEY (
	`stud_index`
);

ALTER TABLE `STUFF` ADD CONSTRAINT `PK_STUFF` PRIMARY KEY (
	`stuff_id`
);

ALTER TABLE `SNACK` ADD CONSTRAINT `PK_SNACK` PRIMARY KEY (
	`snack_name`
);

ALTER TABLE `STUDENT` ADD CONSTRAINT `FK_CLASS_TO_STUDENT_1` FOREIGN KEY (
	`class_index`
)
REFERENCES `CLASS` (
	`class_index`
);

ALTER TABLE `STUDENT` ADD CONSTRAINT `FK_TEACHER_TO_STUDENT_1` FOREIGN KEY (
	`teach_index`
)
REFERENCES `TEACHER` (
	`teach_index`
);

ALTER TABLE `CLASS` ADD CONSTRAINT `FK_MANAGER_TO_CLASS_1` FOREIGN KEY (
	`mng_index`
)
REFERENCES `MANAGER` (
	`mng_index`
);

ALTER TABLE `TEACHER` ADD CONSTRAINT `FK_CLASS_TO_TEACHER_1` FOREIGN KEY (
	`class_index`
)
REFERENCES `CLASS` (
	`class_index`
);

ALTER TABLE `ATTENDANT` ADD CONSTRAINT `FK_STUDENT_TO_ATTENDANT_1` FOREIGN KEY (
	`stud_index`
)
REFERENCES `STUDENT` (
	`stud_index`
);
explain SELECT * FROM MANAGER;

use fisa_erd;
DROP TRIGGER IF EXISTS student_atten_delete_trg ;
DELIMITER // 
CREATE TRIGGER student_atten_delete_trg  -- 트리거 이름
    AFTER DELETE -- 삭제후에 작동하도록 지정
    ON fisa_erd.attendant -- 트리거를 부착할 테이블
    FOR EACH ROW -- 각 행마다 적용시킴
BEGIN
    DELETE from fisa_erd.attendant where stud_index = OLD.stud_index;
END // 
DELIMITER ;


DELIMITER //
CREATE TRIGGER class_trg  -- 트리거 이름
    AFTER DELETE -- 삭제후에 작동하도록 지정
    ON fisa_erd.student -- 트리거를 부착할 테이블
    FOR EACH ROW -- 각 행마다 적용시킴
BEGIN
	 DELETE from fisa_erd.student where class_index = OLD.class_index; -- 트리거 실행시 작동되는 코드들
END //
DELIMITER ;

-- 외래 키 제약 조건 제거
ALTER TABLE STUDENT DROP FOREIGN KEY FK_CLASS_TO_STUDENT_1;
ALTER TABLE STUDENT DROP FOREIGN KEY FK_TEACHER_TO_STUDENT_1;
ALTER TABLE CLASS DROP FOREIGN KEY FK_MANAGER_TO_CLASS_1;
ALTER TABLE TEACHER DROP FOREIGN KEY FK_CLASS_TO_TEACHER_1;
ALTER TABLE ATTENDANT DROP FOREIGN KEY FK_STUDENT_TO_ATTENDANT_1;

-- 외래 키 제약 조건 추가 (ON DELETE CASCADE)
ALTER TABLE STUDENT ADD CONSTRAINT FK_CLASS_TO_STUDENT_1 FOREIGN KEY (class_index) REFERENCES CLASS (class_index) ON DELETE CASCADE;
ALTER TABLE STUDENT ADD CONSTRAINT FK_TEACHER_TO_STUDENT_1 FOREIGN KEY (teach_index) REFERENCES TEACHER (teach_index) ON DELETE CASCADE;
ALTER TABLE CLASS ADD CONSTRAINT FK_MANAGER_TO_CLASS_1 FOREIGN KEY (mng_index) REFERENCES MANAGER (mng_index) ON DELETE CASCADE;
ALTER TABLE TEACHER ADD CONSTRAINT FK_CLASS_TO_TEACHER_1 FOREIGN KEY (class_index) REFERENCES CLASS (class_index) ON DELETE CASCADE;
ALTER TABLE ATTENDANT ADD CONSTRAINT FK_STUDENT_TO_ATTENDANT_1 FOREIGN KEY (stud_index) REFERENCES STUDENT (stud_index) ON DELETE CASCADE;

-- 기존 트리거 삭제
DROP TRIGGER IF EXISTS student_atten_delete_trg;
DROP TRIGGER IF EXISTS class_trg;

-- 데이터 삽입
INSERT INTO MANAGER (mng_index, mng_name, Field) VALUES ('M001', 'Manager1', 'Field1');

INSERT INTO CLASS (class_index, mng_index, class_name) VALUES ('C001', 'M001', 'Class1');

INSERT INTO TEACHER (teach_index, class_index, teach_name) VALUES ('T001', 'C001', 'Teacher1');

INSERT INTO STUDENT (stud_index, class_index, teach_index, stud_name, gender, age) VALUES 
('S001', 'C001', 'T001', 'Student1', 'Male', '20');

INSERT INTO ATTENDANT (stud_index, atten_date, special) VALUES 
('S001', '2023-07-30', 'None');

INSERT INTO STUFF (stuff_id, stuff_type) VALUES ('ST001', 'Type1');

INSERT INTO SNACK (snack_name, snack_price) VALUES ('Snack1', '10');

-- 데이터 삭제
DELETE FROM CLASS WHERE class_index = 'C001';

-- 테이블 데이터 확인
SELECT * FROM ATTENDANT;
SELECT * FROM STUDENT;
SELECT * FROM CLASS;
SELECT * FROM TEACHER;

