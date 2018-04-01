$ErrorActionPreference = "Stop"
$startColor = $HOST.UI.RawUI.ForegroundColor

$HOST.UI.RawUI.ForegroundColor = "Green"
Write-Host "        ============= MPFR ============= "
Write-Host " - MPFR should be totally automated :) "
Write-Host "        =============================== "

$HOST.UI.RawUI.ForegroundColor = $startColor


# include MSBuild
. "./FindMSBuild.ps1" 
$MSBuild = Get-MSBuild
$git = 'git'
$startDir = $PWD
$folder =  "$PWD\mpfr"

if(!(Test-Path $folder))
{   
    & $git clone https://github.com/BrianGladman/mpfr.git
}
else
{
    Write-Host "$folder already exists. Skipping dowload and extract."
}

$proj = "$folder/build.vc15/lib_mpfr\lib_mpfr.vcxproj"
#Write-Host "proj = $proj"

& $MSBuild $proj  /p:Configuration=Release /p:Platform=x64
#& $MSBuild $proj  /p:Configuration=Debug /p:Platform=x64

