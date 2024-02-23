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
		<# Escrevendo algo parecido com o que tu procura no lugar de Datasheets.

		o script funcionará perfeitamente procurando aquilo que voce digitou #>
if ($tipoDeExportacao -eq "HTML") {
		$resultado | 
		ConvertTo-Html  |
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