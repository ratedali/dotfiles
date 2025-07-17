# Description: This script sets up the Miniconda environment for PowerShell.

Function Enable-Conda {
  [CmdletBinding()]
  param(
    [Parameter(Mandatory = $false)]
    [string]$Environment = "base"
  )

  # Ensure the conda executable is available in the PATH
  $_condaHook = Join-Path -Path "$HOME" -ChildPath "miniconda3" -AdditionalChildPath "shell", "condabin", "conda-hook.ps1"

  if (Test-Path -Path $_condaHook) {
    # If the conda hook script exists, source it and activate the specified environment
    (& $_condaHook); (Invoke-Conda activate $Environment) | Out-Null
    Write-Verbose "Conda hook script sourced successfully."
  }
  else {
    throw "Conda hook script not found at $_condaHook"
  }
}
