function Get-Config {
	& "$PSCommandPath\..\Config.ps1"
}

class Repository {
	[string] $Name = ''
	[string] $GitUrl = ''
	[string] $Branch = ''
	[string] $Remote = 'origin'

	static [Repository] From([string] $url) {
		$repo = [Repository]::new()
		$repo.Name = $url.Split('/')[-1]
		$repo.GitUrl = $url + '.git'

		return $repo
	}

	static [Repository] From([Array] $array) {
		if ($array.Length -lt 1) {
			return [Repository]::new()
		}

		$repo = [Repository]::From($array[0])

		if ($array.Length -gt 1)  {
			$repo.Branch = $array[1]
		}

		if ($array.Length -gt 2)  {
			$repo.Remote = $array[2]
		}

		return $repo
	}

	[void] CreateOrUpdate($path) {
		try {
			$originalLocation = Get-Location

			if (Test-Path $path) {
				Set-Location $path
			} else {
				New-Item -ItemType Directory -Path $path -Force
				Set-Location $path

				git clone $this.GitUrl .
			}

			if ($this.Branch) {
				git checkout $this.Branch
			}

			git pull $this.Remote HEAD
			git submodule update --init --recursive
		} catch {
			throw
		} finally {
			Set-Location $originalLocation
		}
	}
}
