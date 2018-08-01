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

# Adiciona todos os grupos em uma coleção
$Grupos = Get-SPOSiteGroup -Site https://$orgName.sharepoint.com

<foreach ($grupo in $Grupos)
{
    $nomeGrupo = $grupo.Title

    if ($nomeGrupo -ne "Aprovadores" -and $nomeGrupo -ne "Criadores" `        -and $nomeGrupo -ne "Leitores Restritos" -and $nomeGrupo -ne "Proprietários do Site da Equipe" `        -and $nomeGrupo -ne "Visitantes da Site da Equipe"-and $nomeGrupo -ne "Membros de Site da Equipe" `        -and $nomeGrupo -ne "Proprietários do Recursos Humanos" -and $nomeGrupo -ne "Visitantes da Recursos Humanos" `        -and $nomeGrupo -ne "Membros de Recursos Humanos") {

        # Remove o grupo conforme parâmetro especificado
        Remove-SPOSiteGroup -Site https://$orgName.sharepoint.com -Identity $nomeGrupo; 
    }
}