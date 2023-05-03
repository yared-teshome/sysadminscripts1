##cmdlet to retreive all objects in Active Directory

# Connect to the remote computer
$credential = Get-Credential
Enter-PSSession -ComputerName RemoteComputerName -Credential $credential

# Import the Active Directory PowerShell module
Import-Module ActiveDirectory

# Retrieve all objects in Active Directory
Get-ADObject -Filter *

# Exit the remote session
Exit-PSSession