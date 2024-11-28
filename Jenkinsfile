pipeline {
    agent any

    options {
        ansiColor('xterm')
        buildDiscarder(logRotator(
            numToKeepStr: '4', // Keep only the last 4 builds
            artifactNumToKeepStr: '4' // Keep artifacts of only the last 4 builds
        ))
    }

    parameters {
        string(name: 'ENV', defaultValue: 'dev', description: 'Specify the target environment for deployment.')
    }

    environment {
        BADGE_NAME = "Terraform Deployment" // Name of the badge
    }

    stages {
        stage('Set Build Badge') {
            steps {
                script {
                    currentBuild.description = "${BADGE_NAME}: In Progress 🔵"
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                sh "make ${params.ENV}"
            }
        }
    }

    post {
        success {
            script {
                currentBuild.description = "${BADGE_NAME}: Success ✅"
            }
        }
        failure {
            script {
                currentBuild.description = "${BADGE_NAME}: Failed ❌"
            }
        }
        always {
            cleanWs() // Clean workspace after every build
        }
    }
}
