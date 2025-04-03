pipeline {
    agent any

    environment {
        SONARQUBE_SERVER = 'http://host.docker.internal:9000'
        DOCKER_IMAGE = 'villegas7155/java-hello-world:latest'
    }

    stages {
        stage('Debug Workspace') {
            steps {
                bat '''
                    echo Current Directory:
                    echo %cd%
                    echo Listing files:
                    dir /s
                '''
            }
        }

        stage('Build Java App') {
            steps {
                bat '''
                    echo Compiling Java code...
                    if not exist app mkdir app
                    javac -d app src/HelloWorld.java
                '''
            }
        }

        stage('Build Docker Image') {
            steps {
                bat 'docker build -t %DOCKER_IMAGE% .'
            }
        }

        stage('Push to Docker Hub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'docker_for_jenkins', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASSWORD')]) {
                    bat '''
                        docker login -u %DOCKER_USER% -p %DOCKER_PASSWORD%
                        docker push %DOCKER_IMAGE%
                    '''
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                bat 'kubectl apply -f deployment.yaml'
            }
        }
    }

    post {
        success {
            echo '✅ Pipeline completed successfully!'
        }
        failure {
            echo '❌ Pipeline failed. Check logs.'
        }
    }
}
