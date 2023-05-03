Invoke-Command -ComputerName Server01, Server02, Server03 -ScriptBlock {
    # Your server management commands go here
    Get-Service | Where-Object { $_.Status -eq 'Stopped' } | Start-Service
}
