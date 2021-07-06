# Requires -RunAsAdministrator

$pkg_mgr = "winget"
$operation = "install"
$flag = "--silent"

# ---------- #
# Dev Tools
# ---------- #
$devtools = @( 
 "dotnet", 
 "git",   
 "PowerToys (Preview)", 
 "Python 3",
 "pwsh", # new powershell
 "vscode",
 "Windows Terminal",
 "Windows Terminal Preview" # to use quake mode in 1.9  
)

foreach($tool in $devtools) {
    $command = "$($pkg_mgr) $($operation) ""$($tool)"" $($flag)"
    echo "executing...$command"
    Invoke-Expression $command	
}

# ---------- #
# Cloud Tools
# ---------- #
$cloudtools = @(
 "Azure CLI",
 "Bicep CLI" 
)

foreach($tool in $cloudtools) {
    $command = "$($pkg_mgr) $($operation) ""$($tool)"" $($flag)"
    echo "executing...$command"
    Invoke-Expression $command	
}

# ---------- #
# Common Software
# ---------- #
$common = @(
 "Google Chrome",
 "Microsoft Edge",
 "Microsoft Teams" 
)

foreach($tool in $common) {
    $command = "$($pkg_mgr) $($operation) ""$($tool)"" $($flag)"
    echo "executing...$command"
    Invoke-Expression $command	
}

# If applicable: 'Nvidia GeForce Experience'
