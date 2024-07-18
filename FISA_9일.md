### **9일차 네줄리뷰(Four Lines Review)** ###
- 사실(Facts): Pandas(판다스)에 대한 전반적인 이해 및 활용
- 발견(Discovery): Pandas에 대한 이해, Pandas function들에 대한 이해
- 배운점(Lesson Learned): DataFrame의 활용, 
- 선언(Daclaration): 여러가지 Numpy function에 대한 이해도 필요하지만 행과 열 또한 차원에 대한 이해가 요구된다.  

### 까먹었다가 배운 개념  ###
# Pandas
- DataFrame에서 특정한 값을 지우면 구조가 무너진다. 그래서 del을 사용할 수 없다.
- df['전화번호'] = ['1','2','3'] 데이터프레임에 데이터 추가
- pd.concat((data,df_og),join = 'inner',axis=0)  #join='inner' 같은 칼럼명만이 출력 . 열을 기준으로 두 데이터를 합친다.
- df4.T.drop_duplicates().T  #열을 기준으로 합쳐진 것을 뒤집고 중복값을 없애고 다시 뒤집는다.
- pd.merge(df5,df5,how='left',on=['Age','Name']) # merge함수
- jjanggu_list.등록일자.astype(str)   #각 원소에 동일한 자료형 적용



### 몰랐던 개념 ###
- df2.to_dict() # dict로 변환
- data2.Sex.replace(['Male','Female'],['M','F'],inplace=True)   #Male -->M Female --> F, inplace=True 를 통해 원본도 바로 바뀐다.
- df.loc, df.iloc 둘다 행을기준으로 검색 근데 두개가 다름 loc는 pandas 방식으로 iloc는 numpy 방식으로
- from datetime import datetime, timedelta   jjanggu_list.등록일자 - timedelta(days=30) #날짜를 30일 전으로 돌리기
- melt 함수에 대한 이해 및 활용
- pivot에대한 이해 및 활용
