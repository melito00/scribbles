# Copyright (C) 1997-2023 by Kenji Yamada

# Install-Module PSReadLine
Import-Module PSReadLine
Set-PSReadlineOption -EditMode Emacs -BellStyle None

$HomeDir = "C:\Users\kyamada\"
Set-Item env:HOME -Value $HomeDir
# (get-psprovider 'FileSystem').Home = $HomeDir
# pushd c:\z\home\kyamada\

Set-Item env:XDG_CONFIG_HOME -Value "${HomeDir}config"

# scoop install oh-my-posh
# Invoke-Expression (oh-my-posh --init --shell pwsh --config C:\Users\kyamada\scoop\apps\oh-my-posh\current\themes\powerlevel10k_classic.omp.json)
Invoke-Expression (oh-my-posh --init --shell pwsh --config C:\Users\kyamada\scoop\apps\oh-my-posh\current\themes\negligible.omp.json)

Set-Item env:GIT_SSH -Value C:\windows\System32\OpenSSH\ssh.exe

# Install-Module -Scope CurrentUser posh-git
Import-Module posh-git
Import-Module posh-sshell
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
if (Get-Command "bat.exe" -ErrorAction SilentlyContinue) {
	function cat {
		bat.exe $args
	}
}

if (Get-Command "eza.exe" -ErrorAction SilentlyContinue) {
	function ls {
		eza.exe -F $args
	}
}

if (Get-Command "ghq.exe" -ErrorAction SilentlyContinue) {
  function gq {
    ghq.exe list | Invoke-Fzf | % { Set-Location "$(ghq root)/$_" }
  }
}

if (Get-Command "goneovim.exe" -ErrorAction SilentlyContinue) {
  function vi {
    param (
      [string[]]$Arguments
    )

    if ($Arguments.Length -eq 0) {
      Start-Process -FilePath "goneovim.exe" -WindowStyle Hidden
    } else {
      Start-Process -FilePath "goneovim.exe" -ArgumentList $Arguments -WindowStyle Hidden
    }
  }
}

function code {
    Start-Process "C:\Users\kyamada\AppData\Local\Programs\Microsoft VS Code\bin\code.cmd" -ArgumentList $args
}

# Set-PSReadlineKeyHandler -Chord Ctrl+x,Ctrl+f -ScriptBlock { ghq.exe list | Invoke-Fzf | % { Set-Location "$(ghq root)/$_" } }

# Alias
# Set-Alias -Name "alias name" -Value "original command"
# Remove-Item alias:....
Set-Alias -Name "np" -Value "C:\Program Files\Notepad++\notepad++.exe"
#Set-Alias -Name "vi" -Value "gvim"
# Set-Alias -Name "7z" -Value "C:\Program Files\7-Zip\7z.exe"
# Remove-Item alias:curl
# Set-Alias -Name "curlcmd" -Value "$(scoop prefix curl)\bin\curl.exe"

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

Set-Item env:LANG -Value ja_JP.UTF-8
Set-Item env:VAGRANT_DEFAULT_PROVIDER -Value hyperv

if (Get-Command "fnm.exe" -ErrorAction SilentlyContinue) {
  fnm env --use-on-cd | Out-String | Invoke-Expression
}
