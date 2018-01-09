Import-Module PSReadLine
Set-PSReadlineOption -EditMode Emacs -BellStyle None

pushd c:\z\home\keyamada\
(get-psprovider 'FileSystem').Home = $env:HOME

Import-Module posh-git
Start-SshAgent
# ssh-add c:\z\home\keyamada\.ssh\id_ed25519

Import-Module PSFzf -ArgumentList 'Ctrl+T','Ctrl+R'

# Functions
function ll {
  Get-ChildItem | Sort-Object
}

# Alias
# Set-Alias -Name "alias name" -Value "original command"
# Remove-Item alias:....
Set-Alias -Name "np" -Value "notepad++"
Set-Alias -Name "vi" -Value "gvim"
