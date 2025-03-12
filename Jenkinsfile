pipeline {
    agent any

    options {
    timeout(time:1, unit: 'HOURS')}

    stages {
        stage('Checkout') {
        steps {
                checkout scm
            }
        }
        stage('Build and Test') {
        steps {
            script {
            try {
            def customImage = docker.build("pytest-selenium:${env.BUILD_ID}")
            customImage.inside('--shm-size=2g') {
                            sh 'echo "Installing dependencies..."'
                            sh 'pip install -r requirements.txt'

                            sh 'echo "Running tests..."'
                            sh 'pytest test_demo_website.py'
                        }
            } catch (Exception e) {
            currentBuild.result = 'FAILURE'
            error "Build and test failed: ${e.message}"
            }

            }
        }
    }
}
    post {
    always {
        echo 'Test Completed'
        cleanWs()
        }
    success {
        echo 'All Test Passed'
        }
    failure {
        echo 'Tests Failed. Please check the logs for details'
        }
        }

}