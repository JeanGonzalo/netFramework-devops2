import hudson.model.*
import hudson.EnvVars
import groovy.json.JsonSlurperClassic
import groovy.json.JsonBuilder
import groovy.json.JsonOutput
import java.net.URL
import java.net.URLEncoder
@Library('blueLibs@feat/pipeline') _
bluePipeline(
    netBuild: "--version",
    projectName: "blue-libraries-sonarqube",
    platform: "Debug",
    zipName: "ContosoUniversity",
    nexusPublish: "ContosoUniversity"
)