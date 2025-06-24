using namespace System.Collections.Generic;

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
    $all = @(Import-Csv -Path $Path)
    $correct = @($all | Where-Object -Property Correct -EQ 1)
    
    $result = @{
      Directory = Resolve-Path -Path $dir -Relative
      ACR = [double]($correct | Measure-Object -Property radius -Sum).Sum / $all.Count
    }

    $radius = 0.0
    $acc = $correct.Count / $all.Count 
    $radii = [System.Collections.ArrayList]::new()
    do
    {
      [void]$radii.Add($radius)
      $result.Add("{0:F2}" -f $radius, $acc)

      $radius = $radius + $StepSize
      $correct = @($correct | Where-Object radius -GE $radius)
      $acc = $correct.Count / $all.Count
    }
    until([Math]::Round($acc, 4) -EQ 0.0)

    [string[]]$columns = @("Directory", "ACR")
    $columns += $radii | % { "{0:F2}" -f $_ }
    [pscustomobject]$result | Select-Object -Property $columns
  }
}