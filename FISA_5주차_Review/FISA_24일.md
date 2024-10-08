### 24일차 네줄리뷰(Four Lines Review)** ###
- **사실(Facts)**: 리눅스에서 파일 권한은 `rw-rw----`와 같은 형식으로 표현되며, 하드 링크는 원본과 동일한 물리적 위치를 가리킨다.
- **발견(Discovery)**: 하드 링크와 소프트 링크의 차이를 이해함으로써 파일 관리의 효율성을 높일 수 있다.
- **배운점(Lesson Learned)**: Here Document를 사용하면 명령어에 여러 줄의 입력을 손쉽게 전달할 수 있다는 점.
- **선언(Declaration)**: 리눅스 명령어를 꾸준히 연습하여 시스템 관리의 숙련도를 높이겠다.

### 잊었다가 다시 배운 개념 ###
- **파일 권한 형식**: `rw-rw----`와 같은 형식으로 파일 소유자, 그룹, 다른 사용자의 권한을 구분하며, 첫 번째 문자는 파일의 타입을 나타냄.
- **하드 링크**: 원본 파일과 동일한 물리적 위치를 가리키는 디렉토리 항목으로, 원본과 하드 링크는 동일한 파일로 간주됨.
- **소프트 링크**: 다른 파일이나 디렉토리를 가리키는 링크로, 원본이 삭제되면 깨진 링크가 됨.

### 몰랐던 개념 ###
- **숫자**: 파일 권한 표시에서 나타나는 숫자는 해당 파일을 가리키는 하드 링크의 수를 나타냄.
- **awk**: 텍스트 파일에서 특정 열을 추출하고 처리할 수 있는 강력한 도구로, 다양한 형식의 데이터를 분석할 때 사용됨.
- **Here Document** (`<<`): 여러 줄의 텍스트를 명령어의 입력으로 전달하는 기능으로, 종료 구분자를 사용하여 입력을 종료함.
