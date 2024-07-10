### **2일차 네줄리뷰(Four Lines Review)** ###
- 사실(Facts): 제어문(조건문, 반복문) (if문/match~ case문)
- 발견(Discovery): 조건문, 반복문의 기본적인 개념 및 형태와 그에 따른 들여쓰기의 중요성, input(사용자로부터 입력받기)의 개념
- 배운점(Lesson Learned): 결국 조건문과 반복문의 활용, 그에 따라 사용할수 있는 간편한 함수들, 딕셔너리를 조건문을 통해 수정하는 것
- 선언(Daclaration): 조건문과 반복문은 정말 많이 사용하게 되는데 아직 익숙하지 못한 점이 보인다. 많이 사용하지 않은 딕셔너리가 특히 조건문과 함께 사용할때 버벅거리게 되는데 이를 집중적으로 공부해야 함의 필요성을 느낀다. 


### 까먹었다가 배운 개념  ###
- input을 하게 될시 str형태 int로 사용하고 싶으면 형변환을 해줘야한다.
- 이터레이블의 개념
- 딕셔너리에 순서가 존재하지 않기에 튜플과 다른 방식으로 수정해야함을 다시 배움
- sale1에 있는 제품들의 가격을 모두 20할인해서 넣어서 출력해라
- - import copy
- - sale1 = { '연필' : [500, 300], '공책': [1200, 2100], '신발':[58000, 2121000]}
- - sale2 = copy.deepcopy(sale1)
- - for k in sale1.keys():
- - for i in range(len(sale1[k])):   
- - sale1[k][i] = int(sale1[k][i] *0.8)
- - print(sale1)



### 몰랐던 개념 ###
- :=(바다코끼리 연산자) 할당하는 것과 동시에 사용하는 연산 , while(i := i+1): ~~~ 이렇게 사용
- li=[] # 빈리스트 생성
-  for i in range(10):
-       if i==0:
          start=i # start에 초기값 할당
      if i==9:
          end=i # end에 마지막값 할당
      li.append(i) # 차례대로 리스트에 삽입
-  print(li) # 리스트 출력
-  print(start,end) # start, end 출력
  
## 리스트를 만듬과 동시에 i가 0일때 start에 0을 넣어주고, end에 값을 계속 넣어 마지막값역시 end에 할당
  - li = [(end:=i) if i else (start:=i) for i in range(10)]
  - print(li) # 리스트 출력
  - print(start, end) # start, end 출력
