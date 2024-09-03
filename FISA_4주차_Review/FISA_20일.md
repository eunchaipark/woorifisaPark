### 20일차 네줄리뷰(Four Lines Review)** ###
- 사실(Facts):  가상환경 사용을 위한 DOCKER 설치 및 사용
- 발견(Discovery): docker를 사용함으로서 개발자가 로컬컨테이너를 사용하여 표준화된 환경에서 작업할 수 있도록 하여 개발 수명 주기를 간소화한다
- 배운점(Lesson Learned):  docker를 사용해 각 컨테이너에서의 독립성 인지 및 컨테이너 이미지 관리 및 배포,기존 로컬환경에서만 작업했으나 docker에서 독립성을 사용하여 각종 라이브러리 설치에 대한 부담이 준다
- 선언(Daclaration):  docker사용에 대한 미숙함이 역력하다. 더 많이 사용해야 한다

### 공부한 것들  ###
- Docker는 컨테이너 가상화 기술을 이용한 컨테이너 이미지 관리 및 배포를 위한 오픈소스 플랫폼입니다. 다음은 Docker의 기본 명령어입니다.
``` 
-- docker run : 컨테이너 실행 	예시: docker run [OPTIONS] IMAGE [COMMAND] [ARG...]
-- docker ps: 실행 중인 컨테이너를 확인합니다.	예시: docker ps [OPTIONS]
-- docker stop: 실행 중인 컨테이너를 중지합니다.	예시: docker stop [OPTIONS] CONTAINER [CONTAINER...]
-- docker rm: 컨테이너를 삭제합니다.	예시 : docker rm [OPTIONS] CONTAINER [CONTAINER...]
-- docker run --name mytomcat -d -p 80:8080 tomcat:9.0  이름을 mytomcat 지정 ,-d 백그라운드 모드에서 실행, -p 80:8080 호스트 머신의 포트 80을 컨테이너의 포트 8080에 매핑한다.
-- 호스트 포트 : 위부에 접근할때 사용할 포트
-- 컨테이너 포트 : 컨테이너 내에서 tomcat서버가 사용하는 포트
-- tomcat:9.0 : tomcat 9.0 이미지를 사용해서 컨테이너 생성 
```

  
