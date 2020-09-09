$Config = & "$PSCommandPath\..\Get-Config.ps1"

function New-Repository($gitUrl, $name, $branch = $null) {
	git clone $gitUrl $name

	if (-not $branch) {
		return
	}

	Set-Location $name
	git checkout $branch
	Set-Location ..
}

function Update-Repository($name) {
	Set-Location $name
	git pull origin HEAD
	Set-Location ..
}

function Invoke-RepositoryUpdate($url, $branch = $null) {
	$name = $url.Split('/')[-1]

	Write-Host "`nUpdating repository '$name'..."

	if (Test-Path $name) {
		Update-Repository $name
	} else {
		$gitUrl = "$url.git"
		New-Repository $gitUrl $name $branch
	}
}

try {
	$originalLocation = Get-Location
	Set-Location $Config.RepositoriesFolder

	foreach ($repo in $Config.Repositories) {
		if ($repo -is [String]) {
			Invoke-RepositoryUpdate $repo
		} else {
			Invoke-RepositoryUpdate $repo[0] $repo[1]
		}
	}
} catch {
	throw
} finally {
	Set-Location $originalLocation
}
