# --Dotfiles for Windows --#

# c:\users\<username>
$user_home = $env:userprofile 
$documents = "$user_home\documents"
$config_dir = "$user_home\.config"

#-------------#
# Profile.ps1
# For Powershell (pwsh)
$pwsh_profile_dir = "$documents\powershell\"
if (![System.IO.Directory]::Exists($pwsh_profile_dir)) 
{
    New-Item -type dir $pwsh_profile_dir
}
Copy-Item ".\files\documents\powershell\profile.ps1" -d $pwsh_profile_dir

# For Windows Powershell
$win_powershell_profile_dir = "$documents\WindowsPowerShell\"
if (![System.IO.Directory]::Exists($win_powershell_profile_dir)) 
{
    New-Item -type dir $win_powershell_profile_dir
}
Copy-Item ".\files\documents\powershell\profile.ps1" -d $win_powershell_profile_dir

#-------------#
# ~/.config directory

if (![System.IO.Directory]::Exists($config_dir)) 
{
    New-Item -type dir $config_dir
}

# Starship.toml (includes prompt indicator for PS)
Copy-Item ".\files\.config\starship.toml" -d $config_dir



