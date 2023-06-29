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
