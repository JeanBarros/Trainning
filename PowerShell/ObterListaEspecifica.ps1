#Importa os módulos do SharePoint para o PowerShell
Import-Module Microsoft.Online.SharePoint.PowerShell -ErrorAction SilentlyContinue

Add-Type -Path "C:\Program Files\SharePoint Online Management Shell\Microsoft.Online.SharePoint.PowerShell\Microsoft.SharePoint.Client.dll"
Add-Type -Path "C:\Program Files\SharePoint Online Management Shell\Microsoft.Online.SharePoint.PowerShell\Microsoft.SharePoint.Client.Runtime.dll"

<#$siteUrl = "https://omintbr.sharepoint.com"
$username = "sharepoint_farm@omint.com.br"
$password=ConvertTo-SecureString "2@14_0mt" -AsPlainText -Force

$ctx = New-Object Microsoft.SharePoint.Client.ClientContext($siteUrl) 
$credentials = New-Object Microsoft.SharePoint.Client.SharePointOnlineCredentials($username, $password)
$ctx.Credentials = $credentials#>



Function New-Context([String]$WebUrl) {
    $context = New-Object Microsoft.SharePoint.Client.ClientContext($WebUrl)
    $context.Credentials = [System.Net.CredentialCache]::DefaultNetworkCredentials
    $context
}

Function Get-List([Microsoft.SharePoint.Client.ClientContext]$Context, [String]$ListTitle) {
    $list = $context.Web.Lists.GetByTitle($ListTitle)
    $context.Load($list)
    $context.ExecuteQuery()
    $list 
}

$context = New-Context -WebUrl "https://omintbr.sharepoint.com"
$list = Get-List -Context $context -ListTitle "Box"

$query = [Microsoft.SharePoint.Client.CamlQuery]::CreateAllItemsQuery()
$items = $list.GetItems($query)
$context.Load($items)
$context.ExecuteQuery()

$items.Count

foreach($item in $items)
{
   $item["Title"]
}

$context.Dispose()