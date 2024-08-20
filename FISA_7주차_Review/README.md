# 프로젝트 결과

## 1 기능

### 1.1 조회하고 싶은 카드명을 입력하세요

![조회하고 싶은 카드명을 입력하세요](https://prod-files-secure.s3.us-west-2.amazonaws.com/b73784a9-8812-4bde-96a0-8b542d56127e/0f4090a6-4fbf-43f7-acd7-9c74cb66222e/image.png)

[이미지 출처](https://lh7-rt.googleusercontent.com/docsz/AD_4nXeWa8pfSZkcjbuMAFabO3vWOhrg66KopVdivmHwCkLObfVlsnKnOjoGdiJxPcxgJfwTTeQwLv6mLU-D2J2jBgdlrT1yw_IMY73prGu2tvNGk3ayUoUtW0KjIq6enaXMIA3OiLKdlF67a8cd3HAJ8rn0AT4?key=wjCsGPyKErZJj2N-oPdx9Q)

### 1.2 받고 싶은 혜택 키워드를 입력하세요

![받고 싶은 혜택 키워드 입력](https://prod-files-secure.s3.us-west-2.amazonaws.com/b73784a9-8812-4bde-96a0-8b542d56127e/622b8e7a-9077-4b2e-b6f6-3033f8427dd6/image.png)

[이미지 출처](https://lh7-rt.googleusercontent.com/docsz/AD_4nXd0pSjNxZOwzgvgLQ79wl6kPVXECj06BquBAUemnW2RqSLGkSJl_02v1wf407FAR7E-N2PpCN2lbyLj3yUITdKqBj9pPAR1arBYrz3Zee9coDZl_MJjSXyUnIX9UTVDVEwl271mb1S9bjD4NWgM0w0k1IeY?key=wjCsGPyKErZJj2N-oPdx9Q)
[이미지 출처](https://lh7-rt.googleusercontent.com/docsz/AD_4nXd3UuRwJUkcwBcjG6hO8TuUbu__6RYT2B2gzlv-yAxJeDFkuXv4qu71hNCKzgrCb4Kp9E0boLBAw9ZoV5a44vdRV9IWrAHS2ekexiURq_Fhi83pv8688O6JTePnbTGl0_dIQWcdAk1v8nlj3Zenag3b0-tm?key=wjCsGPyKErZJj2N-oPdx9Q)
[이미지 출처](https://lh7-rt.googleusercontent.com/docsz/AD_4nXeeHl_1KA0j1KEdcPEccITChj_4FyIUCbI7oN3tCrBlDfpfNXhAsJoi9_Ur2cjgiR0RYXb89qrweSAP7N_bxkMR_YoGK_1G1QuEmroHBNNjVgzREjfVpG7OA6DnVCIMwG-pcf-OzHkQWRgcoMFAufQe6ndE?key=wjCsGPyKErZJj2N-oPdx9Q)

## 2 문제 해결 (Troubleshooting)

![문제 해결 이미지 1](https://prod-files-secure.s3.us-west-2.amazonaws.com/b73784a9-8812-4bde-96a0-8b542d56127e/b902cb84-9373-47d6-bdb6-0bdf3a8c36a9/image.png)
![문제 해결 이미지 2](https://prod-files-secure.s3.us-west-2.amazonaws.com/b73784a9-8812-4bde-96a0-8b542d56127e/6d1c9660-7018-48d0-a4d5-2814c3aacc72/image.png)

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

## 3 시간이 나면 더 하고 싶은 것

<aside>
💡 [st](http://st.radio).sidebar.radio() 이용
연회비를 `domestic_year_cost` 15,000 이상 이하로 나눠 조회
</aside>

![시간이 나면 더 하고 싶은 것](https://prod-files-secure.s3.us-west-2.amazonaws.com/b73784a9-8812-4bde-96a0-8b542d56127e/75478d4f-28c8-4603-b075-9348ca36aa7c/image.png)
