

# Install Git for Windows
https://git-scm.com/downloads

Install-Module posh-git -Scope CurrentUser -Force
Install-Module oh-my-posh -Scope CurrentUser -RequiredVersion 2.0.412

# PSCore ONLY
#Install-Module -Name PSReadLine -Scope CurrentUser -Force -SkipPublisherCheck


Add these to $PROFILE
```
try{
  Set-PoshPrompt -Theme paradox -ErrorAction SilentlyContinue
}catch{
  Import-Module posh-git
  Import-Module oh-my-posh
}finally{
  Update-Module oh-my-posh
}
  
#Set-PoshPrompt -Theme paradox
```
**Setup Powerline** : [link](https://docs.microsoft.com/en-us/windows/terminal/tutorials/powerline-setup)
**Powerline Docs** : [link](https://ohmyposh.dev/docs/pwsh)
**Split Panes** : [link](https://docs.microsoft.com/en-us/windows/terminal/panes)
