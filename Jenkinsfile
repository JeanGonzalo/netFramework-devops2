import hudson.model.*
import hudson.EnvVars
import groovy.json.JsonSlurperClassic
import groovy.json.JsonBuilder
import groovy.json.JsonOutput
import java.net.URL
import java.net.URLEncoder

@Library('blueLibs') _
pipeline {
  agent {label "windowsnet"}


  environment {
      // General Variables for Pipeline
      PROJECT_ROOT = 'project-test'
      SONAR_HOST_URL = 'http://192.168.1.34:9001'
      SONAR_AUTH_TOKEN = '6d04544a33272dddd889aef89ee658badc6009b2'
      NEXUS_URL = "http://192.168.1.34:8081"
      NEXUS_REPOSITORY = "nuget-hosted"
      //PATHH = "D:\\jenkins\\workspace\\blue-project"
      PLATFORM= "Debug"

  }

  stages {

      stage('Checkout') {
        steps {
        // Get Github repo using Github credentials (previously added to Jenkins credentials)
        checkout([$class: 'GitSCM', branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/JeanGonzalo/netFramework-devops2.git']]])        }
      }
    
      stage("Build .net framework") {
            steps {
                script {
                        pipelineLibs.netFrameworkBuild(netBuild: "--version")
                }
            }
      }

      stage("SonarQube - Static Code Analysis") {
            steps {
                script {
                        pipelineLibs.sonarqubeBuild(sonarUrl: "${SONAR_HOST_URL}",
                                                    sonarToken: "${SONAR_AUTH_TOKEN}",
                                                    projectName: "blue-libraries-test")
                }
            }
      }      

      stage("Publish to Nexus Repository Manager") {
            steps {
                script {   
                        pipelineLibs.publishNexus(platform: "Debug")  
                }
            }
      }
  }
}

