# 20일차 네줄 리뷰 (Four Lines Review)

**사실 (Facts):**  
Docker는 컨테이너 가상화 기술을 제공하는 오픈소스 플랫폼으로, 애플리케이션을 표준화된 환경에서 실행할 수 있도록 도와줍니다. 오늘은 Docker의 설치 및 기본적인 사용법에 대해 학습하였습니다.

**발견 (Discovery):**  
Docker를 사용하면 개발자가 로컬에서 컨테이너를 실행함으로써 표준화된 환경을 유지할 수 있습니다. 이는 개발 및 배포 과정에서의 일관성을 보장하고, 다양한 환경에서 애플리케이션을 테스트하고 실행할 수 있는 유연성을 제공합니다. Docker는 개발 수명 주기를 단순화하고, 환경 설정의 불확실성을 줄이는 데 큰 도움이 됩니다.

**배운 점 (Lesson Learned):**  
Docker를 사용함으로써 각 컨테이너의 독립성을 인식할 수 있었습니다. 이로 인해 컨테이너 이미지 관리와 배포가 용이해졌으며, 기존 로컬 환경에서만 작업할 때의 제약이 줄어들었습니다. 특히, 다양한 라이브러리와 의존성을 컨테이너 내에서 관리할 수 있어, 개발 환경의 일관성을 유지하면서도 각종 라이브러리 설치에 대한 부담이 크게 줄어들었습니다.

**선언 (Declaration):**  
Docker 사용에 대한 이해가 아직 부족하다는 것을 느꼈습니다. 컨테이너와 이미지의 개념, 명령어 사용 등에 대한 미숙함이 여전히 존재합니다. 앞으로 더 많은 실습과 학습을 통해 Docker의 다양한 기능을 숙련되게 다루는 것이 필요합니다.

---

## 이해부족으로 추가 공부한 내용...

Docker는 컨테이너 가상화 기술을 기반으로 하는 오픈소스 플랫폼으로, 애플리케이션의 배포와 관리를 효율적으로 수행할 수 있게 도와줍니다. Docker의 주요 개념과 명령어를 다음과 같이 정리할 수 있습니다:

### **Docker 기본 개념**

- **Docker 이미지 (Docker Image):**  
  Docker 이미지란 컨테이너를 실행하기 위한 가상 환경의 템플릿을 의미합니다. 이미지는 애플리케이션과 그 종속성, 설정 파일 등을 포함하며, 변경 불가능한 상태로 제공됩니다. 이미지 레이어는 Dockerfile의 명령어에 의해 생성되며, 여러 레이어로 구성됩니다.

- **Docker 컨테이너 (Docker Container):**  
  Docker 컨테이너는 Docker 이미지를 기반으로 생성된 실행 가능한 인스턴스입니다. 컨테이너는 이미지의 실행 가능한 인스턴스이며, 애플리케이션을 실제로 실행하는 환경입니다. 컨테이너는 호스트 운영 체제의 커널을 공유하면서도 독립된 파일 시스템, 네트워크 인터페이스, 프로세스 공간을 갖습니다.

- **Docker 볼륨 (Docker Volume):**  
  Docker 볼륨은 컨테이너와 호스트 시스템 간의 데이터 공유를 위해 사용됩니다. 볼륨을 사용하면 컨테이너가 중지되거나 제거되더라도 데이터가 유지되며, 여러 컨테이너 간에 데이터를 공유할 수 있습니다.

### **Docker 명령어**

- **`docker run`**: 컨테이너를 실행합니다.  
  - **사용법:** `docker run [OPTIONS] IMAGE [COMMAND] [ARG...]`
  - **예시:** `docker run --name mytomcat -d -p 80:8080 tomcat:9.0`  
    - **설명:** `--name mytomcat`으로 컨테이너 이름을 설정하고, `-d` 옵션으로 백그라운드 모드에서 실행합니다. `-p 80:8080` 옵션은 호스트의 포트 80을 컨테이너의 포트 8080에 매핑합니다. `tomcat:9.0` 이미지를 사용하여 컨테이너를 생성합니다.

- **`docker ps`**: 현재 실행 중인 컨테이너를 확인합니다.  
  - **사용법:** `docker ps [OPTIONS]`
  - **예시:** `docker ps`  
    - **설명:** 현재 실행 중인 모든 컨테이너의 목록을 표시합니다.

- **`docker stop`**: 실행 중인 컨테이너를 중지합니다.  
  - **사용법:** `docker stop [OPTIONS] CONTAINER [CONTAINER...]`
  - **예시:** `docker stop mytomcat`  
    - **설명:** 이름이 `mytomcat`인 컨테이너를 중지합니다.

- **`docker rm`**: 컨테이너를 삭제합니다.  
  - **사용법:** `docker rm [OPTIONS] CONTAINER [CONTAINER...]`
  - **예시:** `docker rm mytomcat`  
    - **설명:** 이름이 `mytomcat`인 컨테이너를 삭제합니다.

### **컨테이너 마운트**

- **컨테이너 생성 시 마운트:**
  - **명령어:** `docker run --name <생성하는컨테이너_이름> -d -p <포트포워딩> -v <호스트경로>:<컨테이너경로> <이미지명>`
  - **사용 예시:** `docker run --name mynginxserver -d -p 81:80 -v C:\Users\YourUsername\docker_1\bindStorage:/usr/share/nginx/html nginx`
    - **설명:** `-d`는 컨테이너를 백그라운드 모드로 실행하며, `-p 81:80`은 호스트의 포트 81을 컨테이너의 포트 80에 매핑합니다. `-v` 옵션을 사용하여 호스트의 `C:\Users\YourUsername\docker_1\bindStorage` 디렉토리를 컨테이너의 `/usr/share/nginx/html` 디렉토리에 바인드 마운트합니다.

- **파일 이동 및 컨테이너 마운트 예시:**
  - **`mv index.html binddir/`**
    - **설명:** `index.html` 파일을 `binddir` 디렉토리로 이동합니다.
  - **`docker run --name mynginxserver -d -p 82:80 -v /home/ubuntu/binddir:/usr/share/nginx/html nginx`**
    - **설명:** 호스트의 `/home/ubuntu/binddir` 디렉토리를 컨테이너의 `/usr/share/nginx/html` 디렉토리에 마운트하여 파일을 동기화합니다.

- **파일 복사:**
  - **명령어:** `docker cp <소스경로> <컨테이너ID>:<대상경로>`
  - **예시:** `docker cp newfile1.txt <컨테이너_id>:/path/in/container`
    - **설명:** 호스트에서 컨테이너로 파일을 복사합니다.


