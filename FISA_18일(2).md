# AI SQL Assistant 만들기
----------------------
```
import numpy as np
import pandas as pd
import openai
import pymysql
import sqlalchemy
# SQL DB 셋팅
from sqlalchemy import create_engine
from sqlalchemy import text # 쿼리 입력에 필요
import pymysql

#  echo=True : 쿼리문으로 변환한 결과를 화면에 print
```
# GPT에게 우리가 다루는 데이터, 테이블이 어떤 구조인지 알려주는 함수 작성
- 아래 테이블 구조 기준으로 코드를 작성해줄 것 요청
```
-- df는 xlsx파일을 판다스 데이터프레임으로 변환한 객체
df = pd.read_excel('AdidasSalesdata.xlsx')
def table_definition_prompt(df):
    prompt = '''Given the following sqlite MySQL definition,
            write queries based on the request
            \n### MySQL SQL table, with its properties:

            #
            # Sales({})
            #
            '''.format(",".join(str(x) for x in df.columns))

    return prompt
```
- 사용자로부터 어떤 것을 확인하고 싶은지 받는 내용의 함수
```
def prompt_input():
    nlp_text = input('궁금한 것이 무엇인가요?: ')
    return nlp_text
```

```
full_prompt= table_definition_prompt(df) + prompt_input()
print(full_prompt)
```

```
response = client.chat.completions.create(
    model="gpt-4o-mini",
    messages=[
        {"role": "system", "content": "You are an assistant that generates SQL queries based on the given MySQL table definition\
        and a natural language request. The query should start with 'SELECT' and end with a semicolon(;). You must give me a query statement."},
        {"role": "user", "content": f"A query to answer: {full_prompt}"}
    ],
    max_tokens=200, # 비용 발생하므로 시도하며 적당한 값 찾아간다. 200이면 최대 200단어까지 생성.
                    # 영어는 한 단어가 1토큰, 한글은 한 글자가 1토큰 정도
    temperature=1.0, # 창의성 발휘 여부. 0~2 사이. 0에 가까우면 strict하게, 2에 가까우면 자유롭게(창의성 필요)
    stop=None  # 특정 문자열이 들어오면 멈춘다든지. None이면 없음. .이면 문장이 끝나면 멈춘다든지
    )
```
	- 첫 번째 메시지는 system 역할로, 시스템에게 주어진 테이블 정의와 자연어 요청을 기반으로 SQL 쿼리를 생성하라는 지침을 제공합니다. 쿼리는 'SELECT'로 시작하고 세미콜론(;)으로 끝나야 한다고 명시합니다.
	- 두 번째 메시지는 user 역할로, 사용자 요청을 포함합니다. 여기서 full_prompt는 앞서 생성된 전체 프롬프트 문자열입니다.
	- max_tokens=200: 생성할 최대 토큰 수를 200으로 지정합니다. 이는 생성된 텍스트의 길이를 제한하는데, 비용 절감을 위해 적절한 값을 찾아가는 과정입니다.
	- temperature=1.0: 창의성 정도를 조절하는 매개변수입니다. 0에 가까울수록 모델이 더 엄격하게 응답하고, 2에 가까울수록 더 창의적으로 응답합니다.
	- stop=None: 생성된 텍스트를 중단시킬 특정 문자열을 지정하지 않습니다. 예를 들어, 특정 문자열이 나오면 텍스트 생성을 멈추도록 설정할 수 있습니다. 여기서는 중단 조건이 없습니다.
```
def handle_response(response):
    query = response.choices[0].message.content.strip()

    if query.startswith("```"):
        query = query.lstrip("```sql\n")
        query = query.rstrip("```")

    if not query.upper().startswith("SELECT"):
        query = "SELECT " + query

    if not query.endswith(";"):
        query += ";"

    return query
```

```
print( handle_response(response))
-- 결과 : SELECT * FROM Sales;
```
