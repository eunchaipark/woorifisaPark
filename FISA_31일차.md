### **31일차 네줄리뷰 (Four Lines Review)**

- **사실 (Facts):**
  Grok 패턴을 이용한 로그 파싱, Logstash 필터 설정, Elasticsearch 인덱스 템플릿 설정, 그리고 Streamlit을 사용한 웹 애플리케이션 개발에 관한 내용을 다룹니다.

- **발견 (Discovery):**
  Grok 패턴을 통해 비정형 로그 데이터를 정형화된 데이터로 변환하는 방법과 Elasticsearch와의 통합을 통해 실시간 데이터 검색이 가능함을 발견했습니다.

- **배운 점 (Lesson Learned):**
  Grok 패턴의 유연성을 활용하면 다양한 형식의 로그 데이터를 효율적으로 파싱할 수 있으며, Elasticsearch의 인덱스 템플릿과 Streamlit을 활용하여 강력한 데이터 조회 애플리케이션을 개발할 수 있음을 배웠습니다.

- **선언 (Declaration):**
  앞으로 Grok 패턴과 Logstash를 활용한 로그 처리 및 Elasticsearch를 이용한 실시간 데이터 검색 시스템을 더 깊이 탐구하고, 다양한 프로젝트에 이를 적용할 것입니다.

---

### **몰랐던 개념**

- **Grok 패턴:** 로그 데이터를 파싱하고 필요한 필드를 추출하는 데 사용되는 Grok 패턴의 중요성을 재확인했습니다. 다양한 로그 형식에 대해 Grok 패턴을 정의하고 적용하는 능력을 다시 익혔습니다.

- **Elasticsearch 인덱스 템플릿:** 인덱스 템플릿을 통해 여러 유사한 인덱스를 효율적으로 관리할 수 있는 방법을 재발견했습니다.

- **Streamlit과 Elasticsearch의 통합:** Streamlit을 통해 Elasticsearch와 연동된 간단하면서도 강력한 웹 애플리케이션을 구축할 수 있는 방법을 처음 배웠습니다. 이를 통해 실시간 데이터 조회와 사용자 인터페이스 구축이 손쉽게 이루어질 수 있음을 이해했습니다.

- **Logstash mutate 필터:** Logstash에서 mutate 필터를 사용하여 필드를 추가하거나 제거하는 작업을 통해 로그 데이터의 정제 및 변환을 더 효과적으로 수행할 수 있음을 배웠습니다.

### **중요 코드 **

1. **Grok 패턴 예시:**

    ```plaintext
    %{LOGLEVEL:log_level}:     %{IP:client_ip}:%{NUMBER:client_port} - "%{WORD:http_method} %{URIPATH:request_path} HTTP/%{NUMBER:http_version}" %{NUMBER:response_code} %{WORD:status_message}
    ```

    ```json
    {
      "status_message": "OK",
      "client_port": "49290",
      "response_code": "200",
      "http_method": "GET",
      "log_level": "INFO",
      "request_path": "/deposit/12000",
      "http_version": "1.1",
      "client_ip": "127.0.0.1"
    }
    ```

2. **Logstash 필터 설정 예시:**

    ```plaintext
    filter {
        grok {
            match => {"message" => "%{IP:client_ip} - - \[%{GREEDYDATA:timestamp}\] \"%{WORD:http_method} %{URIPATH:request_path} HTTP/%{NUMBER:http_version}\" %{NUMBER:response_code} -"}
            match => {"message" => '%{LOGLEVEL:log_level}:     %{IP:client_ip}:%{NUMBER:client_port} - "%{WORD:http_method} %{URIPATH:request_path} HTTP/%{NUMBER:http_version}" %{NUMBER:response_code} %{WORD:status_message}'}
        }

        mutate {
            add_field => { "description" => "second pipeline!" }
            remove_field => ["host", "@version", "message"]
        }
    }
    ```

3. **Streamlit 코드 예시:**

    ```python
    import streamlit as st
    from elastic_api import search_index

    # 앱 제목과 사이드바 설정
    st.title("엘라스틱서치 인덱스 조회 애플리케이션")
    st.sidebar.header("조회 옵션")
    index_name = st.sidebar.text_input('인덱스명', 'card_info').lower()
    field_name = st.sidebar.text_input('필드명', 'card_name')
    match_name = st.sidebar.text_input('조회 내용', '카드의 정석')

    # 버튼 클릭 시 수행할 작업
    def fetch_card_info():
        response = search_index(index_name, field_name, match_name)
        results = response.to_dict().get("hits", {}).get("hits", [])
        if results:
            return results[0].get("_source", {})
        st.error("해당하는 데이터를 찾을 수 없습니다.")
        return None

    # 각 버튼 클릭에 따라 정보 출력
    if st.sidebar.button("국내 연회비 조회"):
        info = fetch_card_info()
        if info:
            st.write(f"국내 연회비: {info.get('domestic_year_cost', '정보 없음')} 원")

    if st.sidebar.button("해외 연회비 조회"):
        info = fetch_card_info()
        if info:
            st.write(f"해외 연회비: {info.get('abroad_year_cost', '정보 없음')} 원")

    if st.sidebar.button("전월 실적 조건 확인"):
        info = fetch_card_info()
        if info:
            performance = st.sidebar.number_input('전월 실적 (만원)', min_value=0, step=1)
            required_performance = int(info.get('previous_month_performance', 0))
            if performance >= required_performance:
                st.success("조건에 부합합니다.")
            else:
                st.warning("조건에 부합하지 않습니다.")

    if st.sidebar.button("카드 상세 링크"):
        info = fetch_card_info()
        if info:
            st.write(f"[자세한 카드 정보]({info.get('card_link', '#')})")

    if st.sidebar.button("카드 혜택 조회"):
        info = fetch_card_info()
        if info:
            benefits = [entry.get("benefit") for entry in info.get("category", []) if entry.get("benefit")]
            if benefits:
                st.write("카드 혜택:")
                for benefit in benefits:
                    st.write(f"- {benefit}")
            else:
                st.write("혜택 정보가 없습니다.")
    ```
