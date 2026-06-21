####################################################################################################
# RAPPORT DE SAUVEGARDE PAR EMAIL
# PowerShell 5.x / 7+
# Sauvegarde d'un dossier puis envoi automatique d'un rapport par email
####################################################################################################

# ==========================
# PARAMÈTRES
# ==========================

$Source      = "C:\Donnees"
$Destination = "D:\Backups"
$Date        = Get-Date -Format "yyyy-MM-dd_HH-mm-ss"

# Fichier ZIP de sauvegarde
$BackupFile = "$Destination\Backup_$Date.zip"

# Rapport
$Rapport = "$Destination\Rapport_Backup_$Date.txt"

# Configuration Email
$SMTPServer = "smtp.gmail.com"
$SMTPPort   = 587

$EmailFrom  = "admin@entreprise.com"
$EmailTo    = "direction@entreprise.com"

# Mot de passe SMTP sécurisé
$Password = ConvertTo-SecureString "VotreMotDePasse" -AsPlainText -Force
$Credential = New-Object System.Management.Automation.PSCredential($EmailFrom,$Password)

# ==========================
# DÉBUT DU RAPPORT
# ==========================

"==================================================" | Out-File $Rapport
"RAPPORT DE SAUVEGARDE AUTOMATIQUE" | Out-File $Rapport -Append
"==================================================" | Out-File $Rapport -Append
"Date : $(Get-Date)" | Out-File $Rapport -Append
"Source : $Source" | Out-File $Rapport -Append
"Destination : $BackupFile" | Out-File $Rapport -Append
"" | Out-File $Rapport -Append

try
{
    # ==========================
    # CRÉATION DE LA SAUVEGARDE
    # ==========================

    Compress-Archive `
        -Path "$Source\*" `
        -DestinationPath $BackupFile `
        -Force

    # Taille du fichier ZIP
    $SizeMB = [math]::Round((Get-Item $BackupFile).Length / 1MB,2)

    "STATUT : SUCCÈS" | Out-File $Rapport -Append
    "Fichier créé : $BackupFile" | Out-File $Rapport -Append
    "Taille : $SizeMB MB" | Out-File $Rapport -Append

    # Nombre de fichiers sauvegardés
    $NbFichiers = (Get-ChildItem $Source -Recurse -File).Count

    "Nombre de fichiers : $NbFichiers" | Out-File $Rapport -Append

}
catch
{
    "STATUT : ÉCHEC" | Out-File $Rapport -Append
    "Erreur : $_" | Out-File $Rapport -Append
}

# ==========================
# FIN DU RAPPORT
# ==========================

"" | Out-File $Rapport -Append
"Fin du traitement : $(Get-Date)" | Out-File $Rapport -Append

# Lecture du rapport
$Body = Get-Content $Rapport | Out-String

# ==========================
# ENVOI DU MAIL
# ==========================

Send-MailMessage `
    -From $EmailFrom `
    -To $EmailTo `
    -Subject "Rapport de Sauvegarde - $Date" `
    -Body $Body `
    -SmtpServer $SMTPServer `
    -Port $SMTPPort `
    -UseSsl `
    -Credential $Credential `
    -Attachments $Rapport

Write-Host ""
Write-Host "Sauvegarde terminée."
Write-Host "Rapport envoyé par email."
Write-Host ""

####################################################################################################
# PLANIFICATION AVEC LE PLANIFICATEUR DE TÂCHES WINDOWS
#
# Exécution quotidienne à 22h00 :
#
# powershell.exe -ExecutionPolicy Bypass -File C:\Scripts\BackupEmail.ps1
#
####################################################################################################