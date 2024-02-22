param($tipoDeExportacao)
$ErrorActionPreference = "Stop"

$nameExpr = @{
	Label = "Nome";
	Expression = { $_.Name }
}
$lengthExprt = @{
	Label = "Tamanho ";
	Expression = {"{0:N2}KB" -f ($_.Length / 1KB)}
}
$params = $nameExpr, $lengthExprt

$resultado =
	gci -Recurse -File |
		? Name -like "*_Datasheet_*" | 
			select $params
			
if ($tipoDeExportacao -eq "HTML") {
		$tituloPagina = "Datasheets na pasta"
		$resultado | 
		ConvertTo-Html -Title $tituloPagina |
		Out-File C:\tempLucas\relatorio.html 
} elseif ($tipoDeExportacao -eq "JSON") {
	
	$resultado | 
		ConvertTo-JSON  |
		Out-File C:\tempLucas\relatorio.JSON 
	
} elseif ($tipoDeExportacao -eq "CSV"){
	
	$resultado | 
		ConvertTo-CSV   |
		Out-File C:\tempLucas\relatorio.CSV  
}