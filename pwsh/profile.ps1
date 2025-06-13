#region Aliases
New-Alias -Name g -Value git
New-Alias -Name v -Value notepad++.exe
#endregion Aliases

#region Shortcuts
$global:workspace = "$HOME\source"
function workspace
{
  cd $workspace
}

function psdir
{
  cd (Split-Path $PROFILE.CurrentUserCurrentHost)
}
#endregion