# .\download_gh.ps1 yuru7/HackGen HackGen_NF
# .\download_gh.ps1 yuru7/moralerspace MoralerspaceNF

param (
    [Parameter(Position = 0, Mandatory = $true)]
    [string]$Repo,

    [Parameter(Position = 1, Mandatory = $true)]
    [string]$Prefix
)

# Function to download GitHub release assets
function Download-GHRelease {
    param (
        [string]$Repo,
        [string]$Prefix
    )

    Write-Host "Downloading $Prefix from GitHub repository: $Repo"

    # Get the latest release information from the GitHub API
    $apiUrl = "https://api.github.com/repos/$Repo/releases/latest"
    $response = Invoke-RestMethod -Uri $apiUrl -UseBasicParsing

    # Find the download URL for the asset with the specified prefix
    $downloadUrl = $response.assets | Where-Object { $_.name -like "$Prefix*" } | Select-Object -ExpandProperty browser_download_url

    if ($null -ne $downloadUrl) {
        Write-Host "Download URL: $downloadUrl"
        # Download the file
        Invoke-WebRequest -Uri $downloadUrl -OutFile (Split-Path $downloadUrl -Leaf)
    } else {
        Write-Host "No asset found with prefix '$Prefix' in repository '$Repo'"
    }
}

# Main script
Download-GHRelease -Repo $Repo -Prefix $Prefix
