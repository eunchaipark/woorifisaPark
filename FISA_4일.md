### **4일차 네줄리뷰(Four Lines Review)** ###
- 사실(Facts): 함수, 문자열 출력
- 발견(Discovery): 함수의 개념(반환이 있는 함수),함수 호출구조, 재귀함수, 익명함수, 함수형 문법
- 배운점(Lesson Learned): 가변인자의 개념, Map을 사용하여 메모리 효율적 사용, 문자열 메소드, 정규식
- 선언(Daclaration): 가장 자주쓰고 익숙해져야할 함수에 대한 공부의 필요성과 가독성이 좋은 코드를 구성하기 위한 공부의 필요성을 느낀다 


### 까먹었다가 배운 개념  ###
- 자주 사용되는 문자열 메소드
  - split() #문자열.split(t,n) #문자열에서 t 기준으로 n만큼 분리한 문자열 리스트를 반환해주세요
  - replace()    #replace 문자열 치환
  - strip()  #strip 문자열의 앞뒤에 존재하는 (화이트 스페이스)를 전부제거 #문자열의 중간에 있는 화이트 스페이스는 제거되지 않는다.
  - join()  #특정한 문자를앞뒤로 문자열들을 붙이기
  - format()  # format() 메소드는 문자열을 구성하는 데 사용되며, 지정된 형식에 맞게 값을 포맷하거나 출력하는 데 사용됩니다.
  - - name = "John"
  - - age = 30
  - - print("My name is {} and I'm {} years old.".format(name, age))


### 몰랐던 개념 ###
- 가변인자 (입력값이 몆개인지 정해져 있지 않는 경우)
- def 함수명(*인자): 실행문
- 파이썬에서 가변인자(패킹)은 튜플로 묶어서 전달이 되는구나
 변수이름을 key로 하는 딕셔너리 형태로 묶어서 전달되기 때문입니다.
- 가변인자(*args)와 키워드 가변인자(**kwargs)를 함께 사용할 수도 있습니다. 이 경우, 위치 인자와 키워드 인자를 모두 전달할 수 있습니다.
- def print_info(**kwargs):
-     for key, value in kwargs.items():
-         print(key + ":" + value)
- print_info(name="John", age="30", city="Seoul")
