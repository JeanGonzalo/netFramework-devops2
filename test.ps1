$frase = Read-Host "Introduce una frase"
$letra = Read-Host "Introduce una letra"
$aparaciones = 0

for($i = 0; $i -lt $frase.Length; $i++){
    if($frase[$i] -eq $letra){
        $aparaciones++
    }
}

Write-Host "Aparece $aparaciones veces"