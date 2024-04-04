# psminnifyer
A simple script to minify your pwsh scripts(not tested for all scripts)
use age with [ps12exe](https://github.com/steve02081504/ps12exe):

```powershell
ps12exe ./main.ps1 -Minifyer { $_ | &./psminnifyer.ps1 }
```
