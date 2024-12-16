# Guide de Contribution

Merci de votre intérêt pour contribuer à SMS Bolt ! Ce document fournit des lignes directrices pour contribuer au projet.

## Code de Conduite

- Soyez respectueux et professionnel
- Écrivez des messages de commit clairs
- Documentez vos changements
- Testez votre code

## Process de Contribution

1. Fork le projet
2. Créez votre branche (`git checkout -b feature/amazing-feature`)
3. Committez vos changements (`git commit -m 'Add amazing feature'`)
4. Push sur la branche (`git push origin feature/amazing-feature`)
5. Ouvrez une Pull Request

## Standards de Code

### Dart/Flutter

- Suivez les [Dart Style Guide](https://dart.dev/guides/language/effective-dart/style)
- Utilisez `flutter format .` avant de committer
- Exécutez `flutter analyze` pour vérifier les problèmes

### Nommage

- Classes : `PascalCase`
- Variables/fonctions : `camelCase`
- Constantes : `SCREAMING_SNAKE_CASE`
- Fichiers : `snake_case`

### Structure des Fichiers

```
lib/
  ├── feature_name/
  │   ├── data/
  │   │   ├── models/
  │   │   └── repositories/
  │   ├── domain/
  │   │   ├── entities/
  │   │   └── repositories/
  │   └── presentation/
  │       ├── pages/
  │       └── widgets/
```

### Tests

- Écrivez des tests pour chaque nouvelle fonctionnalité
- Maintenez une couverture de tests > 80%
- Utilisez des noms de tests descriptifs

## Documentation

### Commentaires de Code

```dart
/// Documentation de classe
class MyClass {
  /// Documentation de méthode
  void myMethod() {
    // Commentaire inline
  }
}
```

### README

- Gardez le README à jour
- Documentez les nouvelles fonctionnalités
- Mettez à jour les instructions d'installation

## Pull Requests

### Titre

Format : `[TYPE] Description courte`

Types :
- `[FEATURE]` : Nouvelle fonctionnalité
- `[FIX]` : Correction de bug
- `[DOCS]` : Documentation
- `[REFACTOR]` : Refactoring
- `[TEST]` : Tests

### Description

- Expliquez le problème résolu
- Listez les changements majeurs
- Mentionnez les issues liées
- Ajoutez des captures d'écran si pertinent

### Checklist

- [ ] Tests ajoutés/mis à jour
- [ ] Documentation mise à jour
- [ ] Code formaté
- [ ] Analyse passée
- [ ] Conflits résolus

## Issues

### Création d'Issue

- Utilisez les templates fournis
- Ajoutez des labels appropriés
- Soyez précis dans la description

### Labels

- `bug` : Problème confirmé
- `enhancement` : Nouvelle fonctionnalité
- `documentation` : Documentation
- `good first issue` : Pour nouveaux contributeurs

## Review de Code

### Processus

1. Vérifiez le style de code
2. Testez les changements
3. Vérifiez la documentation
4. Donnez un feedback constructif

### Critères

- Code lisible et maintainable
- Tests appropriés
- Documentation à jour
- Pas de régressions

## Release

### Versioning

Suivez [Semantic Versioning](https://semver.org/) :
- MAJOR : Changements incompatibles
- MINOR : Nouvelles fonctionnalités
- PATCH : Corrections de bugs

### Changelog

- Listez tous les changements
- Groupez par type
- Mentionnez les contributeurs

## Support

- Utilisez les issues pour les bugs
- Utilisez les discussions pour les questions
- Rejoignez notre Discord

## Licence

En contribuant, vous acceptez que votre code soit sous licence MIT.
