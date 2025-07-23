# Scripts to reset users remotely

These are scripts to reset users in Windows Active Directory using Powershell.

**First you need to save credentials (hardcoded is not recommended) in separate files. I have used XML files to save credentials.**

- Save credential to a file (XML)

    ```pwsh
    $credential = Get-Credential
    $credential | Export-Clixml -Path "C:\secure\mycredential.xml"
    ```

- Retrieve credentials and use in your script

    ```pwsh
    $credential = Import-Clixml -Path "C:\secure\mycredential.xml"
    ```

