$FolderPath = dir -Directory -Path "\\computername\drive$"
$Report = @()
ForEach ($Folder in $FolderPath) {
    $Acl = Get-Acl -Path $Folder.Fullname
    foreach ($Access in $acl.access)
    {
        $properties = [ordered]@{'FolderName'=$folder.Fullname;'AD
Group or
User'=$Access.IdentityRefrence;'Permissions'=$Access.FileSystemRights;'Inherited'=$Access.IsInherited}
        $Report+= New-Object -TypeName PSObject -Property $properties
        }
}
$Report | Export-Csv -Path "\\computername\drive(E)$\folderperm.csv"
#openfiles /query /fo table /nh

#-examples# Get-ChildItem -Recurse "network file path" | Get-Acl | Export-Csv "network file path"


# Define variables
$shareName = "YourShareName"  # Replace with the name of your share
$permission = "Everyone"      # Replace with the desired group or user
$accessLevel = "Read"         # Replace with the desired access level (Read, Full, etc.)

# Get the current share permissions
$share = Get-SmbShare -Name $shareName

# Update share permissions
if ($share) {
    $share | Set-SmbShare -FolderEnumerationMode AccessBased -CimSession (New-CimSession -ComputerName $env:COMPUTERNAME) -ChangeAccess $permission,$accessLevel
    Write-Output "Share permissions updated for $shareName"
} else {
    Write-Output "Share $shareName not found"
}

Modify permisssion from local share

# Define source and destination folder paths
$sourceFolderPath = "C:\Path\to\Source\Folder"
$destinationFolderPath = "C:\Path\to\Destination\Folder"

# Get ACL from the source folder
$acl = Get-Acl -Path $sourceFolderPath

# Apply the ACL to the destination folder
Set-Acl -Path $destinationFolderPath -AclObject $acl


# Get the DFS namespace server
$dfsNamespace = "\\YourDFSNamespace"  # Replace with your DFS namespace

# Get the sessions connected to the DFS namespace server
$sessions = Get-SmbSession | Where-Object { $_.ShareName -like "$dfsNamespace\*" }

# Filter unique users from the sessions
$connectedUsers = $sessions | Select-Object -Property UserName -Unique

# Display the list of connected users
Write-Output "Users connected to DFS namespace $dfsNamespace:"
$connectedUsers | Format-Table -AutoSize


