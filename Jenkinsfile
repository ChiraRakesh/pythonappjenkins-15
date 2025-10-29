pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                sh 'echo Building...'
            }
        }

        stage('Test') {
            steps {
                sh 'echo Testing...'
            }
        }

        stage('Dockerize') {
            steps {
                sh '''
                docker build -t myflaskapp .
                docker images
                '''
            }
        }

        stage('Deploy') {
            steps {
                sh 'docker run -d -p 5000:5000 myflaskapp'
            }
        }
    }
}
