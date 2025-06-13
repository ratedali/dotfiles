if (Test-Path -Path "$PSScriptRoot\Config" -PathType Container)
{
  Get-ChildItem -Path "$PSScriptRoot\Config" -Recurse -Include *.ps1
    | Where-Object -FilterScript { $_.Name[0] -NE '.' }
    | Sort-Object -Property Name
    | ForEach-Object -Process { . $_ }
}

Import-Module -Name Terminal-Icons
Import-Module PSCompletions

if (Test-Path -Path "$PSScriptRoot\default.omp.json" -PathType Leaf)
{
    oh-my-posh --init --shell pwsh --config $PSScriptRoot\default.omp.json | Invoke-Expression
}
