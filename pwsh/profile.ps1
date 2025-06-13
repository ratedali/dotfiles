#region Aliases
New-Alias -Name g -Value git
New-Alias -Name v -Value notepad++.exe
#endregion Aliases

#region Shortcuts
$global:workspace = "$HOME\source"
function workspace
{
  Set-Location -Path $workspace
}

function psdir
{
  Set-Location -Path (Split-Path $PROFILE.CurrentUserCurrentHost)
}
#endregion