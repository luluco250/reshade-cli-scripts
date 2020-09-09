param(
	[Parameter(Mandatory = $true, Position = 0)]
	[ValidateSet('32', '64')]
	[String] $Architecture,

	[Parameter(Mandatory = $false, Position = 1)]
	[String] $Path = $null
)

. "$PSCommandPath\..\Common.ps1"

$Config = Get-Config

if ($Path -eq $null) {
	$Path = $Config.ReShadeProjectRoot
}

$Platform = switch ($Architecture)
{
	'32' {'32-bit'}
	'64' {'64-bit'}
}

try {
	$repo = [Repository]::From($config.ReShadeRepository)
	$repo.CreateOrUpdate($Path)

	Invoke-MsBuild `
		-Path "$($Path)\ReShade.sln" `
		-params "/target:Build /property:Configuration=Release;Platform=$Platform" `
		-ShowBuildOutputInCurrentWindow
} catch {
	throw
}
