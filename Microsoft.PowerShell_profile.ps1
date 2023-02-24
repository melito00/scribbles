# Copyright (C) 1997-2023 by Kenji Yamada

# Install-Module PSReadLine
Import-Module PSReadLine
Set-PSReadlineOption -EditMode Emacs -BellStyle None

$HomeDir = "C:\z\home\kyamada\"
Set-Item env:HOME $HomeDir
(get-psprovider 'FileSystem').Home = $HomeDir
pushd c:\z\home\kyamada\

# scoop install oh-my-posh
# Invoke-Expression (oh-my-posh --init --shell pwsh --config C:\Users\kyamada\scoop\apps\oh-my-posh\current\themes\powerlevel10k_classic.omp.json)
Invoke-Expression (oh-my-posh --init --shell pwsh --config C:\Users\kyamada\scoop\apps\oh-my-posh\current\themes\negligible.omp.json)

set-item env:GIT_SSH -value C:\windows\System32\OpenSSH\ssh.exe

# Install-Module -Scope CurrentUser posh-git
Import-Module posh-git
$GitPromptSettings.DefaultPromptSuffix = '`n$(''>'' * ($nestedPromptLevel + 1)) '
$GitPromptSettings.DefaultPromptAbbreviateHomeDirectory = $true

Start-SshAgent
# ssh-add c:\z\home\keyamada\.ssh\id_ed25519
# Add-SshKey c:\z\home\keyamada\.ssh\id_ed25519

# Install-Module -Scope CurrentUser PSFzf
# scoop install fzf
# Import-Module PSFzf -ArgumentList 'Ctrl+T','Ctrl+R'
Import-Module PSFzf
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+r'

# Functions
function ll {
  Get-ChildItem | Sort-Object
}

function g {
  git $args
}

function code {
  C:\Users\kyamada\work\VSCode-win32-x64-1.42.0-insider\Code` -` Insiders.exe $args
}

function diff {
  c:\z\msys64\usr\bin\diff $args
}

function vmrun {
  C:\Program` Files` `(x86`)\VMware\VMware` Workstation\vmrun.exe $args
}

function Invoke-CommandRunAs
{
    $cd = (Get-Location).Path
    $commands = "Set-Location $cd; Write-Host `"[Administrator] $cd> $args`"; $args; Pause; exit"
    $bytes = [System.Text.Encoding]::Unicode.GetBytes($commands)
    $encodedCommand = [Convert]::ToBase64String($bytes)
    Start-Process powershell.exe -Verb RunAs -ArgumentList "-NoExit","-encodedCommand",$encodedCommand
}

# Set-Alias sudo Invoke-CommandRunAs

function Start-RunAs
{
    $cd = (Get-Location).Path
    $commands = "Set-Location $cd; (Get-Host).UI.RawUI.WindowTitle += `" [Administrator]`""
    $bytes = [System.Text.Encoding]::Unicode.GetBytes($commands)
    $encodedCommand = [Convert]::ToBase64String($bytes)
    Start-Process powershell.exe -Verb RunAs -ArgumentList "-NoExit","-encodedCommand",$encodedCommand
}

Set-Alias su Start-RunAs

function gs {
  C:\z\home\keyamada\go\bin\ghq list | Invoke-Fzf | % { Set-Location "${env:HOME}/.ghq/$_" }
}
# Set-PSReadlineKeyHandler -Chord Ctrl+T -Function gs

# Alias
# Set-Alias -Name "alias name" -Value "original command"
# Remove-Item alias:....
Set-Alias -Name "np" -Value "notepad++"
Set-Alias -Name "vi" -Value "gvim"
# Set-Alias -Name "7z" -Value "C:\Program Files\7-Zip\7z.exe"
# Remove-Item alias:curl
Set-Alias -Name "curlcmd" -Value "$(scoop prefix curl)\bin\curl.exe"

# For uutils coreutils
# scoop install uutils-coreutils
@"
  arch, base32, base64, basename, cat, cksum, comm, cp, cut, date, df, dircolors, dirname,
  echo, env, expand, expr, factor, false, fmt, fold, hashsum, head, hostname, join, link, ln,
  ls, md5sum, mkdir, mktemp, more, mv, nl, nproc, od, paste, printenv, printf, ptx, pwd,
  readlink, realpath, relpath, rm, rmdir, seq, sha1sum, sha224sum, sha256sum, sha3-224sum,
  sha3-256sum, sha3-384sum, sha3-512sum, sha384sum, sha3sum, sha512sum, shake128sum,
  shake256sum, shred, shuf, sleep, sort, split, sum, sync, tac, tail, tee, test, touch, tr,
  true, truncate, tsort, unexpand, uniq, wc, whoami, yes
"@ -split ',' |
ForEach-Object { $_.trim() } |
Where-Object { ! @('tee', 'sort', 'sleep').Contains($_) } |
ForEach-Object {
    $cmd = $_
    if (Test-Path Alias:$cmd) { Remove-Item -Path Alias:$cmd }
    $fn = '$input | uutils ' + $cmd + ' $args'
    Invoke-Expression "function global:$cmd { $fn }" 
}

# Chocolatey profile
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}

Set-Item env:LANG -Value ja_JP.UTF-8
Set-Item env:VAGRANT_DEFAULT_PROVIDER -Value hyperv

if (Get-Command fnm.exe -ErrorAction SilentlyContinue) {
  fnm env --use-on-cd | Out-String | Invoke-Expression
}
