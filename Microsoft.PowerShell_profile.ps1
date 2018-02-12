Import-Module PSReadLine
Set-PSReadlineOption -EditMode Emacs -BellStyle None

pushd c:\z\home\keyamada\

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

# Alias
# Set-Alias -Name "alias name" -Value "original command"
# Remove-Item alias:....
Set-Alias -Name "np" -Value "notepad++"
Set-Alias -Name "vi" -Value "gvim"
Set-Alias -Name "7z" -Value "C:\Program Files\7-Zip\7z.exe"
