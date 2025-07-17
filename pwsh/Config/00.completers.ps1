if (Get-Command -Name dotnet -ErrorAction SilentlyContinue) {
  # PowerShell parameter completion shim for the dotnet CLI
  # <https://www.hanselman.com/blog/how-to-use-autocomplete-at-the-command-line-for-dotnet-git-winget-and-more>
  Register-ArgumentCompleter -Native -CommandName dotnet -ScriptBlock {
    param($commandName, $wordToComplete, $cursorPosition)
    dotnet complete --position $cursorPosition "$wordToComplete" | ForEach-Object {
      [System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', $_)
    }
}
}

if (Get-Command -Name winget -ErrorAction SilentlyContinue) {
  # winget parameter completion
  # <https://gist.github.com/shanselman/25f5550ad186189e0e68916c6d7f44c3>
  Register-ArgumentCompleter -Native -CommandName winget -ScriptBlock {
    param($wordToComplete, $commandAst, $cursorPosition)
    [Console]::InputEncoding = [Console]::OutputEncoding = $OutputEncoding = [System.Text.Utf8Encoding]::new()
    $Local:word = $wordToComplete.Replace('"', '""')
    $Local:ast = $commandAst.ToString().Replace('"', '""')
    winget complete --word="$Local:word" --commandline "$Local:ast" --position $cursorPosition | ForEach-Object {
      [System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', $_)
    }
  }
}

if (Get-Command -Name gh -ErrorAction SilentlyContinue) {
  # GitHub CLI parameter completion
  Invoke-Expression -Command (gh completion -s powershell | Out-String)
}