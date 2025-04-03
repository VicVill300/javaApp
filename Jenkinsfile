pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'villegas7155/java-hello-world:latest'
    }

    stages {
        stage('Debug Workspace') {
            steps {
                bat '''
                    echo [INFO] Current Directory:
                    echo %cd%
                    echo [INFO] Listing Files:
                    dir /s
                '''
            }
        }

        stage('Build Java App') {
            steps {
                bat '''
                    echo [INFO] Compiling HelloWorld.java...
                    javac app/HelloWorld.java
                '''
            }
        }

        stage('Build Docker Image') {
            steps {
                bat '''
                    echo [INFO] Building Docker image...
                    docker build -t %DOCKER_IMAGE% .
                '''
            }
        }

        stage('Push to Docker Hub') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'docker_for_jenkins',
                    usernameVariable: 'DOCKER_USER',
                    passwordVariable: 'DOCKER_PASSWORD'
                )]) {
                    bat '''
                        echo [INFO] Logging in to Docker Hub...
                        docker login -u %DOCKER_USER% -p %DOCKER_PASSWORD%
                        echo [INFO] Pushing Docker image...
                        docker push %DOCKER_IMAGE%
                    '''
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                withCredentials([file(credentialsId: 'minikube_kubeconfig', variable: 'KUBECONFIG')]) {
                    bat '''
                        echo [INFO] Using kubeconfig from Jenkins credentials...
                        kubectl config get-contexts
                        echo [INFO] Applying deployment.yaml...
                        kubectl apply -f deployment.yaml
                        echo [INFO] Checking pod status...
                        kubectl get pods
                    '''
                }
            }
        }
    }

    post {
        success {
            echo '✅ Pipeline completed successfully!'
        }
        failure {
            echo '❌ Pipeline failed. Check logs for details.'
        }
    }
}
