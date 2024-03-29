# Find if debloat has already run
$DebloatScript = "C:\ProgramData\Debloat\removebloat.ps1"
$DebloatLog = "C:\ProgramData\Debloat\Debloat.log"
If (Test-Path $DebloatScript and $DebloatLog) {
    
}