$Fields = Import-csv -Path "C:\Projects\Powershell-Automation\Cisco-CollaborationManager-PowerShell\Sources\helpers\object.csv" -Header Field

Write-Host "`$hash = [ordered]@{"
$Fields | ForEach-Object {
    Write-Host @"
    '$($_.Field)'      = `$_.vendorConfig.$($_.Field)
"@
}
Write-Host "}"
