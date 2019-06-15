Import-Module PSReadLine
Set-PSReadlineOption -EditMode Emacs -BellStyle None

Push-Location c:\z\home\kyamada\

(get-psprovider 'FileSystem').Home = $env:HOME

Import-Module posh-git
$GitPromptSettings.DefaultPromptSuffix = '`n$(''>'' * ($nestedPromptLevel + 1)) '
$GitPromptSettings.DefaultPromptAbbreviateHomeDirectory = $true

Start-SshAgent
# ssh-add c:\z\home\keyamada\.ssh\id_ed25519
# Add-SshKey c:\z\home\keyamada\.ssh\id_ed25519

Import-Module PSFzf -ArgumentList 'Ctrl+T','Ctrl+R'

# Functions
function ll {
  Get-ChildItem | Sort-Object
}

function g {
  git $args
}

function diff {
  c:\z\msys64\usr\bin\diff $args
}

function vmrun {
  C:\Program` Files` `(x86`)\VMware\VMware` Workstation\vmrun.exe $args
}

# https://qiita.com/Kosen-amai/items/4b773c077a588f2a2fb5
Add-Type -AssemblyName System.Windows.Forms

<#
.SYNOPSIS
    コンピューターをサスペンド
#>
function Invoke-SleepComputer
{
    $state = [System.Windows.Forms.PowerState]::Suspend
    [bool]$force = $true
    [bool]$disableWakeEvent = $false

    [System.Windows.Forms.Application]::SetSuspendState($state, $force, $disableWakeEvent)
}

function Invoke-CommandRunAs
{
    $cd = (Get-Location).Path
    $commands = "Set-Location $cd; Write-Host `"[Administrator] $cd> $args`"; $args; Pause; exit"
    $bytes = [System.Text.Encoding]::Unicode.GetBytes($commands)
    $encodedCommand = [Convert]::ToBase64String($bytes)
    Start-Process powershell.exe -Verb RunAs -ArgumentList "-NoExit","-encodedCommand",$encodedCommand
}

Set-Alias sudo Invoke-CommandRunAs

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
  C:\z\home\keyamada\go\bin\ghq list | Invoke-Fzf | ForEach-Object { Set-Location "${env:HOME}/.ghq/$_" }
}
# Set-PSReadlineKeyHandler -Chord Ctrl+T -Function gs

# Alias
# Set-Alias -Name "alias name" -Value "original command"
# Remove-Item alias:....
Set-Alias -Name "np" -Value "notepad++"
Set-Alias -Name "vi" -Value "gvim"
Set-Alias -Name "7z" -Value "C:\Program Files\7-Zip\7z.exe"

$env:LESS='-gmrX'

