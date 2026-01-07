param([string[]]$files = @("usecase","repository"),
[string]$targetFolder = "."
)
foreach ($file in $files) {
    New-Item "$targetFolder\$file.dart" -ItemType File -Force
}

Write-Host "Created files in folder:" $targetFolder