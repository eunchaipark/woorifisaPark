### **54일차 네줄리뷰 (Four Lines Review)**

- **사실 (Facts)**: PyCaret을 사용해 은행 데이터셋에 대한 분류 모델을 구성하고, 'Bagging'과 'Boosting' 앙상블 기법을 통해 성능을 향상시켰다.
  
- **발견 (Discovery)**: 'Bagging'은 모델의 분산을 줄이는 데 효과적이고, 'Boosting'은 편향을 줄여 성능을 향상시킬 수 있다.

- **배운점 (Lesson Learned)**: 데이터 전처리를 통한 라벨 인코딩과 PyCaret의 자동 모델 비교 및 튜닝 기능을 통해 복잡한 모델링 작업을 간단하게 수행할 수 있다.

- **선언 (Declaration)**: PyCaret을 활용해 앙상블 모델 성능을 최적화하고 다양한 기법을 적용할 것이다.

---

### **1. 데이터 전처리**

**Label Encoding**을 통해 범주형 데이터를 숫자로 변환:
- `job`, `marital`, `education`, `default`, `housing`, `loan`, `contact`, `month`, `poutcome` 같은 컬럼에 **LabelEncoder**를 사용해 범주형 데이터를 숫자로 변환.
- 이를 통해 모델이 문자열 대신 숫자 데이터를 처리할 수 있도록 준비.

```python
label_encoders = {}
for column in ['job', 'marital', 'education', 'default', 'housing', 'loan', 'contact', 'month', 'poutcome']:
    le = LabelEncoder()
    data[column] = le.fit_transform(data[column])
    label_encoders[column] = le
```
# 2. PyCaret 환경 설정
setup() 함수를 사용하여 PyCaret 환경을 구성:

target 파라미터로 예측할 대상 변수를 설정 (deposit).
session_id를 설정해 재현성을 보장.
log_experiment=False로 실험 기록을 남기지 않도록 설정.
```
clf = setup(data, target='deposit', session_id=123, log_experiment=False, verbose=False)
```
# 3. 모델 비교 및 성능 평가
compare_models() 함수를 사용해 여러 분류 모델을 자동으로 비교하고, 가장 성능이 좋은 모델을 선택.

PyCaret은 내부적으로 다양한 모델(예: LightGBM, 랜덤 포레스트, 로지스틱 회귀 등)을 테스트하여 성능을 평가.
```
best_model = compare_models()
```
# 4. 앙상블 모델 생성
앙상블 기법을 사용해 모델의 성능을 향상:

ensemble_model() 함수를 통해 'Bagging'과 'Boosting' 방식을 각각 적용.
Bagging: 모델을 병렬로 학습시켜 분산을 줄이는 기법.
Boosting: 모델을 순차적으로 학습시켜 편향을 줄이는 기법.
```
bagged_model = ensemble_model(best_model, method='Bagging')
boosted_model = ensemble_model(best_model, method='Boosting')
```
# 5. 모델 튜닝
앙상블 모델의 성능을 최적화하기 위해 tune_model() 함수를 사용.

최적화 기준으로 'Accuracy'를 선택하여 모델의 정확도를 높임.
```
tuned_bagged_model = tune_model(bagged_model, optimize='Accuracy')
tuned_boosted_model = tune_model(boosted_model, optimize='Accuracy')
```
# 6. 모델 평가
evaluate_model() 함수를 사용해 앙상블된 모델의 성능을 시각적으로 평가.

```
print("Bagged Model:")
evaluate_model(bagged_model)

print("Boosted Model:")
evaluate_model(boosted_model)
```
# 7. 모델 저장 및 예측
save_model()을 사용해 최종 모델을 저장하고, predict_model()로 예측을 수행.

저장된 모델은 나중에 로드하여 재사용 가능.
```
save_model(bagged_model, 'bagged_model')
save_model(boosted_model, 'boosted_model')

predictions_bagged = predict_model(bagged_model, data=data)
predictions_boosted = predict_model(boosted_model, data=data)
```
# 잊었다가 다시 배운 개념
앙상블 기법: 여러 모델을 결합해 성능을 향상시키는 방법.
Bagging: 여러 개의 학습 데이터를 샘플링해 각각 독립적으로 학습한 모델들을 결합. 분산 감소에 효과적.
Boosting: 약한 학습기를 순차적으로 학습해 강한 학습기로 만드는 기법. 편향 감소에 효과적.
몰랐던 개념
PyCaret 튜닝: 모델의 하이퍼파라미터를 최적화해 성능을 극대화하는 기능.
