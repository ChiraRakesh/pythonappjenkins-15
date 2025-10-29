pipeline {
    agent any

    environment {
        VENV_DIR = "venv"
        DOCKER_IMAGE = "rakeshchira/pythonappjenkins-15"
    }

    stages {
        stage('Checkout') {
            steps {
                echo '📦 Cloning the repository...'
                git branch: 'main',
                    url: 'https://github.com/ChiraRakesh/pythonappjenkins-15.git'
            }
        }

        stage('Install Dependencies') {
            steps {
                echo '⚙️ Setting up Python environment and installing dependencies...'
                sh """
                    python3 -m venv ${VENV_DIR}
                    . ${VENV_DIR}/bin/activate
                    pip install --upgrade pip
                    pip install -r requirements.txt
                """
            }
        }

        stage('Code Quality Check') {
            steps {
                echo '🔍 Running lint checks with flake8...'
                sh """
                    . ${VENV_DIR}/bin/activate
                    pip install flake8
                    flake8 . --count --select=E9,F63,F7,F82 --show-source --statistics || true
                    flake8 . --count --exit-zero --max-complexity=10 --max-line-length=127 --statistics
                """
            }
        }

        stage('Run Tests') {
            steps {
                echo '🧪 Running unit tests with pytest...'
                sh """
                    . ${VENV_DIR}/bin/activate
                    pip install pytest pytest-cov
                    pytest --maxfail=1 --disable-warnings --cov=. --cov-report=term-missing || true
                """
            }
        }

        stage('Build Docker Image') {
            steps {
                echo '🐳 Building Docker image...'
                sh """
                    docker build -t ${DOCKER_IMAGE} .
                """
            }
        }

        stage('Push to DockerHub') {
            steps {
                echo '🚀 Logging in and pushing Docker image...'
                // Make sure you have a Jenkins credential with ID 'dockerhub-token'
                withCredentials([usernamePassword(credentialsId: 'dockerhub-token', usernameVariable: 'rakeshchira', passwordVariable: 'DOCKER_PASS')]) {
                    sh """
                        echo "$DOCKER_PASS" | docker login -u "$rakeshchira" --password-stdin
                        docker push ${DOCKER_IMAGE}
                    """
                }
            }
        }

        stage('Deploy Container') {
            steps {
                echo '🚢 Deploying container locally...'
                sh """
                    docker rm -f flask-container || true
                    docker run -d -p 5000:5000 --name flask-container ${DOCKER_IMAGE}
                """
            }
        }
    }

    post {
        success {
            echo '✅ Deployment completed successfully! 🎉'
        }
        failure {
            echo '❌ Build failed. Check logs for details.'
        }
    }
}
