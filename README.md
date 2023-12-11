# psminnifyer
A simple script to minify your pwsh scripts(not tested for all scripts)
use age with [ps2exe](https://github.com/steve02081504/PS2EXE):

```powershell
& $PSScriptRoot/ps2exe.ps1 $PSScriptRoot/main.ps1 -NoConsole -Minifyer { $_ | &$PSScriptRoot/psminnifyer.ps1 }
```
