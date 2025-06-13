if (Test-Path -Path "$PSScriptRoot\Config" -PathType Container)
{
  dir -Path "$PSScriptRoot\Config" -Recurse -Include *.ps1
    | where -FilterScript { $_.Name[0] -NE '.' }
    | sort -Property Name
    | foreach { . $_ }
}
#f45873b3-b655-43a6-b217-97c00aa0db58 PowerToys CommandNotFound module

Import-Module -Name Microsoft.WinGet.CommandNotFound
#f45873b3-b655-43a6-b217-97c00aa0db58

Import-Module -Name Terminal-Icons
Import-Module PSCompletions

if (Test-Path -Path "$PSScriptRoot\default.omp.json" -PathType Leaf)
{
    oh-my-posh --init --shell pwsh --config $PSScriptRoot\default.omp.json | Invoke-Expression
}
