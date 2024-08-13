def registry = 'https://valaxy786.jfrog.io/'

pipeline {
    agent {
        node {
            label 'maven'
        }
    }
    environment {
        PATH = "/opt/apache-maven-3.9.4/bin:$PATH"
    }

    stages {
        stage('build') {
            steps {
                sh 'mvn clean deploy'
            }
        }
        // stage("SonarQube Analysis") {
        //     environment {
        //          scannerHome= tool 'valaxy-sonar-scanner'
        //     }
        //     steps {
        //         withSonarQubeEnv('valaxy-soanrqube-server'){
        //             sh "${scannerHome}/bin/sonar-scanner"
        //         }
        //     }
        // }

            
            stage("Jar Publish") {
            steps {
                script {
                         def server = Artifactory.newServer url:registry+"/artifactory" ,  credentialsId:"artifact-cred"
                         def properties = "buildid=${env.BUILD_ID},commitid=${GIT_COMMIT}";
                         def uploadSpec = """{
                              "files": [
                                {
                                  "pattern": "jarstaging/(*)",
                                  "target": "libs-release-local/{1}",
                                  "flat": "false",
                                  "props" : "${properties}",
                                  "exclusions": [ "*.sha1", "*.md5"]
                                }
                             ]
                         }"""
                         def buildInfo = server.upload(uploadSpec)
                         buildInfo.env.collect()
                         server.publishBuildInfo(buildInfo)                
                    }
            }   
        }  
    }
}
