clear
cd $PSScriptRoot
Import-Module .\ProductivityTools.PSFindModuleDependencies.psm1 -Force
cd  d:\GitHub\
Find-ModuleDependencies "*PSMasterConfiguration*" -Verbose -Like |Out-GridView