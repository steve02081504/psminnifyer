param(
	[string]$inputFile,
	[string]$OutputFile
)
$Content = if($inputFile){
	Get-Content $inputFile -Encoding utf8 -Raw
}else{
	$Input | Out-String
}
# ;换为换行
$Content = $Content -replace ';\n', "`n"
$Content = $Content -replace '\r\n', "`n"
# 分割
$Content = $Content -split "`n"
# 移除所有的开头和结尾的空格和制表符
$Content = $Content | ForEach-Object { $_.Trim() }
# 移除所有的空行
$Content = $Content | Where-Object { $_ }
# 移除所有的注释
$Content = $Content | Where-Object { $_ -notmatch '^#' }
$Content = $Content -join "`n"
$Content = $Content -replace '\s*\=\s*', '='
$Content = $Content -replace '[ \t]*\{\s*', '{'
$Content = $Content -replace '\s*\}[ \t]*', '}'
$Content = $Content -replace '\s*\(\s*', '('
$Content = $Content -replace '\s*\)[ \t]*', ')'
$Content = $Content -replace '\| ForEach-Object', '|ForEach-Object'
$Content = $Content -replace '\.\s*\$', '.$'
$Content = $Content -replace '\&\s*\$', '&$'
$Content = $Content -replace '\s*\,\s*', ','
$Content = $Content -replace '\]\n', ']'
if ($OutputFile) {
	$Content | Out-File $OutputFile -Encoding utf8
}
else {
	$Content
}
