pipeline {
    agent any

    environment {
        SONARQUBE_SERVER = 'http://host.docker.internal:9000'
        DOCKER_IMAGE = 'villegas7155/java-hello-world:latest'
    }

    stages {        
        stage('Build Docker Image') {
            steps {
                script {
                    sh 'docker build -t ${DOCKER_IMAGE} .'
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                script {
                    withCredentials([string(credentialsId: 'docker-for-jenkins', variable: 'DOCKER_PASSWORD')]) {
                        sh 'docker login -u villegas7155 -p ${DOCKER_PASSWORD}'
                        sh 'docker push ${DOCKER_IMAGE}'
                    }
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                script {
                    sh 'kubectl apply -f deployment.yaml'
                }
            }
        }
    }
}
