# Define the list of servers you want to manage
$servers = "server1", "server2", "server3"

# Loop through each server and perform the desired action
foreach ($server in $servers) {
    
    # Check if the server is online
    if (Test-Connection -ComputerName $server -Quiet) {
        
        # Get the list of running processes on the server
        $processes = Get-Process -ComputerName $server
        
        # Display the list of processes
        Write-Host "Running processes on $server:"
        $processes | Select-Object ProcessName, Id, CPU, StartTime
        
        # Stop a specific process on the server
        $processName = "notepad"
        $processToStop = Get-Process -ComputerName $server | Where-Object {$_.ProcessName -eq $processName}
        if ($processToStop) {
            Write-Host "Stopping $processName on $server..."
            $processToStop | Stop-Process -Force
        }
        else {
            Write-Host "$processName is not running on $server."
        }
        
        # Get the list of installed software on the server
        $software = Get-WmiObject -Class Win32_Product -ComputerName $server
        
        # Display the list of installed software
        Write-Host "Installed software on $server:"
        $software | Select-Object Name, Version, InstallDate
    }
    else {
        Write-Host "$server is offline."
    }
}