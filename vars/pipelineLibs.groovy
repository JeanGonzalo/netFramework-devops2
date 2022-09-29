def sonarqubeBuild(Map params){
    powershell  " sonar-scanner -X -D sonar.host.url=${params.sonarUrl} \
                    -D sonar.login=${params.sonarToken} \
                    -D sonar.projectKey=${params.projectName} \
                     -D sonar.projectName=${params.projectName} "                        
}

def netFrameworkBuild(Map params){
    powershell "MsBuild.exe /t:${params.netBuild}"
}

def publishNexus(Map params){
    bat "cd ContosoUniversity/bin && tar -a -c -f ${params.platform}.zip ${params.platform} && dir" 
    bat "copy ContosoUniversity\\bin\\${params.platform}.zip . && cd , && dir"                          
    bat "curl --fail -u admin:jeandevops --upload-file ./${params.platform}.zip http://192.168.1.34:8081/repository/nuget2-raw/${params.platform}.zip"                   
}