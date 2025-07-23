# Variables
$RemoteServer = # Provide your own AD server
$UsernameToReset = Read-Host "Enter the username to reset"
$Domain = # AD servers domain
$cred_wgbd = Import-Clixml -Path "~/reset_user/cred.xml"
$temp_pass = "Temp@123"

# Define the script block that runs remotely
$ScriptBlock = {
    param($User, $DomainName)
    
    # Import AD module (just in case)
    # Import-Module ActiveDirectory

    # Unlock the user account
    Unlock-ADAccount -Identity "$User"

    # Optionally: Reset password too
    Set-ADAccountPassword -Identity "$User" -Reset -NewPassword (ConvertTo-SecureString "$temp_pass" -AsPlainText -Force)
    Set-ADUser -Identity "$User" -ChangePasswordAtLogon $True -PasswordNeverExpires $False -CannotChangePassword $False

    # Debug purpose
    #Get-ADUser -Identity "$User" -Properties PasswordLastSet, PasswordExpired, CannotChangePassword, ChangePasswordAtLogon | Select-Object Name, Enabled, PasswordLastSet, PasswordExpired, CannotChangePassword, ChangePasswordAtLogon
    #Get-ADUser -Identity "$User" -Properties *

    Write-Output "User: $User Pass: $temp_pass"
}

# Invoke the command on the remote server
Invoke-Command -ComputerName $RemoteServer -ScriptBlock $ScriptBlock -Credential $cred_wgbd -ArgumentList $UsernameToReset, $Domain
