#Get location project
$location=Get-Location
$nameProject="ContosoUniversity"
$dirToCompress="$location/$nameProject"
#Exclude files or directories
$dirToExclude= "Web.config", "Properties", "obj", "Content", "Controllers"
$dirDestination="$location/blueproject.zip"
#Zip binaries
$file=Get-ChildItem -Path $dirToCompress -Exclude  $dirToExclude
Compress-Archive -path $file -DestinationPath $dirDestination -CompressionLevel fastest -Update