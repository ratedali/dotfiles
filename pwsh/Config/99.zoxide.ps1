
if (Get-Command -Name zoxide -ErrorAction SilentlyContinue) {
  Invoke-Expression (& { (zoxide init powershell --hook pwd | Out-String) })
  Write-Verbose "zoxide initialized successfully."
}
else {
  Write-Warning "zoxide command not found. Skipping initialization."
}
