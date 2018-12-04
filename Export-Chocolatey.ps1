#Put this in Export-Chocolatey.ps1 file and run it:
#Export-Chocolatey.ps1 > packages.config
#You can install the packages using
#choco install packages.config -y

Write-Output "<?xml version=`"1.0`" encoding=`"utf-8`"?>"
Write-Output "<packages>"
choco list -lo -r -y | % { "   <package id=`"$($_.SubString(0, $_.IndexOf("|")))`" />" } | Select-String "chocolatey" -NotMatch | % { $_.Line }
Write-Output "</packages>"
