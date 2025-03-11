pipeline {
    agent any

    stages {
        stage('Checkout') {
        steps {
                checkout scm
            }
        }
        stage('Build and Test') {
        steps {
            script {
            docker.build("pytest-selenium:${env.BUILD_ID}").inside('--shm-size=2g') {
                sh 'pip install -r requirements.txt'
                sh 'pytest test_demo_website.py'
                }
            }
        }
    }
}
    post {
    always {
        echo 'Test Completed'}
        }

}