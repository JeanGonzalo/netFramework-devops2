#Get location project
param(
    [Parameter()]
    [string] $nameProject
)

$location=Get-Location
$dirToCompress="$location/$nameProject"

#Exclude files or directories
$dirToExclude= "obj", "Web.config", "$nameProject.csproj", "AzulIS.AzMan.xml", "$nameProject.csproj.user", "Classes", "Controllers", "Helpers", "Models", "Properties"
$dirDestination="$location/$nameProject.zip"

#Zip binaries
$file=Get-ChildItem -Path $dirToCompress -Exclude  $dirToExclude
Compress-Archive -path $file -DestinationPath $dirDestination -CompressionLevel fastest -Update

