### **27일차 네줄리뷰(Four Lines Review)** ###
### Elasticsearch 텍스트 분석: `analyze` API와 Nori 분석기

#### 1. **사실(Facts)**
Elasticsearch의 `analyze` API는 텍스트를 어떻게 토큰화하고 필터링하여 인덱싱되는지를 보여줍니다. `tokenizer`는 텍스트를 분리하는 도구이며, 다양한 토크나이저가 있습니다. `pattern` 토크나이저는 정규 표현식을 사용하여 텍스트를 분리하고, `nori_tokenizer`는 한국어 분석을 위해 사용됩니다.

#### 2. **발견(Discovery)**
`analyze` API를 사용하여 분석된 결과를 통해 텍스트가 어떻게 처리되는지를 확인할 수 있습니다. 예를 들어, `pattern` 토크나이저를 사용하여 줄바꿈을 기준으로 텍스트를 분리하거나, `nori_tokenizer`와 필터를 통해 한국어 텍스트를 효과적으로 분석할 수 있습니다.

#### 3. **배운 점(Lesson Learned)**
커스텀 `tokenizer`와 `analyzer`를 설정하여 텍스트 분석을 세밀하게 조정할 수 있습니다. 예를 들어, `nori_tokenizer`와 `nori_part_of_speech` 필터를 사용하여 특정 품사를 필터링하고, 사용자 정의 사전을 통해 분석 정확도를 높일 수 있습니다.

#### 4. **선언(Declaration)**
Elasticsearch의 분석기와 토크나이저 설정을 이해하고 활용하여 텍스트 인덱싱과 검색을 최적화할 수 있습니다. 커스텀 분석기 설정을 통해 보다 정교한 검색 기능을 구현할 수 있습니다.
