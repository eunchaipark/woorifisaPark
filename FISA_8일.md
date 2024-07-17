### **8일차 네줄리뷰(Four Lines Review)** ###
- 사실(Facts): Numpy에 대한 전반적인 이해 및 활용
- 발견(Discovery): Numpy배열에 대한 이해, Numpy function들에 대한 이해
- 배운점(Lesson Learned): 브로드캐스팅을 통해 간편한 배열 활용에 대한 이해
- 선언(Daclaration): 여러가지 Numpy function에 대한 이해도 필요하지만 행과 열 또한 차원에 대한 이해가 요구된다.  

### 까먹었다가 배운 개념  ###
# Numpy function들
- np.array([[1,2,3,4],[5,6,7,8]], dtype ='int8') ,배열 생성 ,dtype= 을 통한 형변환
- ndarray = np.arange(15,26,5) : np.arange를 통해 배열 생성, 파이썬의 range와 거의 동일
- np.append(ndarray2,[[9,10,11,12]],axis = 1) #axis=0 가로축 axis =1은 세로축, 배열 추가
- wrong_example=np.array([[ 1,  2,  3,  4],[ 5,  6,  7,None]])
- #None이 없을떄 inhomogeneous 동질하지 않은 모양을 가지고 있어서 만들어지지 않는다. 따라서 이럴떄는 None으로 채워넣는다
- random에 대한 활용 (1.np.random.choice(a,4) #무작위로 선택, 중복도 가능, 복원추출방식)(2.np.random.seed(42) 같은 코드(셀) 내에서만 seed값으로 인해 출력값이 같아진다.)
- (3.np.random.randint(10,20,(3,9))  #10에서 20사이에서 3행 9열로 뽑는다.).
- x.max() --> 배열에서 최대값을 뽑고 , x.argmax() --> 배열에서 최대값의 위치를 뽑는다.

### 몰랐던 개념 ###
- ndarray2.cumsum() #누적합 함수
- ndarray2.argmax(axis = 0) #가장 큰 값이 들어있는 방번호
- c = np.array([[1,2],[3,4]],'uint')  #uint는 양수만 받는 정수형이다.
- np.zeros(ones)((1,4)) #모든 요소는 0(1)이 되고 1개의행, 4개의 열을 가진 배열
- np.average(a,weights=[2,1,1,0,0])   #가중평균도 가능해진다 # a에 0번방에 2를 곱하고 1번방에 1을 곱하고 이런식으로 간다음에 다 더해서 총 가중치 2+1+1+0+0 을 해서 4로 나눈다.
- np.where(a>3,3,0) # where(조건, 참일떄 들어갈 값, 거짓일때 들어갈 값)
- k=a[:3,(0,1,),:3].flatten() #구조를 무너뜨려 1차원으로 평탄화
- b.reshape(3,6) #3행 6열로 구조화
- np.concatenate((d,[[16,17,18]]),axis =0) #concatenate(변수이름, 넣을거, 기준axis =0---> 행기준)
- np.save('a.npy',d) #.npy 라는 바이너리 파일로 연산한 데이터를 저장할수 있다.  y = np.load('a.npy')  #저장된 바이너리 파일 불러오기 
