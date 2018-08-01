#Importa os módulos do SharePoint para o PowerShell
Import-Module Microsoft.Online.SharePoint.PowerShell -Verbose

# Passa a conta de admin para a variável
$admin="sharepoint_farm@omint.com.br"

# Passa o nome da empresa para a variável
$orgName = "omintbr"

# chama o prompt para fazer o login
$userCredential = Get-Credential -UserName $admin -Message "pass"

# Conecta no SharePoint com os parâmetro fornecidos
Connect-SPOService -Url https://$orgName-admin.sharepoint.com -Credential $userCredential

# Lista todos os grupos do site
Get-SPOSiteGroup -Site https://$orgName.sharepoint.com/