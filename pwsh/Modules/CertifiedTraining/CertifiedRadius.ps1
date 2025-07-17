using namespace System.Collections.Generic;

function Measure-CertifiedRadius
{
  [CmdletBinding()]
  param (
    [Parameter(Mandatory,
               ValueFromPipeline,
               ValueFromPipelineByPropertyName)]
    [ValidateScript({
      if (!(Test-Path -Path $_ -PathType Leaf)) {
        throw "File not found: $_"
      }
      if ([System.IO.Path]::GetExtension($_) -ne '.csv') {
        throw "File must be a CSV file: $_"
      }
      $true
    })]
    [string[]]$Path,
    
    [ValidateRange(0.01, 10.0)]
    [decimal]$StepSize = 0.25,
    
    [ValidateSet('.', ',')]
    [string]$DecimalSeparator = '.'
  )

  process {
    try {
      $dir = Split-Path -Path $Path 
      $all = @(Import-Csv -Path $Path)
      
      # Validate required columns
      if (-not ($all | Get-Member -Name 'Correct' -ErrorAction SilentlyContinue)) {
        throw "CSV file missing required 'Correct' column: $Path"
      }
      if (-not ($all | Get-Member -Name 'radius' -ErrorAction SilentlyContinue)) {
        throw "CSV file missing required 'radius' column: $Path"
      }
      
      # Handle empty files
      if ($all.Count -eq 0) {
        Write-Warning "Empty CSV file: $Path"
        return
      }
      
      # Create culture info for parsing
      $culture = [System.Globalization.CultureInfo]::InvariantCulture.Clone()
      $culture.NumberFormat.NumberDecimalSeparator = $DecimalSeparator
      
      # Validate and convert data types
      foreach ($row in $all) {
        if ($row.Correct -notin @('0', '1')) {
          throw "Invalid 'Correct' value. Must be 0 or 1: $($row.Correct)"
        }
        
        # Parse radius with culture-specific decimal separator
        $radiusValue = $null
        if (-not [decimal]::TryParse($row.radius, [System.Globalization.NumberStyles]::Number, $culture, [ref]$radiusValue)) {
          throw "Invalid 'radius' value. Must be numeric with '$DecimalSeparator' as decimal separator: $($row.radius)"
        }
        
        # Add parsed value to row for later use
        $row | Add-Member -NotePropertyName 'ParsedRadius' -NotePropertyValue $radiusValue -Force
      }
      
      $correct = @($all | Where-Object -Property Correct -EQ 1)
      
      $result = @{
        Directory = Resolve-Path -Path $dir -Relative
        ACR = if ($all.Count -gt 0) { 
          [double]($correct | Measure-Object -Property ParsedRadius -Sum).Sum / $all.Count 
        } else { 0.0 }
      }

      $radius = 0.0
      $acc = if ($all.Count -gt 0) { $correct.Count / $all.Count } else { 0.0 }
      $radii = [System.Collections.ArrayList]::new()
      
      do {
        [void]$radii.Add($radius)
        $result.Add("{0:F2}" -f $radius, $acc)

        $radius = $radius + $StepSize
        $correct = @($correct | Where-Object { $_.ParsedRadius -ge $radius })
        $acc = if ($all.Count -gt 0) { $correct.Count / $all.Count } else { 0.0 }
      }
      until([Math]::Round($acc, 4) -eq 0.0)

      [string[]]$columns = @("Directory", "ACR")
      $columns += $radii | ForEach-Object { "{0:F2}" -f $_ }
      [pscustomobject]$result | Select-Object -Property $columns
    }
    catch {
      Write-Error "Failed to process certified radius for '$Path': $($_.Exception.Message)"
    }
  }
}