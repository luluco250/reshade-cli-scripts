param(
	[Parameter(Mandatory = $false, Position = 0)]
	[String] $Path = $null
)

. "$PSCommandPath\..\Common.ps1"

$Config = Get-Config

if ($Path -eq $null) {
	$Path = $Config.RepositoriesFolder
}

try {
	foreach ($repo in $Config.Repositories) {
		$repo = [Repository]::From($repo)
		$repoPath = "$Path\$($repo.Name)"
		$repo.CreateOrUpdate($repoPath)
	}
} catch {
	throw
}
