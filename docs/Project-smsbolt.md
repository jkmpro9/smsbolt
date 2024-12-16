# Project SMSBolt: Overview

This document provides an overview of the SMSBolt project, a Flutter Android application designed to process incoming SMS messages and interact with external services.

## Project Goal

The primary goal of this application is to:

1. Read specific incoming SMS messages but for developping we will have an input feel to parse sms fr test.
2. Process the data within these messages based on a predefined XML template once and input sms to the input field.
3. Send key extracted information to Gemini AI for further processing.
4. Post the results obtained from Gemini AI to a designated Discord channel via a webhook.

## Directory Structure

The project is organized into the following directories:

```bash
smsbolt/
├── lib/
│   ├── main.dart: Application entry point.
│   ├── sms_processor.dart: Logic for processing SMS messages.
│   ├── discord_service.dart: Service for interacting with Discord.
│   ├── gemini_service.dart: Service for interacting with Gemini AI.
│   ├── xml_loader.dart: Module for loading and parsing the XML template.
│   └── screens/
│       └── home_screen.dart: Main user interface screen.
└── assets/
    └── templates/
        └── sms_templates.xml: XML template defining the structure for SMS processing.
```

### Detailed Breakdown:

-   **`lib/`**: This directory contains the core Dart code for the application.
    -   `main.dart`: This is the main entry point for the Flutter application. It initializes the app and likely sets up the root widget.
    -   `sms_processor.dart`: This file contains the logic for reading and processing incoming SMS messages. It likely extracts relevant data based on the patterns defined in the `sms_templates.xml` file.
    -   `discord_service.dart`: This file handles the communication with Discord. It likely uses the provided webhook URL to send messages to the specified channel.
    -   `gemini_service.dart`: This file manages the interaction with the Gemini AI service. It likely sends the extracted SMS data to Gemini AI and receives the processed results.
    -   `xml_loader.dart`: This file is responsible for loading and parsing the `sms_templates.xml` file. It likely provides functions to access the template data for use in `sms_processor.dart`.
    -   `screens/`: This subdirectory contains the UI code for the application.
        -   `home_screen.dart`: This file likely defines the main screen of the application, displaying relevant information to the user.
-   **`assets/`**: This directory contains static assets used by the application.
    -   `templates/`: This subdirectory holds template files.
        -   `sms_templates.xml`: This XML file defines the structure and rules for processing incoming SMS messages. It specifies how to extract data from the messages and potentially how to format it for Gemini AI.

## Discord Integration

The application is configured to post processed results to Discord using the following webhook URL:

`https://discordapp.com/api/webhooks/1311420704499040356/P1p3eldCL0uoSknV7eadeqjKwY9a2Sn6jDv3E6uzu9fj24Dy6bjUUnZPwJsYWTHll0td`

### Example Sms Messages:
Airtel Money USD (Entrant)
------------------------
Trans.ID:PP241127.0819.C19496. Vous avez recu 50.0000 USD de KALUNGA MARGUERITE 973022308. Nouveau solde: 239.1703 USD.

Airtel Money USD (Sortant)
-------------------------
Trans.ID:PP241127.1150.D35644. Vous avez envoye 42.0000 USD a MULUMBA JOSEPH974476191. Nouveau solde : 196.7503 USD. Cout:0.4200

Orange Money (USD) (Entrant) 
-------------------------
Vous avez recu 395 USD de ILOKO 0844452411. Nouveau solde: 420.104 USD. Ref: PP241108.1024.C30176

Orange Money (USD) - (Sortant)
--------------------------
Le retrait de 400 USD est effectue par le 0894422463 BULULU. Frais:  6.4 USD. Nouveau solde: 13.704 USD. Ref: CO241108.1325.B77543

M-Pesa USD (Entrant)
-------------------------
Le depot effectue par 3438592 - BYOMBE BWANA DEBABA a reussi Montant:10,00 USD Solde disponible:401,29 USD Reference de la transaction:BKP03ZVIAE4 le 25-11-2024 a 12:54:48.

M-Pesa USD (Sortant)
--------------------------
Le retrait  aupres de 2072188 - MPIANA TSHIKALA MATTHIEU2072188 du 25-11-2024 a 14:28:36 a reussi.
Montant:385,00 USD
Frais:7,70 USD
Reference :BKP33ZVXBZP
Solde disponible:0,00 USD.

### Format de Sortie Discord

Pour chaque SMS traité, le message sera formaté comme suit dans Discord :

```
*Paiement confirmé*
Montant : *[MONTANT] USD*
Balance : *[NOUVEAU_SOLDE] USD*
Nom : *[NOM_EXPEDITEUR]*
Tel : *[NUMERO_TELEPHONE]*
Ref : *[REFERENCE_TRANSACTION]*
ID Mobile : *[ID_TRANSACTION]*
Opérateur : *[NOM_OPERATEUR]*

DeliveredWith : CoBoLT
```

Exemple de sortie formatée :
```
*Paiement confirmé*
Montant : *50.0000 USD*
Balance : *239.1703 USD*
Nom : *KALUNGA MARGUERITE*
Tel : *973022308*
Ref : *PP241127*
ID Mobile : *PP241127.0819.C19496*
Opérateur : *Airtel Money*

DeliveredWith : CoBoLT
```

### Règles de Traitement

1. **Détection de l'Opérateur** :
   - Airtel Money : Messages commençant par "Trans.ID"
   - Orange Money : Messages contenant "Ref: PP" ou "Ref: CO"
   - M-Pesa : Messages contenant "Reference" ou "BKP"

2. **Type de Transaction** :
   - Entrant : Messages contenant "recu", "depot"
   - Sortant : Messages contenant "envoye", "retrait"

3. **Extraction des Données** :
   - Montant : Extraire le montant en USD avant "USD"
   - Balance : Extraire le nouveau solde après "solde:"
   - Nom : Extraire le nom après "de" ou avant le numéro
   - Téléphone : Extraire le numéro de téléphone
   - Référence : Extraire l'ID de transaction
   - ID Mobile : Extraire la référence complète

4. **Formatage** :
   - Tous les montants doivent être en USD
   - Les numéros de téléphone doivent inclure l'indicatif pays (+243)
   - Les noms doivent être en majuscules
   - Les références doivent être formatées selon le standard de l'opérateur

### Example Discord Messages:

The following examples demonstrate how the processed data will be displayed on Discord:
