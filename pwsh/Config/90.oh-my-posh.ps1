$Script:_ompPath = Split-Path -Path $PSScriptRoot -Parent | Join-Path -ChildPath "default.omp.json"

if (Test-Path -Path $_ompPath -PathType Leaf) {
  Write-Verbose "Loading Oh My Posh configuration from $_ompPath"
  oh-my-posh --init --shell pwsh --config $_ompPath | Invoke-Expression
}
else {
  Write-Warning "Oh-My-Posh configuration file not found in $(Split-Path -Path $_ompPath -Parent)"
}