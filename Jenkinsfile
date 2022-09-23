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
                    

                        powershell  " sonar-scanner -X -D sonar.host.url=${SONAR_HOST_URL} \
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

                        //powershell "MsBuild.exe --version"
                        //powershell "MsBuild.exe /t:Clean"
                        powershell  " MsBuild.exe /t:Rebuild /p:Platform="Any CPU" "
                        //bat "MSBuild.exe /t:Rebuild /p:Configuration=Release -maxcpucount:3"
                }
            }
      }

      stage("Publish to Nexus Repository Manager") {
            steps {
                script {   
                            bat "cd ContosoUniversity/bin && tar -a -c -f ${PLATFORM}.zip ${PLATFORM} && dir" 
                            bat "copy ContosoUniversity\\bin\\${PLATFORM}.zip . && cd , && dir"                          
                            bat "curl --fail -u admin:jeandevops --upload-file ./${PLATFORM}.zip http://192.168.1.34:8081/repository/nuget2-raw/${PLATFORM}.zip"
                            
                }
            }
      }

      // stage("Deploy IIS") {
      //       steps {
      //           script {   
      //                       // stop IIS
      //                       bat "\$server = New-PSSession -Name AppServer -ComputerName ${​​​​​​deployProperties.SERVER}​​​​​​ -Credential (New-object System.Management.Automation.PSCredential -ArgumentList @('${​​​​​​script.env.USERNAME}​​​​​​',('${​​​​​​script.env.PASS}​​​​​​'|ConvertTo-secureString -AsPlainText -Force)));Invoke-Command -Session \$server -ScriptBlock {​​​​​​Stop-WebSite -Name '${​​​​​​deployProperties.SITE_NAME}​​​​​​';}​​​​​​"

      //                       // copy file
      //                       bat "\$server = New-PSSession -Name server -ComputerName ${​​​​​​deployProperties.SERVER}​​​​​​ -Credential (New-object PSCredential -ArgumentList @('${​​​​​​script.env.USERNAME}​​​​​​', ('${​​​​​​script.env.PASS}​​​​​​'
      //                           |ConvertTo-secureString -AsPlainText -Force)));Copy-Item –Path ${​​​​​​script.env.WORKSPACE}​​​​​​\\target\\${​​​​​​deployProperties.ARTIFACT_FOLDER}​​​​​​\\** –Destination '${​​​​​​deployProperties.SITE_PATH}​​​​​​' -Recurse -force –ToSession \$server;"

      //                       //start Site
      //                       bat "\$server = New-PSSession -Name AppServer -ComputerName ${​​​​​​deployProperties.SERVER}​​​​​​ -Credential (New-object System.Management.Automation.PSCredential -ArgumentList @('${​​​​​​script.env.USERNAME}​​​​​​',('${​​​​​​script.env.PASS}​​​​​​'
      //                           |ConvertTo-secureString -AsPlainText -Force)));Invoke-Command -Session \$server -ScriptBlock {​​​​​​Start-WebSite -Name '${​​​​​​deployProperties.SITE_NAME}​​​​​​';}​​​​​​"
      //           }
      //       }
      // }
  }
}

