function Copy-ResultsArchive {
  [CmdletBinding(SupportsShouldProcess)]
  param(
    [Parameter(ValueFromPipeline,
      ValueFromPipelineByPropertyName)]
    [ValidateNotNullOrWhiteSpace()]
    [string[]]$Path = "results.tar",

    [ValidateScript({
        if (!(Test-Path -Path $_ -PathType Container)) {
          throw "Destination directory not found: $_"
        }
        $true
      })]
    [string]$Destination = "./",

    [ValidateNotNullOrWhiteSpace()]
    [string]$RemoteHost = "conduit.hpc.uni-saarland.de"
  )

  process {
    foreach ($filePath in $Path) {
      try {
        $remotePath = "${RemoteHost}:$filePath"
        $fileName = Split-Path -Path $filePath -Leaf
        $localPath = Join-Path -Path $Destination -ChildPath $fileName

        # Check if file already exists
        if (Test-Path -Path $localPath) {
          Write-Warning "File already exists: $localPath"
          if (-not $PSCmdlet.ShouldContinue("Overwrite existing file?", "File exists")) {
            continue
          }
        }

        if ($PSCmdlet.ShouldProcess($localPath, "Download from $remotePath")) {
          Write-Verbose "Downloading: $remotePath -> $localPath"

          # Capture output
          $scpArgs = @($remotePath, $Destination)
          $process = Start-Process -FilePath "scp.exe" -ArgumentList $scpArgs -PassThru -NoNewWindow -Wait

          if ($process.ExitCode -ne 0) {
            throw "SCP failed with exit code $($process.ExitCode)"
          }

          # Verify file was downloaded
          if (Test-Path -Path $localPath) {
            Write-Verbose "Successfully downloaded: $fileName"
          }
          else {
            throw "Download completed but file not found: $localPath"
          }
        }
      }
      catch {
        Write-Error "Failed to download '$filePath': $($_.Exception.Message)"
      }
    }
  }
}

function Expand-ResultsArchive {
  [CmdletBinding(SupportsShouldProcess)]
  param(
    [Parameter(Mandatory,
      ValueFromPipeline,
      ValueFromPipelineByPropertyName)]
    [ValidateScript({
        if (!(Test-Path -Path $_ -PathType Leaf)) {
          throw "Archive file not found: $_"
        }
        $extension = [System.IO.Path]::GetExtension($_).ToLower()
        if ($extension -notin @('.tar', '.gz', '.tgz')) {
          throw "Unsupported archive format: $extension. Supported formats: .tar, .gz, .tgz"
        }
        $true
      })]
    [string[]]$Path,

    [string]$DestinationPath,

    [switch]$Force,

    [switch]$PreserveArchive
  )

  process {
    foreach ($archivePath in $Path) {
      try {
        $archiveFile = Get-Item -Path $archivePath
        $baseName = [System.IO.Path]::GetFileNameWithoutExtension($archiveFile.Name)

        # Handle compressed tar files (.tar.gz, .tgz)
        if ($baseName.EndsWith('.tar')) {
          $baseName = [System.IO.Path]::GetFileNameWithoutExtension($baseName)
        }

        $extractDir = if ($DestinationPath) {
          Join-Path -Path $DestinationPath -ChildPath $baseName
        }
        else {
          Join-Path -Path $archiveFile.DirectoryName -ChildPath $baseName
        }

        # Create extraction directory if doesn't exists
        if (! (Test-Path -Path $extractDir -PathType Container)) {
          New-Item -Path $extractDir -Type Directory | Out-Null
        }


        if ($PSCmdlet.ShouldProcess($archivePath, "Extract archive to $extractDir")) {
          Write-Verbose "Extracting: $archivePath -> $extractDir"

          # Test archive integrity first
          Write-Verbose "Testing archive integrity..."
          $testResult = tar -tf $archivePath 2>&1
          if ($LASTEXITCODE -ne 0) {
            throw "Archive integrity test failed: $testResult"
          }

          # Extract archive
          $extractResult = tar -C $extractDir -xf $archivePath 2>&1
          if ($LASTEXITCODE -ne 0) {
            throw "Archive extraction failed: $extractResult"
          }

          # Verify extraction
          $extractedFiles = Get-ChildItem -Path $extractDir -Recurse
          if ($extractedFiles.Count -eq 0) {
            throw "No files were extracted from the archive"
          }

          Write-Verbose "Successfully extracted $($extractedFiles.Count) items to: $extractDir"

          # Move archive to extraction directory if requested
          if (-not $PreserveArchive) {
            $archiveDestination = Join-Path -Path $extractDir -ChildPath $archiveFile.Name
            Move-Item -Path $archivePath -Destination $archiveDestination
            Write-Verbose "Moved archive to: $archiveDestination"
          }
        }
        else {
          Write-Verbose "Archive contents preview:"
          tar -tf $archivePath | Select-Object -First 10
          if ($LASTEXITCODE -ne 0) {
            Write-Warning "Could not list archive contents"
          }
        }
      }
      catch {
        Write-Error "Failed to extract archive '$archivePath': $($_.Exception.Message)"
      }
    }
  }
}