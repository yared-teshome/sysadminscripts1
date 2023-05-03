Install-Module -Name VMware.PowerCLI -Scope CurrentUser

# Connect to the vCenter server
Connect-VIServer -Server vCenterServer -User username -Password password

# Get a list of virtual machines
Get-VM

# Start a virtual machine
Start-VM -VM VirtualMachineName

# Stop a virtual machine
Stop-VM -VM VirtualMachineName

# Get virtual machine CPU and memory usage
Get-Stat -Entity VirtualMachineName -Stat cpu.usage.average, mem.usage.average -Start (Get-Date).AddHours(-1) -IntervalMins 5

# Disconnect from the vCenter server
Disconnect-VIServer -Confirm:$false
