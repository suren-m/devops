foreach($line in Get-Content .\extensions) {
    if($line -match $regex){
        code --install-extension $line --force 
    }
}

