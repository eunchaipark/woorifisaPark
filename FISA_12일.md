### **11일차 네줄리뷰(Four Lines Review)** ###
- 사실(Facts): streamlit의 이해 및 사용법, 가상프로그램에 대한 이해
- 발견(Discovery): streamlit을 활용한 가상프로그램 사용
- 배운점(Lesson Learned): 가상프로그램을 사용하면 데이터 시각화 프로그램을 배포의 편의성을 가질 수 있음을 알게 되었다. 이 과정에서 git을 사용하면서 편의성을 더욱 올릴수 있었다.
- 선언(Daclaration): git을 활용한 배포를 배웠지만 명확한 이해는 하지 못했다. 추가적인 이해가 필요하다.  

### 결과  ###
- "https://app01-nb8juuyfn5hvl5afrlceqv.streamlit.app "/

### 몰랐던 개념 ###
- streamlit의 문법 및 기능 활용
- 사이드바 만들기 및 버튼 누르기, multi select, slider, 칼럼 구역 나누기(만들기) 등등
- 이전에 배운 데이터 시각화를 통해 주식 데이터를 받아서 가상프로그램 제작하기
  # 실제 사용 예시
```st.title('무슨 주식을 사야 부자가 되려나')
    with st.sidebar:
      st.title('회사 이름과 기간을 입력하세요')
      stock_name = st.text_input('회사이름')
      today = datetime.date.today()
      start_date, end_date = st.date_input(
        'Select a date range',
        value=(today, today + datetime.timedelta(days=7)))
      button_result = st.button('주가데이터 확인') ```
