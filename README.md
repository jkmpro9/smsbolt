# SMS Bolt v1.0.0

Une application Flutter moderne pour le traitement automatisé des SMS de transactions Mobile Money.

## 🌟 Fonctionnalités

- 📱 Traitement automatique des SMS de transactions
- 🤖 Analyse intelligente avec Google Gemini AI
- 💬 Intégration Discord pour les notifications
- 🎨 Interface utilisateur moderne et intuitive
- 📊 Historique des transactions
- 🔄 Support pour plusieurs opérateurs (Orange Money, M-Pesa, Airtel Money)

## 🚀 Installation

1. Clonez le dépôt :
```bash
git clone https://github.com/votre-username/smsbolt.git
cd smsbolt
```

2. Installez les dépendances :
```bash
flutter pub get
```

3. Configurez les variables d'environnement :
   - Créez un fichier `lib/core/config/app_config.dart`
   - Ajoutez vos clés API :
```dart
class AppConfig {
  static const String discordWebhookUrl = 'VOTRE_WEBHOOK_DISCORD';
  static const String geminiApiKey = 'VOTRE_CLE_API_GEMINI';
}
```

4. Lancez l'application :
```bash
flutter run
```

## 📱 Utilisation

1. Copiez le contenu du SMS de transaction
2. Collez-le dans l'application
3. Cliquez sur "Traiter le SMS"
4. Le résultat sera :
   - Affiché dans l'historique des transactions
   - Envoyé sur votre canal Discord configuré

## 🛠️ Technologies Utilisées

- Flutter & Dart
- Google Gemini AI
- Discord Webhooks
- Riverpod pour la gestion d'état
- GetIt pour l'injection de dépendances

## 📦 Dépendances

```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_riverpod: ^2.4.9
  google_generative_ai: ^0.1.0
  http: ^1.1.2
  get_it: ^7.6.4
  intl: ^0.19.0
```

## 🏗️ Architecture

L'application suit une architecture propre avec les couches suivantes :

```
lib/
  ├── core/
  │   ├── config/
  │   ├── constants/
  │   └── di/
  └── features/
      ├── sms_processing/
      ├── discord_integration/
      └── gemini_integration/
```

## 🎯 Fonctionnalités à Venir

- [ ] Support pour plus d'opérateurs
- [ ] Thème clair/sombre
- [ ] Export des transactions
- [ ] Filtrage et recherche
- [ ] Statistiques et graphiques

## 🤝 Contribution

Les contributions sont les bienvenues ! N'hésitez pas à :

1. Fork le projet
2. Créer une branche (`git checkout -b feature/amazing-feature`)
3. Commit vos changements (`git commit -m 'Add amazing feature'`)
4. Push sur la branche (`git push origin feature/amazing-feature`)
5. Ouvrir une Pull Request

## 📄 Licence

Distribué sous la licence MIT. Voir `LICENSE` pour plus d'informations.

## 👥 Auteurs

- Votre Nom - [@jkmpro](https://github.com/jkmpro)

## 🙏 Remerciements

- Google Gemini AI pour le traitement du texte
- Discord pour l'intégration des webhooks
- La communauté Flutter pour les packages incroyables
