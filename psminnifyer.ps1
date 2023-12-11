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
$Content = $Content -ireplace '\| ForEach-Object', '|ForEach-Object'
$Content = $Content -replace '\.\s*\$', '.$'
$Content = $Content -replace '\&\s*\$', '&$'
$Content = $Content -replace '\s*\,\s*', ','
$Content = $Content -replace '\]\n', ']'
$CommandJoiner = "as|and|cas|ccontains|ceq|cge|cgt|cin|cis|ciscontains|cislike|cisnot|cisnotcontains|cisnotin|cisnotlike|cisnotnull|cisnull|cjoin|cle|clike|clt|cmatch|cne|cnotcontains|cnotin|cnotlike|cnotmatch|contains|creplace|csplit|eq|ge|gt|ias|icontains|ieq|ige|igt|iin|iis|iiscontains|iisin|iislike|iisnot|iisnotcontains|iisnotin|iisnotlike|iisnotnull|iisnull|ijoin|ile|ilike|ilt|imatch|in|ine|inotcontains|inotin|inotlike|inotmatch|ireplace|is|iscontains|isin|islike|isnot|isnotcontains|isnotin|isnotlike|isnotnull|isnull|isplit|join|le|like|lt|match|ne|not|notcontains|notin|notlike|notmatch|replace|split"
$Content = $Content -ireplace "\-($CommandJoiner)\s+(\""|\'|\@|\[|\{|\$|\()", '-$1$2'
$Content = $Content -ireplace "([a-zA-Z_])\s+\-($CommandJoiner)", '$1-$2'
$Content = $Content -ireplace "\-($CommandJoiner)\s+([0-9])", '-$1$2'

$AliasTable = . $PSScriptRoot/alias.ps1

$AliasTable.GetEnumerator() | ForEach-Object {
	$Content = $Content -iReplace $_.Value, $_.Name
}

if ($OutputFile) { $Content | Out-File $OutputFile -Encoding utf8 }
else { $Content }
