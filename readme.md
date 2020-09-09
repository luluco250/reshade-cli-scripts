# ReShade commandline scripts

This is a collection of PowerShell scripts I personally use to manage ReShade through the commandline.

Usage:
- `Invoke-ReShadeBuild.ps1 [-Architecture] <32|64>`
	- Uses [Invoke-MsBuild](https://www.powershellgallery.com/packages/Invoke-MsBuild/) to build ReShade's Visual Studio solution.
- `Update-Repositories.ps1`
	- Uses [Git](https://git-scm.com/) to create or update shader repositories.
- `Get-Config.ps1`
	- Doesn't exist by default, take the example from `Get-Config.example.ps1`.
	- Defines:
		- The ReShade project's root path (where the solution file is located).
		- The folder path to where repositories should be stored.
		- Which repositories to use, consisting of a list of URL strings and optionally which branch to use.
			- The URL string should be the HTTPS/SSH URI minus the ".git" suffix.
