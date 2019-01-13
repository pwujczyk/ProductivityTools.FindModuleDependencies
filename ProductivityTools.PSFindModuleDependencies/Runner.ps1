clear
cd $PSScriptRoot
Import-Module .\ProductivityTools.PSFindModuleDependencies.psm1 -Force
cd  d:\GitHub\
Find-ModuleDependencies "ProductivityTools.PSMasterConfiguration" -Verbose |Out-GridView