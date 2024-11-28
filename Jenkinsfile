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
        choice(name: 'ACTION', choices: ['create', 'destroy'], description: 'Choose whether to create or destroy infrastructure.')
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

        stage('Terraform Action') {
            steps {
                script {
                    if (params.ACTION == 'create') {
                        sh "make ${params.ENV}"
                    } else if (params.ACTION == 'destroy') {
                        sh "make ${params.ENV}-destroy"
                    } else {
                        error("Invalid ACTION parameter: ${params.ACTION}")
                    }
                }
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
