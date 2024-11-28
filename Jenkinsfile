pipeline {
        agent any

        options {
            ansiColor('xterm')
            buildDiscarder(logRotator(
                    numToKeepStr: '4',   // Keep only the last 4 builds
                    artifactNumToKeepStr: '4' // Keep artifacts of only the last 4 builds
            ))
        }

        parameters {
            string(name: 'ENV', defaultValue: 'dev', description: 'Specify the target environment for deployment.')
        }

        environment {
            // Sets up an environment variable to securely pass SSH credentials for remote access for ansible.
            SSH = credentials('366954ce-8f22-4117-b10d-0717e4aefcb9')
        }
}