#region Aliases
New-Alias -Name g -Value git
New-Alias -Name v -Value code
#endregion Aliases

#region Navigation
function psdir {
  Set-Location -Path (Split-Path $PROFILE.CurrentUserCurrentHost)
}
#endregion