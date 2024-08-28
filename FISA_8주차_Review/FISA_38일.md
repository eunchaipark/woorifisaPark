### **38일차 네줄리뷰 (Four Lines Review)**

- **사실 (Facts):**
  - `django-admin startapp account` 명령어를 사용하여 Django 프로젝트에 새로운 앱을 생성할 수 있습니다. 이 명령어는 `account`라는 이름의 디렉토리와 기본 파일들을 자동으로 생성합니다.
  - 로그인 기능 구현을 위해 `views.py`, `forms.py`, `login.html` 파일을 사용하여 사용자 인증과 관련된 로직을 작성했습니다.
  - 로그인 요청 처리는 주로 `POST` 요청을 통해 이루어지며, 폼 유효성 검사 및 사용자 인증을 거쳐 결과를 반환합니다.
    ```python
    if request.method == 'POST':
        form = LoginForm(request.POST)
        if form.is_valid():
            user = authenticate(request, username=cd['username'], password=cd['password'])
            # 인증 로직
    ```
  - `request.method`를 `GET`으로 변경할 경우 보안 문제 및 잘못된 HTTP 메소드 사용으로 인해 문제가 발생할 수 있습니다.

- **발견 (Discovery):**
  - Django의 `POST` 요청은 민감한 데이터를 안전하게 서버로 전송하는 데 적합하며, `GET` 요청은 주로 데이터를 조회할 때 사용되어야 한다는 것을 알게 되었습니다.
  - 로그인과 같은 인증 작업은 반드시 `POST` 요청을 통해 처리해야 하는 이유와 그 중요성을 발견했습니다.

- **배운점 (Lesson Learned):**
  - Django에서의 앱 생성과 로그인 기능 구현을 위한 파일 간의 연관성을 이해했습니다. 각 파일의 역할을 명확히 알게 되었고, 특히 `views.py`에서의 요청 처리 방식이 중요함을 배웠습니다.
  - `GET` 요청과 `POST` 요청의 차이점과, 잘못된 메소드 사용 시 발생할 수 있는 보안 문제를 배웠습니다.
    ```python
    if request.method == 'GET':
        form = LoginForm(request.GET)  # GET 요청으로 처리할 경우 발생할 수 있는 문제
    ```

- **선언 (Declaration):**
  - 앞으로 Django 프로젝트에서 로그인 기능을 구현할 때는 `POST` 요청을 올바르게 사용하여, 사용자 데이터가 안전하게 처리되도록 하겠습니다. 또한, 앱 생성 시 기본적으로 생성되는 파일들의 역할을 정확히 이해하고, 적절하게 활용하겠습니다.

### **잊었다가 다시 배운 개념**

- Django의 `POST`와 `GET` 요청의 차이점과 그 각각의 용도.
- `django-admin startapp` 명령어를 통해 생성되는 디렉토리 구조와 각 파일의 역할.

### **몰랐던 개념**

- `request.method == 'GET'`으로 로그인 폼을 처리할 때 발생할 수 있는 보안 위험성.
- `GET` 요청을 사용할 때 URL에 데이터가 포함되어 민감한 정보가 노출될 수 있다는 사실.
