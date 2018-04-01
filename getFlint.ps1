$ErrorActionPreference = "Stop"
$startColor = $HOST.UI.RawUI.ForegroundColor


$HOST.UI.RawUI.ForegroundColor = "Green"
Write-Host "        ============= flint ============= "
Write-Host " - The script will download and open flint."
Write-Host "   First the solution will need to be upgraded."
Write-Host "   "
Write-Host " - once the solution is open, set flint_config"
Write-Host "   as the start ip project. Set Release|x64 as the"
Write-Host "   configutation|platform"
Write-Host "   "
Write-Host " - run the program (F5)."
Write-Host "   "
Write-Host " - right click on "
Write-Host "        =============================== "
$HOST.UI.RawUI.ForegroundColor = $startColor

$uri = 'http://www.flintlib.org/flint-2.5.2.zip'
$destination = "$PWD\flint-2.5.2.zip" 
$install_dir = "$PWD/flint2"


if(!(Test-Path $install_dir))
{
	if(!(Test-Path $destination))
	{
		Write-Host 'downloading ' $uri ' to ' $destination
		
		try
		{ 
			Invoke-WebRequest -Uri $uri -OutFile $destination -UserAgent [Microsoft.PowerShell.Commands.PSUserAgent]::internetexplorer
		}catch
		{
			return;
		}

		Write-Host 'Download Complete'
	}
	
	Add-Type -assembly “system.io.compression.filesystem”
	[io.compression.zipfile]::ExtractToDirectory($destination, "$PWD")
	
	mv "$PWD\flint-2.5.2" $install_dir
}

& "$install_dir/build.vc14\flint.sln"


$HOST.UI.RawUI.ForegroundColor = "Green"
Write-Host "    flint  ~  SUCCESS "
$HOST.UI.RawUI.ForegroundColor = $startColor