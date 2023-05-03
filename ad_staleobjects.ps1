#script to identify and remove stale Active Directory objects:

#This script first sets a variable $staleDays to determine the number of days after which an #object is considered stale. It then gets the current date and calculates the date $staleDays #ago.

#The script then uses the Get-ADObject cmdlet to retrieve a list of all Active Directory objects #that haven't been modified since $staleDate. The -Properties WhenChanged parameter specifies #that the WhenChanged attribute should be included in the results.

#Finally, the script loops through each stale object and removes it using the Remove-ADObject #cmdlet. The -Confirm:$false parameter specifies that the user should not be prompted for #confirmation before each object is deleted.




# Set the number of days after which an object is considered stale
$staleDays = 90

# Get the current date
$today = Get-Date

# Calculate the date $staleDays ago
$staleDate = $today.AddDays(-$staleDays)

# Get a list of all AD objects that haven't been modified since $staleDate
$staleObjects = Get-ADObject -Filter {WhenChanged -lt $staleDate} -Properties WhenChanged

# Loop through the stale objects and remove them
foreach ($obj in $staleObjects) {
    Write-Host "Removing $($obj.Name) (last modified $($obj.WhenChanged))"
    Remove-ADObject $obj -Confirm:$false
}






