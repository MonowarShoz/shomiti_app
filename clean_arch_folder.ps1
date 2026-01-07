param(
    [string]$featureFolder = ".",
    [string[]]$subfolders = @(
    "data\datasource\remote\model",
    "data\datasource\remote\",
    "data\provider",
    "data\repository",
    "domain\usecase",
    "domain\provider",
    "domain\repository",
    "presentation\provider",
    "presentation\widget"
)
)

foreach ($sub in $subfolders) {
    $fullPath = Join-Path $featureFolder $sub
    if(-not (Test-Path $fullPath)) {
        New-Item -Path $fullPath -ItemType Directory -Force | Out-Null
        Write-Host "Created subfolder: $fullPath"
    } else {
        Write-Host "Subfolder already exists: $fullPath"
    }
}

Write-Host "All subfolders created succesfully inside $featureFolder!"