function ProcessPsd1File() {
	param($psd1FilePath)
	
	$file = Import-PowerShellDataFile $psd1FilePath
	$requiredModules = $file["RequiredModules"]
	
	return $requiredModules
}

function ProcessPsd1Files() {
	param($psd1Files)
	
	$psd1Results = @{ }
	
	foreach ($psd1File in $psd1Files) {
		$psd1FilePath = $psd1File.FullName
		$requiredModules = ProcessPsd1File $psd1FilePath
		if ($requiredModules -eq $null) {
			$psd1Results.add($psd1FilePath, $null)	
		}
		else {
			$psd1Results.add($psd1FilePath, @($requiredModules))	
		}
	}
	return $psd1Results
}

function FilterDependencies {

	[cmdletbinding()]
	param([Hashtable]$psd1Results, [string]$filter, [bool]$Like)
	
	Write-Verbose "Filtering results with filter $filter and Like swich set to $Like"

	$psd1ResultsFiltered = @{ }
	
	foreach ($psd1Result in $psd1Results.GetEnumerator()) {
		foreach ($dependency in $psd1Result.Value) {
			if ($Like) {
				if ($dependency -like "*$filter*") {
					Write-Verbose "file which contains dependency $($psd1Result.Key) [Like]"
					if (!$psd1ResultsFiltered.ContainsKey($psd1Result.key)) {
						$psd1ResultsFiltered.add($psd1Result.key, $psd1Result.Value)
					}
				}	
			}
			else {
				if ($dependency -eq $filter) {
					Write-Verbose "file which contains dependency $($psd1Result.Key) [Equals]"
					if (!$psd1ResultsFiltered.ContainsKey($psd1Result.key)) {
						$psd1ResultsFiltered.add($psd1Result.key, $psd1Result.Value)
					}
				}
			}
			
		}
	}
	return $psd1ResultsFiltered
}

function Find-ModuleDependencies {
	
	[cmdletbinding()]
	param([string]$DependencyName, [string]$Path = $(Get-Location), [switch]$Like)

	Write-Verbose "Hello from Find-ModuleDependencies."
	Write-Verbose "Path analyzed: $Path."
	
	$psd1Files = @(Get-ChildItem -Path $Path -Recurse -filter "*.psd1")
	Write-Verbose "Found $($psd1Files.Count) psd1 files."

	$psd1Results = ProcessPsd1Files $psd1Files
	
	if ($DependencyName -ne [String]::Empty) {
		$psd1ResultsFiltered = FilterDependencies $psd1Results $DependencyName $Like
		Write-Output $psd1ResultsFiltered
	}
	else {
		Write-Output $psd1Results
	}
}