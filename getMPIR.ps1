$ErrorActionPreference = "Stop"
$startColor = $HOST.UI.RawUI.ForegroundColor

$HOST.UI.RawUI.ForegroundColor = "Green"
Write-Host "        ============= MPIR ============= "
Write-Host " - MPIR has good VS support. There are "
Write-Host "   several projects contained in the build.vs*"
Write-Host "   directories optimized for different CPUs. "
Write-Host ""
Write-Host " - skylake is the newest (avx) and should be used "
Write-Host "   if possible. "
Write-Host ""
Write-Host " - gc is generic c and should work everywhere."
Write-Host "   cxx is the c++ extension library and is not needed."
Write-Host ""
Write-Host " - NOTE: if you have issues with stdio.h. open the project"
Write-Host "   properties and change the Windows SDK Version."
Write-Host "        =============================== "

$HOST.UI.RawUI.ForegroundColor = $startColor


# include MSBuild
#. "./FindMSBuild.ps1" 
#$MSBuild = Get-MSBuild
$git = 'git'
#$startDir = $PWD
$folder =  "$PWD\mpir"

if(!(Test-Path $folder))
{   
    & $git clone https://github.com/wbhart/mpir.git
}
else
{
    Write-Host "$folder already exists. Skipping dowload and extract."
}

& $folder'/build.vc15/mpir.sln'
#cp -Force $startDir'/patch/mpir/*' $folder'/build.vc15/lib_mpir_skylake_avx'



#& $MSBuild .\lib_mpir_skylake_avx\lib_mpir_skylake_avx.vcxproj  /p:Configuration=Release /p:Platform=x64
#& $MSBuild .\lib_mpir_skylake_avx\lib_mpir_skylake_avx.vcxproj  /p:Configuration=Debug /p:Platform=x64

