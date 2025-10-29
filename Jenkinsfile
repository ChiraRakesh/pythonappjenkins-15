pipeline {
    agent any

    environment {
        VENV_DIR = "venv"
        DOCKER_IMAGE = "chirarakesh/pythonappjenkins-15"
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
                echo '🔍 Run

