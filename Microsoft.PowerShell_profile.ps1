Import-Module PSReadLine
Set-PSReadlineOption -EditMode Emacs

pushd c:\z\home\keyamada\

Import-Module posh-git
Start-SshAgent
ssh-add c:\z\home\keyamada\.ssh\id_ed25519-2
