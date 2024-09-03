### **11일차 네줄리뷰(Four Lines Review)** ###
- 사실(Facts): 질적변수, 양적변수에 따른 다양한 데이터 시각화
- 발견(Discovery): seaborn을 통한 데이터 시각화, Ploty를 통한 데이터 시각화
- 배운점(Lesson Learned): 변수에 따른 데이터 시각화 방법 : Scatter Plot, Count Plot, Displot, Voilin Plot, Pair Plot, Ploty에서 scatter_matrix
- 선언(Daclaration): 데이터 시각화에 대한 많은 방법에 대한 연습 필요 

### 까먹었다가 배운 개념  ###
# Matplotlib
- Displot : 전체에서의 각 데이터의 비율을 보여준다(데이터의 합을 1로 본다)
- Pie Charts : 원형 그래프라고 불리운다. 자주 사용하지 않아서 까먹었었다.
- Subplotting using Subplot2grid : 여러개의 그래프를 한번에 보기 위한 표현방식, 큰 도화지에 구역을 나눠서 각 구역에 다른 그래프를 그리는 것. 즉 상관관계가 있는 그래프들이 끼리 모이면 좋다.
- barplot: Matplotlib에서 사용한 plt.bar와는 다른 문법을 사용한다.
- px.violin(iris,x='species',y= 'sepal_length',color='species',points='all',box=True)  #바이올린 플롯에서 box plot도 뜨고 산점도도 표시한다.

### 몰랐던 개념 ###
- Ploty를 통한 데이터 시각화
- ploty를 사용하면서 쓸 내장함수들(color = 색상구분 기준이 될 컬렴명, hover_name= # 팝업 데이터 최상단에 데이터프레임 컬럼명)
- facet_col = #그래프를 나눌 기준이 될 컬럼명 입력
- facet_col_wrap=2  # 한 행에 2개의 그래프를 보여준다.
- range_x=['2020-07-22','2024-07-22']  #x축의 시작과 끝을 정할수 있다 이 경우는 날짜로 시작과 끝을 정했다.
- fig = px.bar(df1, x='product', y='price', color='store', barmode='group',text='quantity',facet_col='store')
- fig.show()  #barmode -->각 제품별로 바를 따로 생성
- #text- --> 사용해서 바에 제품양을 넣는다.
- #fac_col 칼럼별로 분리
- px.histogram(tips,x='sex',y='total_bill',color='sex',barmode='group',facet_col='time',histfunc='count')  #histfunc의 기본값은 sum인데 count, avg등 바꿀수 있다.
- fig = px.histogram(tips, x='total_bill', y='tip', color='sex', marginal='box') # BOX형으로 위에 전체분포를 보여준다.
