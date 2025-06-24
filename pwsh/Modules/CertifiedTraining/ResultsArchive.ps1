function Copy-ResultsArchive
{
  [CmdletBinding(SupportsShouldProcess)]
  param([Parameter(ValueFromPipeline,
                   ValueFromPipelineByPropertyName)]
        [ValidateNotNullOrWhiteSpace()]
        [string[]]$Path = "results.tar",
        [ValidateNotNullOrWhitespace()]
        [string]$Destination = "./")
  
  process
  {
    if (!(Test-Path -Path $Destination)) {
      throw "Destination path not found: $Destination"
    }
    if($PSCmdlet.ShouldProcess($Destination, "scp"))
    {
      scp.exe "conduit.hpc.uni-saarland.de:$Path" "$Destination"
    }
  }
}

function Expand-ResultsArchive
{
  [CmdletBinding(SupportsShouldProcess)]
   param([Parameter(ValueFromPipeline,
                    ValueFromPipelineByPropertyName)]
         [ValidateNotNullOrWhiteSpace()]
         [string[]]$Path = "results.tar")
  process 
  {
    if(!(Test-Path -Path $Path -PathType Leaf))
    {
      throw "Invalid results archive path: $Path"
    }
    
    $dir = (Split-Path -Path $Path -Leaf) -Split '\.' | Select-Object -First 1
    if (!(Test-Path -Path $dir -PathType Container))
    { 
      [void](New-Item -Path $dir -Type Directory)
    }
    
    if($PSCmdlet.ShouldProcess($Path, "Extract TAR archive to new directory $dir"))
    {
      tar -C $dir -xf $Path
    }
    else
    {
      Write-Verbose "Archive contents:"
      tar -tf $Path
    }
      
    
    Move-Item -Path $Path -Destination $dir
  }
}