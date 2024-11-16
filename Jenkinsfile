pipeline {
    agent any

    environment {
        VIRTUAL_ENV = "${WORKSPACE}/venv"
    }

    stages {
        stage('Setup') {
            steps {
                script {
                    if (!fileExists("${VIRTUAL_ENV}")) {
                        sh "python3 -m venv ${VIRTUAL_ENV}"
                    }
                    sh "source ${VIRTUAL_ENV}/bin/activate && pip install -r requirements.txt"
                }
            }
        }

        stage('Lint') {
            steps {
                script {
                    sh "source ${VIRTUAL_ENV}/bin/activate && flake8 app.py"
                }
            }
        }

        stage('Test') {
            steps {
                script {
                    sh "source ${VIRTUAL_ENV}/bin/activate && pytest"
                }
            }
        }

        stage('Deploy') {
            steps {
                script {
                    // Deployment logic, e.g., pushing to a remote server
                    echo "Deploying application..."
                }
            }
        }
    }

    post {
        always {
            cleanWs() // Cleans up the workspace after the build is done
        }
    }
}