$USER_PATH = @("$HOME/.local/bin")


$env:PATH = ($USER_PATH + $env:PATH) -join ":"
