param(
	[Parameter(Mandatory = $true, Position = 0)]
	[ValidateSet('32', '64')]
	[String] $Architecture
)

$Config = & "$PSCommandPath\..\Get-Config.ps1"

$platform = switch ($Architecture)
{
	'32' {'32-bit'}
	'64' {'64-bit'}
}

Invoke-MsBuild `
	-Path "$($Config.ReShadeProjectRoot)\ReShade.sln" `
	-params "/target:Build /property:Configuration=Release;Platform=$platform" `
	-ShowBuildOutputInCurrentWindow
