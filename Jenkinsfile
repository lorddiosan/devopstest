pipeline {
    agent any
    
    tools {
        maven 'Maven-3.8.5'
        jdk 'JDK-17'
    }
    
    environment {
        DOCKERHUB_CREDENTIALS = credentials('dockerhub-credentials')
        DOCKER_IMAGE = 'YOUR_DOCKERHUB_USERNAME/devops-app'  # REMPLACER
        SONAR_HOST_URL = 'http://192.168.56.10:9000'  # REMPLACER avec IP VM
        SONAR_TOKEN = credentials('sonar-token')
    }
    
    stages {
        stage('Git Checkout') {
            steps {
                checkout scm
            }
        }
        
        stage('Maven Build') {
            steps {
                sh 'mvn clean compile'
            }
        }
        
        stage('Unit Tests') {
            steps {
                sh 'mvn test'
            }
            post {
                always {
                    junit 'target/surefire-reports/*.xml'
                }
            }
        }
        
        stage('SonarQube Analysis') {
            steps {
                withSonarQubeEnv('SonarQube') {
                    sh 'mvn sonar:sonar -Dsonar.projectKey=devops-app -Dsonar.host.url=${SONAR_HOST_URL} -Dsonar.login=${SONAR_TOKEN}'
                }
            }
        }
        
        stage('Package JAR') {
            steps {
                sh 'mvn package -DskipTests'
                archiveArtifacts artifacts: 'target/*.jar', fingerprint: true
            }
        }
        
        stage('Build Docker Image') {
            steps {
                script {
                    sh """
                        docker build -t ${DOCKER_IMAGE}:${BUILD_NUMBER} .
                        docker build -t ${DOCKER_IMAGE}:latest .
                    """
                }
            }
        }
        
        stage('Push to DockerHub') {
            steps {
                script {
                    sh """
                        echo ${DOCKERHUB_CREDENTIALS_PSW} | docker login -u ${DOCKERHUB_CREDENTIALS_USR} --password-stdin
                        docker push ${DOCKER_IMAGE}:${BUILD_NUMBER}
                        docker push ${DOCKER_IMAGE}:latest
                    """
                }
            }
        }
        
        stage('Deploy to Minikube') {
            steps {
                script {
                    sh '''
                        kubectl apply -f k8s/deployment.yaml
                        kubectl apply -f k8s/service.yaml
                        kubectl rollout status deployment/devops-app --timeout=300s
                    '''
                }
            }
        }
    }
    
    post {
        success {
            echo '✅ Pipeline réussie!'
            sh '''
                echo "Application URL:"
                minikube service devops-app-service --url
            '''
        }
        failure {
            echo '❌ Pipeline échouée!'
        }
        always {
            cleanWs()
        }
    }
}
