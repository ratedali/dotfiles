function Measure-CertifiedRadius
{
    [CmdletBinding()]
    param (
        [Parameter(Mandatory,
                   ValueFromPipeline,
                   ValueFromPipelineByPropertyName)]
        [string[]]$Path,
        [decimal]$StepSize = 0.25
    )

    process {
        $dir = Split-Path -Path $Path 
        $values = @(Import-Csv -Path $Path)
        $count = $values.Count
        
        $radius = 0.0
        $acc = ($values | Measure-Object -Property correct -Sum).Sum / $count 
        $result = @{
            Directory = Resolve-Path -Path $dir -Relative
            ACR = [double]($values | Measure-Object -Property radius -Average).Average
        }
        
        $radii = [System.Collections.ArrayList]::new()
        do
        {
            [void]$radii.Add($radius)
            $result.Add("{0:F2}" -f $radius, $acc)
            
            $radius = $radius + $StepSize
            $values = @($values | Where-Object radius -GE $radius)
            $acc = $values.Count / $count
        }
        until([Math]::Round($acc, 4) -EQ 0.0)
        
        [string[]]$columns = @("Directory", "ACR")
        $columns += $radii | % { "{0:F2}" -f $_ }
        [pscustomobject]$result | Select-Object -Property $columns
    }

}