### 22일차 네줄리뷰(Four Lines Review)
- **사실(Facts)**: Dockerfile은 코드의 형태로 인프라를 구성하는 방법을 텍스트 형식으로 정의한 파일입니다. 
- **발견(Discovery)**: Docker Compose를 사용하면 여러 컨테이너를 정의하고 동시에 실행할 수 있습니다.
- **배운점(Lesson Learned)**: Docker 명령어와 Docker Compose를 통해 컨테이너 관리 및 서비스 연결을 손쉽게 할 수 있습니다.
- **선언(Declaration)**: Docker를 통해 애플리케이션의 배포와 관리를 자동화하여 효율성을 극대화하겠습니다.

### 잊었다가 다시 배운 개념
- **임시 컨테이너**: `COPY`와 `RUN` 명령어가 실행될 때 임시 컨테이너가 생성되어 작업이 수행됩니다.

### 몰랐던 개념
- **Docker Compose**: 여러 컨테이너를 정의하고 실행하기 위한 도구로, 서비스, 네트워크, 볼륨을 정의할 수 있습니다.

### Dockerfile 예제

```dockerfile
FROM nginx:latest   # NGINX의 최신 버전을 기반으로 새로운 이미지를 생성합니다.
COPY s.jpg /usr/share/nginx/html/  # 현재 디렉토리에 있는 s.jpg 파일을 컨테이너의 /usr/share/nginx/html/ 디렉토리에 복사합니다.
COPY index.html /usr/share/nginx/html/  # 현재 디렉토리에 있는 index.html 파일을 컨테이너의 /usr/share/nginx/html/ 디렉토리에 복사합니다.
ENV key value  # 환경 변수를 설정합니다.
CMD ["nginx", "-g", "daemon off;"]  # 컨테이너가 시작될 때 실행될 기본 명령어를 설정합니다.
```
### DOCKER 명령어
- 이미지 빌드: docker build -t <생성할 이미지 이름> .
  -- 현재 디렉토리에 있는 Dockerfile을 사용하여 이미지를 빌드합니다.
- 컨테이너 실행: docker run -d -p 80:80 <생성된 이미지 이름>
  -- 생성된 이미지를 기반으로 새로운 컨테이너를 실행합니다.
- 파일 복사: COPY . .
   --현재 호스트 디렉토리의 모든 파일을 Docker 이미지의 현재 작업 디렉토리로 복사합니다. .dockerignore 파일을 사용해 복사하지 않을 파일을 지정할 수 있습니다.
- 컨테이너 내부 명령 실행: docker exec <containerid> sh -c 'curl localhost'
  -- 실행 중인 컨테이너에서 curl localhost 명령을 실행합니다.
- 파일 수정: RUN echo '<h1> test <h1>' >> index.html
  -- 빌드 과정에서 임시 컨테이너 내에서 index.html 파일을 수정하거나 생성합니다

## DOCKER COMPSER예제
```
version: '3'  # Compose 파일의 버전을 지정합니다.

services:  # 애플리케이션의 각 컨테이너를 정의합니다.
  web:  # NGINX 웹 서버를 정의하는 서비스입니다.
    image: nginx:alpine  # 사용할 Docker 이미지를 지정합니다.
    ports:  # 호스트와 컨테이너 간의 포트를 매핑합니다.
      - "8080:80"  # 호스트의 포트 8080을 컨테이너의 포트 80에 매핑합니다.
    volumes:  # 호스트 디렉토리를 컨테이너 내의 디렉토리로 마운트합니다.
      - ./html:/usr/share/nginx/html  # 현재 디렉토리의 html 폴더를 컨테이너의 /usr/share/nginx/html 폴더에 마운트합니다.
  
  db:  # MySQL 데이터베이스를 정의하는 서비스입니다.
    image: mysql:5.7  # 사용할 Docker 이미지를 지정합니다.
    environment:  # 환경 변수를 설정합니다.
      MYSQL_ROOT_PASSWORD: example  # MySQL의 루트 패스워드를 설정합니다.
    volumes:  # Docker 볼륨을 컨테이너 내의 디렉토리로 마운트합니다.
      - db_data:/var/lib/mysql  # db_data라는 볼륨을 컨테이너의 /var/lib/mysql 폴더에 마운트합니다.

volumes:  # 애플리케이션에서 사용할 볼륨을 정의합니다.
  db_data:  # 데이터베이스 데이터를 저장하는 볼륨을 정의합니다.
```
### Docker Compese 명령어
  - 서비스 생성 및 시작: docker-compose up
  - 백그라운드 실행: docker-compose up -d
  - 서비스 중지 및 제거: docker-compose down
  - 이미지 빌드: docker-compose build
  - 서비스 로그 출력: docker-compose logs

### Docker 네트워크 및 컨테이너 관리 예제
```
# 네트워크 생성하기
docker network create my_wordpress_network

# MySQL 컨테이너 생성 및 실행하기
docker run --name my_mysql_container -dit --net=my_wordpress_network -e MYSQL_ROOT_PASSWORD=rootpassword -e MYSQL_DATABASE=my_wordpress_db -e MYSQL_USER=my_db_user -e MYSQL_PASSWORD=my_db_password mysql --character-set-server=utf8mb4 --collation-server=utf8mb4_unicode_ci

# WordPress 컨테이너 생성 및 실행하기
docker run --name my_wordpress_container -dit --net=my_wordpress_network -p 8080:80 -e WORDPRESS_DB_HOST=my_mysql_container -e WORDPRESS_DB_NAME=my_wordpress_db -e WORDPRESS_DB_USER=my_db_user -e WORDPRESS_DB_PASSWORD=my_db_password wordpress

# 컨테이너 실행 상태 확인하기
docker ps

# 뒷정리하기

# WordPress 컨테이너 중지 및 삭제
docker stop my_wordpress_container
docker rm my_wordpress_container

# MySQL 컨테이너 중지 및 삭제
docker stop my_mysql_container
docker rm my_mysql_container

# 네트워크 삭제
docker network rm my_wordpress_network

# 현재 네트워크 목록 확인하기
docker network ls
```
