Import-Module ActiveDirectory
 
# List of usernames
$users = Get-Content -Path E:\scripts\users.txt
 
ForEach ($user in $users) 
{
    Add-Type -AssemblyName System.Web

    # Generate a 15 character password with at least 3 non-alphanumeric characters.
    $random_password = [System.Web.Security.Membership]::GeneratePassword(15,3)
    $password = ConvertTo-SecureString -AsPlainText $random_password -Force 

    # Set the default password for the current account
    Get-ADUser $user | Set-ADAccountPassword -NewPassword $password -Reset
    
    #  Force user to change password at next logon 
    Get-ADUser $user | Set-AdUser -ChangePasswordAtLogon $true
    
    # If you need to save the temporary password for each user, this will print it. Otherwise, remove this.
    Write-Host "$user : $random_password"
}
