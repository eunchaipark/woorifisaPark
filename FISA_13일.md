### **11일차 네줄리뷰(Four Lines Review)** ###
- 사실(Facts): SQL에 대한 이해, vscode에서 mysql 연동, (비)정형데이터에 대한 이해
- 발견(Discovery): SQL문 구조에 대한 이해, SQL에서 사용하는 데이터타입, 자료형의 세분화
- 배운점(Lesson Learned): 다양한 쿼리문의 대한 이해, sql에서 데이터타입, 인간의 문법과 가장 닮아 있는 문법이다. 자료형의 세분화의 이유, mysql에서 sql을 할 수 있지만 vscode를 연동함으로써 편의성을 더했다.
- 선언(Daclaration): 알고 있었으나 까먹은 쿼리문과 문법이 많다.  

### 잊었다가 다시 배운 개념  ###
- 테이블의 제약조건 중 외래키 제약조건
- 테이블의 제약 조건중 DEFAULT
- where 절과 having 절의 사용 차이
```
select gender, AVG(math),COUNT(math),SUM(math) from student_mgmt.students GROUP BY gender;
-- 원본을 가지고 연산한 값을 보여준다.
select gender, AVG(math),COUNT(math),SUM(math) from student_mgmt.students GROUP BY gender ORDER BY AVG(math);

select gender, AVG(math),COUNT(math),SUM(math) from student_mgmt.students  GROUP BY gender HAVING AVG(math) >60
--where절은 원본에 대한 것인데 group by는 원본을 사용해서 연산한 값이다. 이떄 HAVING절을 사용한다.

SELECT COUNT(*) from box_office;

--고유한 값을 골라낼떄 DISTINCT를 사용한다.
SELECT COUNT(DISTINCT movie_name) from box_office;
 ```
  
### 몰랐던 개념 ###
- charset(문자 집합) : 이모지의 등장이후 4바이트 문자열을 utf에 저장하고자하면 값이 손실되기에 MySQL은 버전 5.5.3부터 utf8mb4라는 문자 집합을 도입했습니다.
- Collation : 텍스트 데이터를 정렬(ORDER BY)할 때 사용합니다. 즉 text계열 자료형에서만 사용 할수 있는 속성
    - utf8_general_ci (or utf8mb4_general_ci): 텍스트 정렬할 때 a 다음에 b 가 나타나야 한다는 생각으로 나온 정렬방식. 문자열 자체의 오름차순을 사용합니다.
    - utf8_unicode_ci (or utf8mb4_unicode_ci) : general_ci 보다 조금 더 사람의 기준에 맞게 여러 특수문자를 정렬합니다.
