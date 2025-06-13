#region Aliases
New-Alias -Name g -Value git
New-Alias -Name v -Value nvim
New-Alias -Name vim -Value nvim
#endregion Aliases

#region Shortcuts
$global:workspace = "$HOME\Workspace"
function workspace
{
  Set-Location -Path $workspace
}

function psdir
{
  Set-Location -Path (Split-Path $PROFILE.CurrentUserCurrentHost)
}
#endregion
