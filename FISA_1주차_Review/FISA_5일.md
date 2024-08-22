### **5일차 네줄리뷰(Four Lines Review)** ###
- 사실(Facts): 복습(함수 사용, 문자열,지역변수-전역변수), Map함수
- 발견(Discovery): 가변인자를 통한 함수사용, (** 가변인자)
- 배운점(Lesson Learned): (** 가변인자), return개념, 메모리의 효율성을 고려한 함수, 모듈, 패키지, filter 함수와 map함수의 차이, Reduce 사용법
- 선언(Daclaration): 가장 자주쓰고 익숙해져야할 함수에 대한 공부의 필요성과 가독성이 좋은 코드를 구성하기 위한 공부의 필요성을 느낀다 


### 까먹었다가 배운 개념  ###
- 가변인자 둘다 사용하기 
- def value(*arg, **kwargs):
  - print(arg, kwargs)
  - return
  - value(1,2,3,4,5, a=1, b=2) --->(1, 2, 3, 4, 5) {'a': 1, 'b': 2}
- 익명함수 (lambda)
- [i for i in range(1,7)] 일반적인 for문보다 시간이 많이 단축된다는 것
- list1 = [i+k for i in num  for k in word ] 재사용을 위해서는 변수에 저장하면 된다는 것

### 몰랐던 개념 ###
- list1= [i for i in range(0,31)]
- def even(x):
  -      if x %2 == 0:
  -        return x
-   list(filter(even, list1)) #c참인것만 출력한다. [2, 4, 6, ...30]
  - list(map(even,list1)) #정의역의 개수만큼 나온다 [0,None,2,None.....28,None]
- enumerate(리스트의 요소를 추출할 때 번호를 붙여서 추출), zip 사용법(두 리스트를 엮어준다, 하지만 리스트의 개수가 적은 리스트가 기준된다.)
