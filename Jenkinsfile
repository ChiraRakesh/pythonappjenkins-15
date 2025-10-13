pipeline {
    agent any

    environment {
        IMAGE_NAME = "flaskapp"
        IMAGE_TAG = "latest"
        CONTAINER_NAME = "flask-container"
    }

    stages {
        stage('Checkout') {
            steps {
                echo "Pulling code from GitHub..."
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                echo "Building Docker image..."
                sh "docker build -t $IMAGE_NAME:$IMAGE_TAG ."
            }
        }

        stage('Stop Old Container') {
            steps {
                echo "Stopping old container if running..."
                sh '''
                docker ps -q --filter "name=$CONTAINER_NAME" | grep -q . && docker stop $CONTAINER_NAME && docker rm $CONTAINER_NAME || true
                '''
            }
        }

        stage('Run New Container') {
            steps {
                echo "Starting new container..."
                sh "docker run -d -p 5000:5000 --name $CONTAINER_NAME $IMAGE_NAME:$IMAGE_TAG"
            }
        }
    }

    post {
        success {
            echo "✅ Flask app deployed successfully via Docker!"
        }
        failure {
            echo "❌ Jenkins build failed!"
        }
    }
}

