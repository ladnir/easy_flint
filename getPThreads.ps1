$ErrorActionPreference = "Stop"
$startColor = $HOST.UI.RawUI.ForegroundColor


$HOST.UI.RawUI.ForegroundColor = "Green"
Write-Host "        ============= pthreads ============= "
Write-Host " - pthreads is downloaded ad a prebuild library. "
Write-Host ""
Write-Host " - To make it play nice with flint on win 10, the"
Write-Host "   pthread.h header needs to be modified. The script"
Write-Host "   will do this and then copy the headers accordingly"
Write-Host ""
Write-Host " - static libraries will be under pthreads\Pre-built.2\lib\"
Write-Host "        =============================== "
$HOST.UI.RawUI.ForegroundColor = $startColor

$uri = 'ftp://sourceware.org/pub/pthreads-win32/pthreads-w32-2-9-1-release.zip'
$destination = "$PWD\pthreads-w32-2-9-1-release.zip" 
$install_dir = "$PWD/pthreads"


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
	[io.compression.zipfile]::ExtractToDirectory($destination, "$install_dir")
}

cp "$PWD/patch/pthread.h" "$PWD/pthreads\Pre-built.2\include" -Force

mkdir "$PWD/pthreads\lib/x64/Debug" -Force | out-null
mkdir "$PWD/pthreads\lib/x64/Release" -Force  | out-null
 
cp "$PWD/pthreads\Pre-built.2\include\*" "$PWD/pthreads\lib/x64/Debug"
cp "$PWD/pthreads\Pre-built.2\include\*" "$PWD/pthreads\lib/x64/Release"

$HOST.UI.RawUI.ForegroundColor = "Green"
Write-Host "    pthreads  ~  SUCCESS "
$HOST.UI.RawUI.ForegroundColor = $startColor