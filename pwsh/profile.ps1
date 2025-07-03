#region Aliases
New-Alias -Name g -Value git
New-Alias -Name v -Value nvim
New-Alias -Name vim -Value nvim
#endregion Aliases

#region Shortcuts
function psdir
{
  Set-Location -Path (Split-Path $PROFILE.CurrentUserCurrentHost)
}
#endregion
