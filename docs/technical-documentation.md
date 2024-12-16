# Documentation Technique - SMS Bolt v1.0.0

## Architecture

### Vue d'Ensemble

SMS Bolt suit une architecture propre (Clean Architecture) avec une séparation claire des responsabilités :

```
lib/
  ├── core/                     # Composants centraux et utilitaires
  │   ├── config/              # Configuration de l'application
  │   ├── constants/           # Constantes globales
  │   └── di/                  # Injection de dépendances
  └── features/                # Fonctionnalités de l'application
      ├── sms_processing/      # Traitement des SMS
      ├── discord_integration/ # Intégration Discord
      └── gemini_integration/  # Intégration Google Gemini AI
```

### Couches de l'Architecture

1. **Présentation (UI)**
   - Widgets Flutter
   - Gestion d'état avec Riverpod
   - Pages et composants réutilisables

2. **Domaine**
   - Entités métier
   - Cas d'utilisation
   - Interfaces des repositories

3. **Data**
   - Implémentations des repositories
   - Sources de données (API, Local)
   - Modèles de données

## Composants Principaux

### 1. Traitement des SMS

Le traitement des SMS est géré par `SmsProcessingRepository` qui :
- Valide le format du SMS
- Extrait les informations pertinentes
- Détermine le type de transaction (ENTRANT/SORTANT)
- Formate les données pour l'affichage

### 2. Intégration Gemini AI

`GeminiRepository` utilise l'API Google Gemini pour :
- Analyser le contenu du SMS
- Extraire les informations structurées
- Identifier l'opérateur
- Détecter les anomalies

### 3. Intégration Discord

Le service Discord :
- Formate les messages selon un template défini
- Envoie les notifications via Webhook
- Gère les erreurs de communication

## Flux de Données

1. **Entrée SMS**
   ```
   UI -> SmsProcessingController -> GeminiRepository -> API Gemini
   ```

2. **Traitement**
   ```
   GeminiRepository -> SmsProcessingRepository -> DiscordService
   ```

3. **Sortie**
   ```
   SmsProcessingRepository -> UI + Discord Webhook
   ```

## Gestion d'État

### Riverpod

Utilisé pour :
- Gérer l'état global de l'application
- Fournir les dépendances
- Observer les changements d'état

### GetIt

Utilisé pour :
- Injection de dépendances
- Singletons des services
- Configuration initiale

## Sécurité

### Configuration

Les clés API sont stockées dans `AppConfig` :
```dart
class AppConfig {
  static const String discordWebhookUrl = '...';
  static const String geminiApiKey = '...';
}
```

### Bonnes Pratiques

- Validation des entrées utilisateur
- Gestion sécurisée des clés API
- Logs d'erreurs structurés
- Gestion des exceptions

## Tests

### Types de Tests

1. **Tests Unitaires**
   - Services
   - Repositories
   - Utilitaires

2. **Tests d'Intégration**
   - API Gemini
   - Webhook Discord
   - Flux complet

3. **Tests de Widget**
   - Composants UI
   - Interactions utilisateur

## Performance

### Optimisations

- Mise en cache des résultats Gemini
- Traitement asynchrone des requêtes
- Utilisation de `const` widgets
- Lazy loading des dépendances

### Métriques

- Temps de traitement des SMS < 2s
- Temps de réponse Discord < 1s
- Taille de l'application < 20MB

## Maintenance

### Logs

Format standard :
```dart
log.info('Processing SMS', {
  'operator': operator,
  'timestamp': timestamp,
  'status': status
});
```

### Gestion des Erreurs

Hiérarchie des exceptions :
```dart
class SmsProcessingException extends Exception
class GeminiException extends Exception
class DiscordException extends Exception
```

## Déploiement

### Prérequis

- Flutter SDK ≥ 3.0.0
- Dart SDK ≥ 3.0.0
- Clés API configurées

### Build

```bash
flutter build apk --release
flutter build ios --release
```

## API Reference

### GeminiRepository

```dart
Future<Map<String, dynamic>> processSms(String smsContent);
Future<String> detectOperator(String smsContent);
```

### SmsProcessingRepository

```dart
Future<void> processSmsContent(String content);
Future<void> sendToDiscord(Map<String, dynamic> data);
```

### DiscordService

```dart
Future<void> sendWebhook(String message);
Future<bool> testWebhook();
```

## Guides

### Ajout d'un Nouvel Opérateur

1. Ajouter dans `OperatorConstants`
2. Créer le parser spécifique
3. Mettre à jour les tests
4. Documenter le format

### Personnalisation des Messages Discord

1. Modifier `_formatDiscordMessage`
2. Tester le format
3. Mettre à jour la documentation

## Ressources

- [Flutter Documentation](https://docs.flutter.dev/)
- [Gemini AI API](https://ai.google.dev/)
- [Discord API](https://discord.com/developers/docs/)
