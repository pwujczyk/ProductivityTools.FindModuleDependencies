<p align="right">
 <a href="https://www.powershellgallery.com/packages/ProductivityTools.PSFindModuleDependencies">
  <img src="http://cdn.productivitytools.tech/Powershell40px.png" /></a>
<a href="http://www.productivitytools.tech/find-moduledependencies/">
<img src="http://cdn.productivitytools.tech/Blog40px.png" /><a>
</p>

# ProductivityTools.PSFindModuleDependencies


It looks recursively in directory to find all psd1 files, next it take RequiredModules key and writes it. If DependencyName parameter is provided. It will wrote only those modules which requires given dependency to work.


Find-ModuleDependencies without any parameters will go through all directories in given path and will search for psd1 files, next it will write on the screen value of the RequiredModules key.

```powershell
Find-ModuleDependencies
``` 

You can also pass Path parameter if you want to perform analysis for different directory.
```powershell
Find-ModuleDependencies -Path C:\Github
```
If you want to look for particular dependency just use parameter DependencyName then it will show just those modules which needs provided dependency

```powershell
Find-ModuleDependencies -Dependency ""ProductivityTools.PSMasterConfiguration"
```
I am using this when, I am changing module and I need to know which modules should be updated.
