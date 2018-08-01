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

# Adiciona todos os usuários externos em uma coleção
$Usuarios = Get-SPOExternalUser -Position 0 -PageSize 50

foreach ($usuario in $Usuarios)
{
    $nomeUsuario = $usuario.DisplayName;

    if ($nomeUsuario -ne "Sharepoint Farm" -and $nomeUsuario -ne "Walter Aparecido Pereira da Silva" -and $nomeUsuario -ne "Julia Herrera Fernandes") {

        if ($usuario.DisplayName -ne $null)
        {
            # Remove o usuário conforme parâmetro especificado
            Remove-SPOExternalUser -UniqueIDs @($usuario.UniqueId)
        }
    }
}