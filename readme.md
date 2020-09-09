# ReShade commandline scripts

This is a collection of PowerShell scripts I personally use to manage ReShade through the commandline.

Requirements:
- [Git](https://git-scm.com/) for creating and updating repositories.
- [Invoke-MsBuild](https://www.powershellgallery.com/packages/Invoke-MsBuild/) for building the ReShade project from the commandline.

Contents:
- `Invoke-ReShadeBuild.ps1 [-Architecture] {32|64} [-Path <PathToProject>]`
	- Creates or updates the ReShade repository at the specified path.
		- If no path is specified it is taken from the configuration file.
	- Builds ReShade's Visual Studio solution.
- `Update-Repositories.ps1 [-Path <PathToRepositoriesFolder>]`
	- Creates or updates repositories at the specified folder path
		- If no path is specified it is taken from the configuration file.
- `Config.ps1`
	- Configuration file for the other scripts.
	- Doesn't exist by default, take the example from `Config.example.ps1`.
	- Defines:
		- The ReShade project's root path (where the solution file is located).
		- The ReShade project's repository, to create or update.
		- The folder path to where repositories should be stored.
		- The list of shader repositories to create or update.
	- Repository definitions can be composed of either:
		- A simple URL string minus the ".git" suffix.
		- An array of strings as such: `(<url> [, <branch>] [, <remote>])`
- `Common.ps1`
	- Common file for other scripts, defines a class for repositories, as well as the creation and updating logic.
