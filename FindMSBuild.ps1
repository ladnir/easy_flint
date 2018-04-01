

Function Get-MSBuild
{
	$MSBuild_14 = 'C:\Program Files (x86)\MSBuild\14.0\Bin\MSBuild.exe'
	$MSBuild_15 = 'C:\Program Files (x86)\Microsoft Visual Studio\2017\Enterprise\MSBuild\15.0\Bin\MSBuild.exe'

	# Update this if needed
	$MSBuild = $MSBuild_15


	if(!(Test-Path $MSBuild))
	{
		Write-Host "Could not find MSBuild as"
		Write-Host "     $MSBuild"
		Write-Host ""
		Write-Host "Please update its location in the script"

		exit
	}
	else
	{
		Write-Host "  MSBuild = $MSBuild"
	}
 
	return $MSBuild
}
 