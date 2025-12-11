# DevOps Complete Project

## Technologies utilisées
- Jenkins (Pipeline CI/CD)
- Maven (Build Java)
- Docker (Conteneurisation)
- DockerHub (Registry)
- SonarQube (Analyse qualité)
- Kubernetes/Minikube (Orchestration)

## Prérequis
- Java 17
- Maven 3.8+
- Docker
- Jenkins
- Minikube
- SonarQube

## Setup
1. Configurer Jenkins avec plugins requis
2. Démarrer SonarQube: docker run -d -p 9000:9000 sonarqube
3. Démarrer Minikube: minikube start
4. Configurer les credentials dans Jenkins:
   - DockerHub credentials
   - SonarQube token

## Pipeline Stages
1. Git Checkout
2. Maven Build
3. Unit Tests
4. SonarQube Analysis
5. Package JAR
6. Build Docker Image
7. Push to DockerHub
8. Deploy to Minikube

## URLs
- Jenkins: http://localhost:8080
- SonarQube: http://localhost:9000
- Application: http://minikube-ip:30007
