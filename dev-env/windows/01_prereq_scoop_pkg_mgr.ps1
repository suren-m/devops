# Scoop can be installed without privilege escalation
# https://scoop.sh/
# https://github.com/lukesampson/scoop

Set-ExecutionPolicy RemoteSigned -scope CurrentUser
Invoke-Expression (New-Object System.Net.WebClient).DownloadString('https://get.scoop.sh')

