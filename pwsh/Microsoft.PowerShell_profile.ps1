[CmdletBinding(SupportsShouldProcess)]
param()

#f45873b3-b655-43a6-b217-97c00aa0db58 PowerToys CommandNotFound module

Import-Module -Name Microsoft.WinGet.CommandNotFound
#f45873b3-b655-43a6-b217-97c00aa0db58

# Load config scripts
# This allows for custom configuration scripts to be placed in the Config directory
if (Test-Path -Path "$PSScriptRoot\Config" -PathType Container) {
  $conf = @(Get-ChildItem -Path "$PSScriptRoot\Config" -Recurse -Include *.ps1
    | Where-Object -FilterScript { $_.Name[0] -NE '.' } ` # Exclude hidden files
    | Sort-Object -Property Name) # Sort by name for consistent loading order
  foreach ($conf_script in $conf) {
    # Load each configuration script
    Write-Verbose "Loading configuration script: $($conf_script.FullName)"
    . $conf_script
  }
}