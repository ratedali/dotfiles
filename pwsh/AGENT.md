# PowerShell Dotfiles Agent Configuration

## Testing & Validation Commands
- Test profile loading: `PowerShell -NoProfile -Command "& '$PROFILE'"`
- Validate syntax: `powershell -Command "Get-Command -Name 'function_name'"`
- Test specific config: `. .\Config\filename.ps1`

## Architecture & Structure
- **Main Profile**: `Microsoft.PowerShell_profile.ps1` (auto-loads Config/ scripts)
- **Config Directory**: Contains numbered config files (00-99) loaded in order
- **Modules Directory**: Contains PowerShell modules (Terminal-Icons, PSCompletions, etc.)
- **Scripts Directory**: Contains PowerShell scripts and installers

## Code Style & Conventions
- Use PascalCase for functions and cmdlets
- Use kebab-case for aliases (`g` for git, `v` for code.exe)
- Place configuration in numbered files (00-99) for load order control
- Use `[CmdletBinding()]` for advanced functions
- Import modules in `00.Import-Modules.ps1`
- Use `Write-Verbose` for debug output
- Follow PowerShell approved verbs for function names
- Use `#region` and `#endregion` for code organization
- Test paths with `Test-Path` before operations
- Use `Join-Path` for path construction
