




# Gather disk space information
$disks = Get-PSDrive -PSProvider FileSystem | Where-Object {$_.Root -like "C:\*"} | Select-Object Name, Used, Free, Size

# Gather memory information
$memory = Get-CimInstance -ClassName Win32_OperatingSystem | Select-Object TotalVisibleMemorySize, FreePhysicalMemory

# Gather CPU usage information
$cpu = Get-CimInstance -ClassName Win32_Processor | Select-Object LoadPercentage

# Gather IP address information
$ip = Get-NetIPAddress -AddressFamily IPv4 | Select-Object InterfaceAlias, IPAddress, PrefixLength

# Gather subnet mask information
$subnetMask = $ip | ForEach-Object {Get-NetAdapter $_.InterfaceAlias | Select-Object InterfaceAlias, InterfaceIndex, InterfaceDescription, MacAddress, Status, LinkSpeed, MediaType, OperationalStatus, Virtual, NetConnectionID, NetConnectionStatus, NetAdapterManufacturer, NetAdapterProductName, NetAdapterDriverVersion, @{Name="SubnetMask";Expression={(Get-NetIPAddress -InterfaceIndex $_.InterfaceIndex -AddressFamily IPv4).PrefixLength}}}

# Gather DNS information
$dns = Get-DnsClientServerAddress -AddressFamily IPv4 | Select-Object InterfaceAlias, ServerAddresses

# Gather critical error messages from the System event log
$errorMessages = Get-EventLog -LogName System -EntryType Error -Newest 5 | Select-Object TimeGenerated, Source, EventID, Message

# Combine the information into a single object
$systemInfo = New-Object PSObject
$systemInfo | Add-Member -MemberType NoteProperty -Name "Disks" -Value $disks
$systemInfo | Add-Member -MemberType NoteProperty -Name "MemoryTotal" -Value $memory.TotalVisibleMemorySize
$systemInfo | Add-Member -MemberType NoteProperty -Name "MemoryFree" -Value $memory.FreePhysicalMemory
$systemInfo | Add-Member -MemberType NoteProperty -Name "CPU" -Value $cpu.LoadPercentage
$systemInfo | Add-Member -MemberType NoteProperty -Name "IPAddress" -Value $ip.IPAddress
$systemInfo | Add-Member -MemberType NoteProperty -Name "SubnetMask" -Value $subnetMask.SubnetMask
$systemInfo | Add-Member -MemberType NoteProperty -Name "DNS" -Value $dns.ServerAddresses
$systemInfo | Add-Member -MemberType NoteProperty -Name "ErrorMessages" -Value $errorMessages

# Display the information
$systemInfo
