pipeline {
    agent any

    environment {
        VENV_DIR = "venv"
        PYTHON = "python3"
    }

    stages {
        stage('Checkout') {
            steps {
                echo "📥 Pulling code from GitHub..."
                checkout scm
            }
        }

        stage('Build') {
            steps {
                echo "🏗️ Setting up Python virtual environment..."
                sh '''
                ${PYTHON} -m venv ${VENV_DIR}
                . ${VENV_DIR}/bin/activate
                pip install --upgrade pip
                pip install -r requirements.txt
                '''
            }
        }

        stage('Test') {
            steps {
                echo "🧪 Running tests with pytest..."
                sh '''
                . ${VENV_DIR}/bin/activate
                pytest --maxfail=1 --disable-warnings --cov=. --cov-report=term-missing
                '''
            }
        }
    }

    post {
        success {
            echo "✅ Tests passed successfully!"
        }
        failure {
            echo "❌ Build or tests failed!"
        }
    }
}
