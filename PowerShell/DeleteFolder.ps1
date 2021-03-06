﻿#Importa os módulos do SharePoint para o PowerShell
Import-Module Microsoft.Online.SharePoint.PowerShell -ErrorAction SilentlyContinue

Add-Type -Path "C:\Program Files\SharePoint Online Management Shell\Microsoft.Online.SharePoint.PowerShell\Microsoft.SharePoint.Client.dll"
Add-Type -Path "C:\Program Files\SharePoint Online Management Shell\Microsoft.Online.SharePoint.PowerShell\Microsoft.SharePoint.Client.Runtime.dll"

$siteUrl = "https://omintbr.sharepoint.com/OmintMedia"
$username = "sharepoint_farm@omint.com.br"
$password=ConvertTo-SecureString "2@14_0mt" -AsPlainText -Force

$ctx = New-Object Microsoft.SharePoint.Client.ClientContext($siteUrl)
$credentials = New-Object Microsoft.SharePoint.Client.SharePointOnlineCredentials($username, $password)

$ctx.Credentials = $credentials
$web = $ctx.Web
$lists = $web.Lists
$ctx.Load($lists)
$ctx.ExecuteQuery()

#$lists| select -Property Title, ID

$list = $ctx.Web.Lists.GetByTitle('Videos')
$ctx.Load($list)
$list.DeleteObject()
$list.Update()


<#Foreach ($lista in $lists)
{
    If ($lista.Title -match "Videos") {

	    $lista.AllowDeletion;
        $lista.DeleteObject();
        $lista.Update();
	    
        Write-Host "A lista" $lista.Title "foi excluída." -foregroundcolor Red
	}
    else {Write-Host "Nada foi removido." -foregroundcolor DarkGreen}
}#>