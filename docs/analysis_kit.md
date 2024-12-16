# 📱 Analysis Kit - SMS Bolt

## 📊 Formats des SMS par Opérateur

### 🟠 Orange Money

#### Format Entrant
```
Vous avez recu [MONTANT] USD de [EXPEDITEUR] ([TELEPHONE]) le [DATE]. Nouveau solde: [SOLDE] USD. Transaction ID: [REFERENCE]. Service Orange Money
```

#### Format Sortant
```
Vous avez envoyé [MONTANT] USD à [DESTINATAIRE] ([TELEPHONE]) le [DATE]. Nouveau solde: [SOLDE] USD. Transaction ID: [REFERENCE]. Service Orange Money
```

### 🔵 M-Pesa

#### Format Entrant
```
Vous avez reçu [MONTANT] USD de [EXPEDITEUR] - [TELEPHONE] le [DATE]. Votre solde est de [SOLDE] USD. ID de transaction: [REFERENCE]
```

#### Format Sortant
```
Transaction réussie. Vous avez envoyé [MONTANT] USD à [DESTINATAIRE] - [TELEPHONE]. Votre solde est de [SOLDE] USD. ID de transaction: [REFERENCE]
```

### 🔴 Airtel Money

#### Format Entrant
```
Vous avez reçu [MONTANT] USD de [EXPEDITEUR] ([TELEPHONE]). Nouveau solde: [SOLDE] USD. Ref: [REFERENCE]. Airtel Money
```

#### Format Sortant
```
Transfert de [MONTANT] USD vers [DESTINATAIRE] ([TELEPHONE]) effectué. Nouveau solde: [SOLDE] USD. Ref: [REFERENCE]. Airtel Money
```

## 🔍 Règles d'Analyse

### 1. Détection de l'Opérateur

```dart
Map<String, List<String>> operatorKeywords = {
  'ORANGE': ['Orange Money', 'Service Orange'],
  'MPESA': ['M-Pesa', 'Mpesa'],
  'AIRTEL': ['Airtel Money', 'Airtel'],
};
```

### 2. Détection du Type de Transaction

```dart
Map<String, List<String>> transactionTypeKeywords = {
  'ENTRANT': ['recu', 'reçu', 'received'],
  'SORTANT': ['envoyé', 'transfert', 'sent'],
};
```

### 3. Extraction des Données

#### Patterns Regex

```dart
final patterns = {
  'montant': r'\d+(\.\d{1,2})?\s*USD',
  'telephone': r'\d{10}',
  'reference': r'[A-Z0-9]{8,}',
  'solde': r'solde:?\s*\d+(\.\d{1,2})?\s*USD',
};
```

## 🎯 Prompts Gemini

### 1. Analyse Initiale
```
Analyse ce SMS de transaction mobile money et extrait les informations suivantes au format JSON :
- montant
- type (ENTRANT/SORTANT)
- expediteur/destinataire
- telephone
- solde
- reference
- operateur
```

### 2. Validation
```
Vérifie si ce SMS est une transaction valide et retourne :
{
  "isValid": true/false,
  "reason": "raison si invalide",
  "confidence": 0-100
}
```

## 🔄 Flux de Traitement

1. **Pré-traitement**
   ```dart
   String preprocessSms(String sms) {
     return sms
       .trim()
       .replaceAll(RegExp(r'\s+'), ' ')
       .toLowerCase();
   }
   ```

2. **Détection de l'Opérateur**
   ```dart
   String detectOperator(String sms) {
     for (var entry in operatorKeywords.entries) {
       if (entry.value.any((keyword) => 
         sms.toLowerCase().contains(keyword.toLowerCase()))) {
         return entry.key;
       }
     }
     return 'INCONNU';
   }
   ```

3. **Analyse Gemini**
   ```dart
   Future<Map<String, dynamic>> analyzeWithGemini(String sms) {
     // Utilisation de l'API Gemini pour l'analyse
     return geminiRepository.processSms(sms);
   }
   ```

4. **Post-traitement**
   ```dart
   Map<String, dynamic> postProcessResults(Map<String, dynamic> results) {
     return {
       ...results,
       'timestamp': DateTime.now(),
       'status': 'PROCESSED'
     };
   }
   ```

## 📈 Métriques de Qualité

### Précision
- Détection de l'opérateur : > 99%
- Extraction des montants : > 99%
- Détection du type : > 98%
- Extraction des références : > 97%

### Performance
- Temps de traitement moyen : < 2s
- Taux d'erreur : < 1%
- Faux positifs : < 0.1%

## 🚨 Gestion des Erreurs

### Codes d'Erreur
```dart
enum AnalysisError {
  INVALID_FORMAT,
  UNKNOWN_OPERATOR,
  MISSING_AMOUNT,
  MISSING_REFERENCE,
  NETWORK_ERROR,
  GEMINI_ERROR,
}
```

### Messages d'Erreur
```dart
Map<AnalysisError, String> errorMessages = {
  AnalysisError.INVALID_FORMAT: 'Format de SMS invalide',
  AnalysisError.UNKNOWN_OPERATOR: 'Opérateur non reconnu',
  AnalysisError.MISSING_AMOUNT: 'Montant non trouvé',
  AnalysisError.MISSING_REFERENCE: 'Référence manquante',
  AnalysisError.NETWORK_ERROR: 'Erreur réseau',
  AnalysisError.GEMINI_ERROR: 'Erreur d\'analyse Gemini',
};
```

## 📝 Logs d'Analyse

### Format
```json
{
  "timestamp": "2024-12-17T00:46:05+01:00",
  "smsId": "uuid-v4",
  "operator": "ORANGE",
  "type": "ENTRANT",
  "processingTime": 1.23,
  "success": true,
  "error": null,
  "confidence": 98.5
}
```

## 🔄 Mise à Jour des Règles

1. Ajouter un nouvel opérateur :
   ```dart
   // 1. Ajouter les mots-clés
   operatorKeywords['NOUVEAU'] = ['mot1', 'mot2'];
   
   // 2. Ajouter les patterns
   smsPatterns['NOUVEAU'] = {
     'entrant': r'pattern_entrant',
     'sortant': r'pattern_sortant'
   };
   
   // 3. Mettre à jour les tests
   testNewOperator();
   ```

2. Mettre à jour un pattern existant :
   ```dart
   // 1. Backup de l'ancien pattern
   backupPattern(operator, pattern);
   
   // 2. Tester le nouveau pattern
   testPattern(operator, newPattern);
   
   // 3. Déployer si les tests passent
   updatePattern(operator, newPattern);
   ```

## 📊 Tableau de Bord d'Analyse

```dart
class AnalysisDashboard {
  final int totalProcessed;
  final int successCount;
  final int errorCount;
  final double averageConfidence;
  final Map<String, int> operatorStats;
  final Map<String, int> errorTypes;
  final double averageProcessingTime;
}
```
