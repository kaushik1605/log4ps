#This example a merge between demo3 (nested calls) and demo4 (filter by level) using XML config
# Remember that it will be loading .\demo7.ps1.config
# Note that the example is for illustration only, and haven't thought the setup through
# Also note that you can change the file on the fly and save to update the config
Import-Module -Force $PSScriptRoot\..\..\log4ps


Import-Module $PSScriptRoot\Module1\Module1.psm1
#Test-Module1

function Test-CallStackExample1 {
	. {
		Write-Verbose -Message 'This is the Test-CallStackExample'
		Test-Module1
	}
}

Test-CallStackExample1

Import-Module -force $PSScriptRoot\Module2\Module2.psm1
function Test-CallStackModule2 {
	$mod = Get-Module -Name Module2 #just for debug to prove that module2 has nested module
	#Write-Host "Module2 has a NestedModule: $($mod.NestedModules)"
	Test-Module2
	Test-Module2SubModule2

}
Test-CallStackModule2

. $PSScriptRoot\dotsourced.ps1

Test-DotSourced


Write-Host "###################################`r`nLets look at the files"
Write-Host "ERROR LOG: `r`n"
gc $Env:tmp\error.log


Write-Host "`r`n`r`nGENERAL LOG: `r`n"

gc $Env:tmp\General.log