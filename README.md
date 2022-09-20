# BulkPasswordReset
A powershell script to reset passwords for a list of usernames automatically.

## Description
This is a powershell script designed to quickly reset the password for multiple accounts. 
script does the following in this order:
1. Reads through a textfile containing usernames that you want to reset the passwords of (one username per line)
2. For each user, first generates a random 15 character password with at least 3 non-alphanumeric characters
3. Resets the user's password to the randomly generated one
4. Sets the "Change password at next logon parameter"

## Usage
1. Download the bulk_password_reset.ps1 file.
2. Create a text file containing a list of users that need their passwords reset.
3. Change line 4 to point to your text file. That line should look like this: 

``` $users = Get-Content -Path E:\scripts\users.txt ```

4. If your password policy requires more than 15 characters, modify line 11:

``` $random_password = [System.Web.Security.Membership]::GeneratePassword(15,3) ```

The first number in `GeneratePassword` (15) is the password length. The second number (3) is the minimum number of non-alphanumeric characters that will be included in the password.
5. If you do not want to set the "Change password at next logon" parameter, delete or comment out line 18.

``` Get-ADUser $user | Set-AdUser -ChangePasswordAtLogon $true ```

Otherwise, it will set this parameter.


## Why?
This script was designed for incident response. If you have a large number of users that have been compromised or fell victim to a phishing campaign and you're not sure if they've entered their credentials or not, this script can help you quickly contain a potential incident and buy you some time for further investigation.
