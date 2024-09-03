# 프로젝트 결과

## 1 기능
![image](https://github.com/user-attachments/assets/fca521df-96ea-4e12-8bdb-bab80b727df4)

### 1.1 조회하고 싶은 카드명을 입력하세요

![조회하고 싶은 카드명을 입력하세요]![image](https://github.com/user-attachments/assets/4b67ffb2-01c3-4856-b900-54e5d11860fb)
![image](https://github.com/user-attachments/assets/6b63a44f-0653-4cab-aee4-dd9483b7da5d)


### 1.2 받고 싶은 혜택 키워드를 입력하세요

![image](https://github.com/user-attachments/assets/a1fe3010-7bdd-4853-b77b-ab7e379e5f92)

![image](https://github.com/user-attachments/assets/c84e7212-a969-41ba-b302-77f12d5dc473)

![image](https://github.com/user-attachments/assets/3c12601b-aae0-40ea-ab14-8399d8353c40)



## 2 문제 해결 (Troubleshooting)

![image](https://github.com/user-attachments/assets/833faf36-fa40-4dc5-acc0-884ac62dd595)

![image](https://github.com/user-attachments/assets/2c979fef-f318-4849-8335-8b32cff92e22)


<aside>
💡 **AttributeError: 'AttrDict' object has no attribute 'get'** 오류는 `card_info` 객체가 `dict`가 아니라 `AttrDict` 인스턴스라는 것을 의미합니다. `AttrDict`는 일반적인 파이썬 딕셔너리처럼 동작하지만, 속성 접근 방식(`.`)을 지원하는 객체입니다. `AttrDict`에서 값을 얻으려면 `get` 메서드를 사용할 수 없으므로, `get` 대신 직접 속성 접근 방식을 사용해야 합니다.
여기서는 `card_info` 객체가 `AttrDict` 타입인 경우, 속성을 `get` 메서드 대신 `.`으로 접근해야 합니다. 아래는 이 문제를 해결하는 코드 수정 예제입니다:
</aside>

- **AttrDict Vs 딕셔너리 차이점**
    - **딕셔너리(dict)**: 값을 가져올 때 `dict["키"]`나 `dict.get("키")`를 사용합니다.
    - **AttrDict**: 값을 가져올 때 `attrdict.키`처럼 **`get()` 함수 대신** 점(`.`)을 사용해 값을 가져와야 합니다.

    ### **예시로 이해하기**
    
    1. **딕셔너리 사용**:
        ```python
        data = {"이름": "철수", "나이": 15}
        print(data.get("이름"))  # 철수 출력
        ```

    2. **AttrDict 사용**:
        ```python
        from addict import Dict  # AttrDict와 비슷한 개념의 라이브러리 예시
        
        data = Dict({"이름": "철수", "나이": 15})
        print(data.이름)  # 철수 출력 (get() 대신 .으로 접근)
        ```
        ![image](https://github.com/user-attachments/assets/d3c22eb2-b234-44ed-8d84-a245b84a1bc2)

## 3 시간이 나면 더 하고 싶은 것

<aside>
💡 [st](http://st.radio).sidebar.radio() 이용
연회비를 `domestic_year_cost` 15,000 이상 이하로 나눠 조회
</aside>

![image](https://github.com/user-attachments/assets/7ba54c41-c5c6-4b84-9de0-6dbdc0b69678)

