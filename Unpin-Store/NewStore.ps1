##Elevate if needed

If (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]'Administrator')) {
    Write-Host "You didn't run this script as an Administrator. This script will self elevate to run as an Administrator and continue."
    Start-Sleep 1
    Write-Host "                                               3"
    Start-Sleep 1
    Write-Host "                                               2"
    Start-Sleep 1
    Write-Host "                                               1"
    Start-Sleep 1
    Start-Process powershell.exe -ArgumentList ("-NoProfile -ExecutionPolicy Bypass -File `"{0}`" -WhitelistApps {1}" -f $PSCommandPath, ($WhitelistApps -join ',')) -Verb RunAs
    Exit
}

#Function to Get the File Size
Function Get-FileSize {
 
    Param(
        [String]$FilePath
    )
     
    #Get the File Size
    [int]$Length = (Get-Item $FilePath).length
   
    #Format the File size based on size
    If ($Length -ge 1TB) {
        return "{0:N2} TB" -f ($Length / 1TB)
    }
    elseif ($Length -ge 1GB) {  
        return "{0:N2} GB" -f ($Length / 1GB)
    }
    elseif ($Length -ge 1MB) {
        return "{0:N2} MB" -f ($Length / 1MB)
    }
    elseif ($Length -ge 1KB) {
        return "{0:N2} KB" -f ($Length / 1KB)
    }
    else {
        return "$($Length) bytes"
    }
}
   
# Find if debloat has already run by file size
$DebloatPath = "C:\ProgramData\Debloat"
$LogPath = "C:\ProgramData\Debloat\Debloat.log"
$NewStore = WSReset.exe -i
If (Get-FileSize $DebloatPath -gt 100MB and Get-FileSize $LogPath -gt 10KB) {
    Write-Host "Debloat is running or has already run..."
    Write-Host "Your MS Store was removed. Re-adding it now..."
    Start-Process $NewStore
    Exit
}

else {
    exit
}
