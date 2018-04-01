$ErrorActionPreference = "Stop"
$startColor = $HOST.UI.RawUI.ForegroundColor


$HOST.UI.RawUI.ForegroundColor = "Green"
Write-Host "        ============= YASM ============= "
Write-Host " - The YASM assmbler is needed to build flint. "
Write-Host "   It must be downloaded and coped to program"
Write-Host "   files. This requires admin."
Write-Host "        =============================== "
$HOST.UI.RawUI.ForegroundColor = $startColor

$uri = 'http://www.tortall.net/projects/yasm/releases/vsyasm-1.3.0-win64.zip'
$destination = "$PWD\vsyasm-1.3.0-win64.zip" 
$install_dir = "C:\Program Files\yasm"
$install_exe = "$install_dir\vsyasm.exe"
$temp_dir = "$PWD/yasm"

$currentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
$hasAdmin = $currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)


if(!(Test-Path $install_exe))
{
	if(!(Test-Path $temp_dir))
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
		
		mkdir "$temp_dir"	
		Add-Type -assembly “system.io.compression.filesystem”
		[io.compression.zipfile]::ExtractToDirectory($destination, $temp_dir)
	}
		
	if(! $hasAdmin)
	{
		$HOST.UI.RawUI.ForegroundColor = "Red"
		Write-Host "Need to copy '$temp_dir' to '$install_dir'"
		Write-Host "    Requires Administrator rights. "
		Write-Host "Run as Administrator or manually copy..."
		$HOST.UI.RawUI.ForegroundColor = $startColor
		return;
	}
	else
	{
		mv $temp_dir $install_dir
	}
}



$HOST.UI.RawUI.ForegroundColor = "Green"
Write-Host "    YASM  ~  SUCCESS "
$HOST.UI.RawUI.ForegroundColor = $startColor