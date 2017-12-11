Import-Module PSReadLine
Set-PSReadlineOption -EditMode Emacs -BellStyle None

pushd c:\z\home\keyamada\

Import-Module posh-git
Start-SshAgent
# ssh-add c:\z\home\keyamada\.ssh\id_ed25519

# Functions
function ll {
  Get-ChildItem | Sort-Object
}

# Alias
# Set-Alias -Name "alias name" -Value "original command"
# Remove-Item alias:....
Set-Alias -Name "np" -Value "notepad++"
