### **CI/CD 파이프라인 및 배포 프로세스: 네줄리뷰**

- **사실(Facts):** GitHub에서 코드를 푸시하면 Jenkins가 빌드를 시작하고, SonarQube가 코드 품질을 검사하며 Docker 이미지로 빌드됩니다. 이미지가 AWS ECR에 저장되고, Argo CD를 통해 Kubernetes에 배포됩니다.
- **발견(Discovery):** SonarQube와 Docker 이미지 스캔을 통해 잠재적인 코드 문제와 보안 취약점을 사전에 차단할 수 있습니다.
- **배운 점(Lesson Learned):** GitOps 기반의 Argo CD를 통해 Kubernetes 배포를 자동화하여 효율적인 운영과 업데이트가 가능합니다.
- **선언(Declaration):** CI/CD 파이프라인은 코드 품질과 보안에 대한 엄격한 검증을 거쳐 자동 배포를 가능하게 합니다.

### **Kubernetes 클러스터 구조: 네줄리뷰**

- **사실(Facts):** 클러스터는 Web, App, DB 세 계층으로 구성되고, Persistent Volume을 통해 데이터가 유지됩니다.
- **발견(Discovery):** 각 계층이 독립된 Kubernetes 노드로 분리되어 트래픽을 효율적으로 관리할 수 있습니다.
- **배운 점(Lesson Learned):** PV와 PVC는 애플리케이션 재배포 시에도 데이터 일관성을 보장합니다.
- **선언(Declaration):** Kubernetes의 계층화된 구조와 영구 스토리지 전략은 데이터 안정성을 향상시킵니다.

### **모니터링 및 로깅 시스템: 네줄리뷰**

- **사실(Facts):** Prometheus가 메트릭을 수집하고, Grafana 대시보드를 통해 시각화하여 실시간 모니터링이 가능합니다.
- **발견(Discovery):** 실시간 성능 문제 탐지가 가능해 시스템 장애를 미리 예방할 수 있습니다.
- **배운 점(Lesson Learned):** 메트릭 수집과 시각화는 클러스터와 애플리케이션 성능 관리에 필수입니다.
- **선언(Declaration):** 실시간 모니터링 시스템은 성능 최적화와 신속한 문제 해결을 지원합니다.

### **AWS 기반 로드 밸런싱 및 오토스케일링: 네줄리뷰**

- **사실(Facts):** ALB는 트래픽을 EC2 인스턴스에 분배하며, Auto Scaling Group을 통해 EC2 인스턴스가 자동으로 스케일링됩니다.
- **발견(Discovery):** Auto Scaling Group은 부하에 맞춰 인스턴스를 자동으로 추가하거나 제거하여 리소스를 효율적으로 관리합니다.
- **배운 점(Lesson Learned):** AWS의 오토스케일링 기능은 클라우드 자원의 유연한 확장을 가능하게 합니다.
- **선언(Declaration):** AWS의 Auto Scaling Group과 로드 밸런싱은 안정적인 트래픽 관리를 보장합니다.
