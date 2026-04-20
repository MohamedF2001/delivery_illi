# 🚀 ILLICO DELIVERY — Application Flutter

> Plateforme de livraison express & points de collecte · Cotonou & Abomey-Calavi

## 📁 Structure du projet

```
lib/
├── core/
│   ├── api/           api_client.dart (Dio + intercepteurs JWT)
│   ├── config/        app_config.dart · app_theme.dart · app_router.dart
│   ├── errors/        failures.dart (Failure freezed)
│   ├── utils/         formatters.dart · validators.dart
│   └── widgets/       loading_button · empty_state · error_display · statut_badge · demo_dialog
└── features/
    ├── auth/          Login · Register (OTP 2 étapes) · Profil
    ├── livraison/     Créer · Lister · Détail · Valider OTP · Upload preuve
    ├── livreur/       Missions · Toggle statut · Position GPS
    ├── point_illico/  Colis en stock · Réception · Retrait avec OTP
    ├── colis/         Liste · Détail · Alertes retard
    ├── vehicule/      CRUD (Admin)
    ├── zone/          CRUD (Admin)
    ├── tarif/         CRUD + Calculateur (Admin)
    ├── transaction/   Liste · Validation (Admin)
    ├── forfait/       Liste · Souscription · Vérification remise
    ├── notification/  Liste · Marquer lu
    └── admin/         Dashboard KPI · Shell navigation · Pages CRUD
```

## 🚀 Lancer le projet

```bash
# Installer les dépendances
flutter pub get

# App Client
flutter run -t lib/main.dart

# App Livreur
flutter run -t main_livreur.dart

# App Point ILLICO
flutter run -t main_point.dart

# Back-office Admin (Web)
flutter run -t main_admin.dart -d chrome
```

## 🌐 API

- **Production** : `https://illico-delivery.vercel.app/api`
- **Dev local** : `http://localhost:3000/api`

Modifier dans `lib/core/config/app_config.dart`

## 🔑 Authentification

| Rôle | Méthode | Identifiants |
|------|---------|--------------|
| Client | Téléphone + CodePIN | Inscription OTP en 2 étapes |
| Livreur | Téléphone + Mot de passe | Validation admin requise |
| Point ILLICO | Téléphone + Mot de passe | Activation admin requise |
| Admin | Email + Mot de passe | |

## 🎭 Mode Démo

Dans `lib/core/config/app_config.dart` :
```dart
const bool kDemoMode = false; // true = bloquer actions d'écriture
```

## 🏗️ Architecture

Clean Architecture Feature-First :
- **data** : DataSource (Dio) → Model (JSON) → Repository impl
- **domain** : Entity (Equatable) → Repository (interface) → UseCases
- **presentation** : StateNotifier + StateNotifierProvider → Pages

Toutes les couches data retournent `Either<Failure, T>` (fpdart).
