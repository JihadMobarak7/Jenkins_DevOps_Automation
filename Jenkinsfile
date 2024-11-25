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

        stage('Coverage') {
            steps {
                script {
                    sh "source ${VIRTUAL_ENV}/bin/activate && coverage run -m pytest"
                    sh "source ${VIRTUAL_ENV}/bin/activate && coverage report"
                    sh "source ${VIRTUAL_ENV}/bin/activate && coverage html"
                }
            }
        }

        stage('Security Scan') {
            steps {
                script {
                    sh """
                    source ${VIRTUAL_ENV}/bin/activate &&
                    bandit -r . -f html -o bandit-report.html || true
                    """
                }
            }
            post {
                always {
                    archiveArtifacts artifacts: 'bandit-report.html', allowEmptyArchive: true
                }
            }
        }

        stage('Deploy') {
            steps {
                script {
                    sh "./deploy.sh"
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