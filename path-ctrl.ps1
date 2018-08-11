$testpath = "C:\z\msys64\mingw64\bin"

$oldpath = $env:PATH

Write-Host $oldpath

$path_array = $oldpath -split (";")

$newpath = $path_array -join (";")

$newpath -ceq $oldpath

# $colors = $colors | where {$_ -ne "yellow"}

function script:exist-path {
    Param(
        [Parameter(Mandatory = $true)]
        [string] $targetPath,
        [Parameter(Mandatory = $true)]
        [string[]]$paths
    )
    "$targetPath does not exist in the current path."    
}
function script:append-path {
    Param(
        [Parameter(Mandatory = $true)]
        [string] $path
    )
    $path        
}

function prepend-path {
    Param(
        [Parameter(Mandatory = $true)]
        [string] $path
    )
    $path
}

exist-path $testpath $path_array
