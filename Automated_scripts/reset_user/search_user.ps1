$RemoteServer = "DC1.ACTIVEDIRECTORY.COM" # Give your AD domain
$cred = Import-Clixml -Path "~/reset_user/cred.xml"


# Ask user for input
$NameInput = Read-Host "Enter the display name (or part of the name) to search"

$ScriptBlock = {

    param($NameInput)

    # Search in Active Directory
    # Import-Module ActiveDirectory

    $Results = Get-ADUser -Filter "GivenName -like '*$NameInput*'" -Properties SamAccountName

    # Check if any results were found
    if ($Results) {
        foreach ($User in $Results) {
            Write-Output "Name: $($User.Name) | SamAccountName: $($User.SamAccountName)"
        }
    } else {
        Write-Output "No users found matching: $NameInput"
    }

}

Invoke-Command -ComputerName $RemoteServer -ScriptBlock $ScriptBlock -Credential $cred -ArgumentList $NameInput 