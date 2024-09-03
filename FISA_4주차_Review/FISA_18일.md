### **18일차 네줄리뷰(Four Lines Review)** ###
- 사실(Facts): 가상환경 사용, pymysql, 프롬프트 엔지니어링
- 발견(Discovery):  pymysql사용으로 python에서의 sql연동,생성형 인공 지능 솔루션을 안내하여 원하는 결과를 생성하는 프로세스
- 배운점(Lesson Learned): pymysql사용법 및 인공지능 솔루션과 streamlit을 같이 사용해서 배포하기
- 선언(Daclaration): 대부분 처음배운 내용이기에 공부가 필요하다
 
### 공부한 것들 ###
- pymysql
```
connection = pymysql.connect(host=호스트,
                             user=사용자이름,
                             password=비밀번호,
                             db=데이터베이스 이름)

cursor = connection.cursor()  -- connection.cursor 를 통해 위에 해당하는 db에 접속
cursor.execute('SELECT * from emp ORDER BY empno DESC LIMIT 5')  
-- 위에 접속해서 데이터조작 및 조회 등해서 cusor에 결과 저장
result = cursor.fetchall()  -- fetchall()은 cursor에 있는 것들 모두 보여준다
# fetchall(), fetchone(), fetchmany(size=5) 
```
- pymysql을 통한 sql 데이터 조작
``` 
## 1. 모듈을 불러옵니다.
import pymysql

# 2. pymysql한테 3306 포트번호와 접속할 ID, PW를 준다
connection = pymysql.connect(host='localhost',
                             user='root',
                             password='0000',
                             db='student_mgmt')

# 3. 대신 일하게 만들 커서를 만듭니다.
cursor = connection.cursor()

# 4. 실행할 SQL문을 넘깁니다. - 기본적으로 한 번에 한 문장을 넘기는구나
cursor.execute("INSERT INTO students (name, gender, birth, english, math, korean) VALUES ('wage2', 'woman', '1982-1-13', 76, 30, 80);")
cursor.execute("INSERT INTO students (name, gender, birth, english, math, korean) VALUES ('tina2', 'woman', '1982-12-3', 87, 62, 71);")
cursor.execute("UPDATE students SET name='sage' WHERE name='wage';")
cursor.execute("DELETE from students where name='Minsun';")

# 5. DB에 현재 상태를 COMMIT 합니다.
connection.commit()

# 6. DB와 연결을 닫습니다.
connection.close()

```

- yaml 파일에 호스트, 사용자이름, 비밀번호 담아서  connection에 사용하기
```
%%writefile db.yaml
HOST: 호스트
USER: 사용자이름
PASSWD: 비밀번호  -- yaml파일을 생성하고 호스트 사용자이름 비밀번호를 적어둔다

import yaml
DB_INFO = "db.yaml"
with open(DB_INFO,"r") as f:
    db_info = yaml.load(f, Loader=yaml.Loader) -- db.yaml을 읽기모드로 열어서 이를 f로 지칭한다. f에 있는 것을 로딩해서 db.info에 넣는다
-- db_info를 열어보면 {'HOST': 호스트, 'USER': 사용자이름, 'PASSWD': 비밀번호 } 딕셔너리 형식으로 존재

HOST = db_info["HOST"]
USER = db_info["USER"]
PASSWD = db_info["PASSWD"]
PORT = 포트번호
-- 이름 다른 변수에 담고

import pymysql

conn = pymysql.connect(
    user = USER,
    passwd = PASSWD,
    host = HOST,
    port = PORT,
    db = 'fisa'
)
conn --connection에 사용한다 그리고 conn에 담는다.

df = pd.read_sql_query("select * from emp;",conn) # read_sql_table, read_sql_query
df  -- conn에는 database와 연결이 되어 있고 그 데이터 베이스에 명령을 내려서 결과값을 df에 담는다.
```
- DF를 데이터 베이스 서버로 보내기
```
conn = pymysql.connect(
    user = USER,
    passwd = PASSWD,
    host = HOST,
    port = PORT,
    autocommit = True # default : False # 오토커밋 기능 설정, 위와 동일하게 connection을 사용한다.
)
conn.select_db("fisa") # use DB명; --connection을 사용해서 사용할 DB를 정한다.
cursor=conn.cursor(pymysql.cursors.DictCursor)  --딕셔너리 형식으로 데이터를 받아오는 옵션 기본값은 튜플로 값이 전달됩니다.
cursor.execute('select * from emp;')
result =cursor.fetchall()   #키: 값 순으로 가져온다.
result[0] --#행번호대로 /컬럼으로 값을 받아서 사용할수 있다.
pd.DataFrame(result) --데이터 프레임으로 사용할수도 있다.
```
```
# few shot
import openai

os.environ['OPENAI_API_KEY'] = '오픈 AI API 키'
client = OpenAI()

response = client.chat.completions.create(
    model="gpt-4o-mini",
    messages=[
        {"role": "system", "content": "You are a helpful assistant. List three fruits:"},
        {"role": "user", "content": "1.망고, 2.바나나, 3.오렌지"},
        {"role": "user", "content": "- 망고 \n - 수박 \n - 딸기"}
    ],
    temperature=1,
    max_tokens=50,
    n=5
    # stop = ['.', '\n']
)
```
-- pymysql을 이용해서 xlse파일 sql로 사용하기
```
df= pd.read_excel('AdidasSalesdata.xlsx')
db = create_engine('mysql+pymysql://사용자이름:비밀번호@로컬호스트/DB', echo=True)
df.to_sql(name='sales_park', con=db)
with db.connect() as conn:    -- with를 사용하면 open 만 적어주고 close를 적어주지 않아도 문단만 지나면 파일을 닫아 준다. 들여쓰기를 잘해야한다.
    result =conn.execute(text('select * from sales_park'))
    ```

