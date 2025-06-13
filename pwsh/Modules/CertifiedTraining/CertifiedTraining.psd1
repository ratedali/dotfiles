@{
  RootModule = 'CertifiedTraining.psm1'
  ModuleVersion = '1.0.0'
  Author = 'Ali Salaheldin'
  Description = 'Utilities for certified robust training of neural networks with benchmark-ctrs'
  FunctionsToExport = @('Measure-CertifiedRadius', 'Copy-ResultsArchive', 'Expand-ResultsArchive')
}