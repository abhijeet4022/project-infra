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
                    currentBuild.description = "<img src='https://img.shields.io/badge/${BADGE_NAME}-InProgress-blue' alt='Build Badge'/>"
                }
            }
        }

        stage('Terraform Apply') {
            steps {
//                 sh "make ${params.ENV}"
                    sh 'ls -A'
                    sh 'pwd'
                    sh 'git status'
            }
        }
    }

    post {
        success {
            script {
                currentBuild.description = "<img src='https://img.shields.io/badge/${BADGE_NAME}-Success-green' alt='Build Badge'/>"
            }
        }
        failure {
            script {
                currentBuild.description = "<img src='https://img.shields.io/badge/${BADGE_NAME}-Failed-red' alt='Build Badge'/>"
            }
        }
        always {
            cleanWs() // Clean workspace after every build
        }
    }
}
