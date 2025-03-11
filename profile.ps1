Remove-Alias -Name cat
# Remove-Alias -Name cd
Remove-Alias -Name chdir
Remove-Alias -Name copy
Remove-Alias -Name cp
# Remove-Alias -Name curl
Remove-Alias -Name del
Remove-Alias -Name diff -Force
Remove-Alias -Name echo
Remove-Alias -Name ls
Remove-Alias -Name md
Remove-Alias -Name mv
# Remove-Alias -Name wget
Remove-Alias -Name rm
set LANG=ja_JP.UTF-8
set LESSCHARSET=utf-8

function hb($prjname) {
  if (Test-Path -Path "./.venv") {
    deactivate
  }
  cd "C:/Users/proch/Desktop/homebrew/homebrew/$prjname"  # このhomebrewはmacのパッケージ管理マネージャーとは関係なし
  if (Test-Path -Path "./.venv") {
    ./.venv/Scripts/activate
  }
}

function Edit-Posh-Profile {
  hx C:/Users/proch/Documents/PowerShell/profile.ps1
}

function Edit-Ohmyposh-Profile {
  hx C:\Users\proch\Desktop\apps\themes\1_shell.omp.json
}

function Edit-Term-Profile {
  hx C:\Users\proch\appData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json
}

function Add-License {
  param (
    [string]$msg = "ライセンスを追加"
  )
  Write-Output(@"
MIT License

Copyright (c) {0} shizukani-cp

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
"@ -f (Get-Date).Year ) > LICENSE.txt
  git add LICENSE.txt
  git commit -m "${msg}"
}

oh-my-posh init pwsh --config $env:POSH_THEMES_PATH/1_shell.omp.json | Invoke-Expressions
