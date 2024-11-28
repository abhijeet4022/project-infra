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


stages{
steps('Infra Deploymnet'){
sh "make ${env.ENV}"


}
}




}