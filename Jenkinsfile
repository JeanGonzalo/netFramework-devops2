import hudson.model.*
import hudson.EnvVars
import groovy.json.JsonSlurperClassic
import groovy.json.JsonBuilder
import groovy.json.JsonOutput
import java.net.URL
import java.net.URLEncoder

@NonCPS
def jsonParse(def json) {
    new groovy.json.JsonSlurperClassic().parseText(json)
}

pipeline {
  agent {label "windowsnet"}


  environment {
      // General Variables for Pipeline
      PROJECT_ROOT = 'project-test'
      SONAR_HOST_URL = 'http://192.168.1.34:9001'
      SONAR_AUTH_TOKEN = '6d04544a33272dddd889aef89ee658badc6009b2'
      NEXUS_URL = "http://192.168.1.34:8081"
      NEXUS_REPOSITORY = "nuget-hosted"
      PATHH = "D:\\jenkins\\workspace\\blue-project"
      PLATFORM= "Debug"

  }

  stages {

      stage('Checkout') {
        steps {
        // Get Github repo using Github credentials (previously added to Jenkins credentials)
        checkout([$class: 'GitSCM', branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/JeanGonzalo/netFramework-devops2.git']]])        }
      }
    
      stage("SonarQube - Static Code Analysis") {
            steps {
                script {
                    

                        bat  " sonar-scanner -X -D sonar.host.url=${SONAR_HOST_URL} \
                              -D sonar.login=${SONAR_AUTH_TOKEN} \
                              -D sonar.projectKey=${PROJECT_ROOT} \
                              -D sonar.projectName=${PROJECT_ROOT} "
                            //-Dsonar.projectVersion='${projectVersion}' ${pullRequestParams} \
                }
            }
      }

      stage("Build .net framework") {
            steps {
                script {
                    
                        bat  " MsBuild.exe --version"
                        //powershell  "MsBuild.exe /t:Clean && MsBuild.exe /t:Rebuild"
                        //powershell "MSBuild.exe ContosoUniversity.sln /p:Configuration=Release"
                }
            }
      }

      stage("Publish to Nexus Repository Manager") {
            steps {
                script {   
                            // bat "cd ContosoUniversity/bin && tar -a -c -f ${PLATFORM}.zip ${PLATFORM} && dir" 
                            // bat "copy ContosoUniversity/bin/${PLATFORM}.zip . && cd , && dir"
                            // bat "echo testtttttt"                           
                            sh "curl --fail -u admin:jeandevops --upload-file ./bin.zip 'http://192.168.1.34:8081/repository/nuget2-raw/bin.zip'"
                            
                            // def binaries = context.findFiles(glob: '*.zip')
                            //     binaries.each { item ->
                            //         sh "curl -v --user 'admin:jeandevops' --upload-file {item}  http://localhost:8081/repository/nuget-raw/bin.zip'"
                            //     }
                    
                            //bat "dir && cd ContosoUniversity && cd , && dir"
                            
                            // bat "dir \
                            // cd ContosoUniversity \
                            // cd , \
                            // dir"
                            //bat "zip bin2.zip bin/"

                            //bat  "dotnet nuget push '${PATHH}/**/*.nupkg' --source ${NEXUS_URL}/repository/${NEXUS_REPOSITORY}"
                }
            }
      }
  }
}

// Function to validate that the message returned from SonarQube is ok
def qualityGateValidation(qg) {
  if (qg.status != 'OK') {
    return true
  }
  return false
}