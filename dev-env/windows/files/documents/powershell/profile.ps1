#----Profile.ps1 is similar to ~/.bashrc or ~/.zshrc----#

#------------#
# Functions for aliases and env:vars below
# similar to running 'env' on bash (here it's assigned to winenv alias)
# Not needed if busybox is installed via scoop. (it comes with `env`)
Function winenv { Get-Childitem -path env: }

# switch to wsl home dir from windows (set path of default distro)
Function wslhome {Set-Location -Path \\wsl$\Debian\home\suren}

# quick launch repo paths
Function devops {Set-Location -Path $env:userprofile\repos\devops}
Function winops {Set-Location -Path $env:userprofile\repos\devops\dev-env\windows}

#-----------#
# Git
function ga {
  param(
    [Parameter(ValueFromRemainingArguments = $true)]
    [String[]] $file
  )
  git add $file
}

function gst {
  git status
}


#------------#
# Env vars (similar to `export foo=bar`)

# profile file location (similar to ~/.zprofile or ~/.profile)
# after this, `. $env:profile` can be run to restart shell. (similar to source ~/.bashrc)
$env:myprofile = "$env:userprofile\documents\powershell\profile.ps1"

# Append to PATH
# To see: env | grep 'Path' | sed 's/;/\n/g' (or simply $env:PATH)
$env:PATH += ";c:\cuda\bin"

#------------#
# Aliases (similar to `alias foo=bar`)

Set-Alias -Name g -Value git
Set-Alias -Name v -Value vi
Set-Alias -Name k -Value kubectl

#------------#

# Starship Prompt - keep it at the end
# Depends on starship being present. (can be installed via scoop)
# Below works for Pwsh as well

Invoke-Expression (&starship init powershell)

#------------#W
