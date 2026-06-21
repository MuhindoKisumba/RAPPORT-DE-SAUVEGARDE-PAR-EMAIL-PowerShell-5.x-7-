#  Rapport de Sauvegarde Automatique par Email avec PowerShell

##  Description

Ce script PowerShell automatise la sauvegarde d'un dossier, génère un rapport détaillé de l'opération et envoie ce rapport par courrier électronique aux administrateurs ou responsables informatiques.

Il constitue une solution simple et efficace pour superviser les sauvegardes quotidiennes sans avoir à vérifier manuellement les fichiers générés.

---

#  Objectifs

- Sauvegarder automatiquement un dossier.
- Compresser les données au format ZIP.
- Générer un rapport détaillé de l'opération.
- Calculer la taille de la sauvegarde.
- Compter le nombre de fichiers sauvegardés.
- Détecter les erreurs de sauvegarde.
- Envoyer automatiquement un rapport par email.
- Permettre l'exécution planifiée via le Planificateur de tâches Windows.

---

#  Architecture du Script

```text
Dossier Source
       │
       ▼
Compression ZIP
       │
       ▼
Génération Rapport TXT
       │
       ▼
Envoi Email SMTP
       │
       ▼
Réception du Rapport
```

---

#  Fonctionnalités

## 1. Configuration des paramètres

Le script permet de définir :

- Le dossier source à sauvegarder.
- Le dossier de destination.
- Le serveur SMTP.
- Le compte expéditeur.
- Le compte destinataire.

Exemple :

```powershell
$Source      = "C:\Donnees"
$Destination = "D:\Backups"
```

---

## 2. Génération automatique du nom de sauvegarde

Chaque sauvegarde reçoit un horodatage unique.

Exemple :

```text
Backup_2026-06-21_22-00-00.zip
```

Cela évite l'écrasement des sauvegardes précédentes.

---

## 3. Compression des données

Le script utilise :

```powershell
Compress-Archive
```

pour créer automatiquement une archive ZIP.

Exemple :

```text
D:\Backups\Backup_2026-06-21_22-00-00.zip
```

---

## 4. Création du rapport

Le rapport contient :

- Date et heure.
- Dossier source.
- Fichier ZIP généré.
- Taille de la sauvegarde.
- Nombre de fichiers sauvegardés.
- État de la sauvegarde.
- Message d'erreur éventuel.

Exemple :

```text
==================================================
RAPPORT DE SAUVEGARDE AUTOMATIQUE
==================================================

Date : 21/06/2026 22:00:00

Source : C:\Donnees

Destination :
D:\Backups\Backup_2026-06-21_22-00-00.zip

STATUT : SUCCÈS

Fichier créé :
D:\Backups\Backup_2026-06-21_22-00-00.zip

Taille : 145.22 MB

Nombre de fichiers : 256

Fin du traitement :
21/06/2026 22:01:10
```

---

## 5. Gestion des erreurs

Le script utilise :

```powershell
try
{
}
catch
{
}
```

afin de :

- Capturer les erreurs.
- Journaliser les incidents.
- Envoyer les informations d'échec.

Exemple :

```text
STATUT : ÉCHEC

Erreur :
Accès refusé au dossier source.
```

---

## 6. Envoi automatique du rapport

Le rapport est transmis par email via SMTP.

Paramètres :

```powershell
$SMTPServer = "smtp.gmail.com"
$SMTPPort   = 587
```

Le rapport est :

- intégré dans le corps du message ;
- joint au format TXT.

---

#  Exemple d'Email Reçu

Objet :

```text
Rapport de Sauvegarde - 2026-06-21_22-00-00
```

Contenu :

```text
RAPPORT DE SAUVEGARDE AUTOMATIQUE

STATUT : SUCCÈS

Taille : 145.22 MB

Nombre de fichiers : 256
```

Pièce jointe :

```text
Rapport_Backup_2026-06-21_22-00-00.txt
```

---

#  Arborescence Recommandée

```text
C:\
│
├── Scripts
│   └── BackupEmail.ps1
│
├── Donnees
│   ├── Documents
│   ├── Images
│   └── Rapports
│
└── Backups
    ├── Backup_2026-06-21.zip
    ├── Backup_2026-06-22.zip
    └── Rapport_Backup.txt
```

---

#  Sécurité

Bonnes pratiques :

- Ne jamais stocker les mots de passe en clair.
- Utiliser un coffre-fort de secrets.
- Restreindre les permissions du dossier de sauvegarde.
- Chiffrer les archives sensibles.
- Utiliser TLS pour les communications SMTP.

---

#  Automatisation avec le Planificateur de Tâches

Commande :

```powershell
powershell.exe -ExecutionPolicy Bypass -File C:\Scripts\BackupEmail.ps1
```

Planification recommandée :

| Fréquence | Heure |
|------------|--------|
| Quotidienne | 22h00 |
| Hebdomadaire | Dimanche 23h00 |
| Mensuelle | Dernier jour du mois |

---

#  Compatibilité

- Windows 10
- Windows 11
- Windows Server 2016
- Windows Server 2019
- Windows Server 2022
- PowerShell 5.1
- PowerShell 7+

---

#  Informations Collectées

Le rapport inclut :

| Information | Description |
|------------|-------------|
| Date | Date de la sauvegarde |
| Source | Dossier sauvegardé |
| Destination | Archive ZIP générée |
| Taille | Taille totale de la sauvegarde |
| Nombre de fichiers | Nombre d'éléments sauvegardés |
| Statut | Succès ou échec |
| Erreur | Détails de l'incident |

---

#  Cas d'Utilisation

- Sauvegarde de serveurs de fichiers.
- Sauvegarde de postes utilisateurs.
- Sauvegarde de bases documentaires.
- Archivage quotidien.
- Contrôle de conformité.
- Audit informatique.
- Continuité d'activité.
- Supervision des sauvegardes.

---

#  Résultat

Cette solution PowerShell fournit :

- Une sauvegarde automatisée.
- Une compression ZIP.
- Un rapport détaillé.
- Une notification email.
- Une détection d'erreurs.
- Une automatisation complète des opérations de sauvegarde.

Elle constitue une base solide pour mettre en place un système de sauvegarde et de supervision dans un environnement professionnel Windows.
