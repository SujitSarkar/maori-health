# Maori Health

A Flutter application built with **Clean Architecture**, **BLoC** state management, and **GoRouter** navigation.

## System Requirements & Versions

| Technology | Version |
|-----------|---------|
| **Flutter** | 3.41.0 |
| **JDK** | 17.0.12 |
| **Xcode** | 26.2 |
| **Android API Level** | 36 |

## Setup

### 1. Install Flutter via FVM

```bash
fvm install 3.41.0
fvm use 3.41.0
```

### 2. Install Dependencies

```bash
fvm flutter pub get
```

## Useful Commands

```bash
# Analyze code
fvm flutter analyze

# Run tests
fvm flutter test

# Build APK (dev)
fvm flutter build apk --flavor dev -t lib/main_dev.dart

# Build APK (prod)
fvm flutter build apk --flavor prod -t lib/main_prod.dart
```

### 4. VS Code / Cursor

Launch configurations are pre-configured in `.vscode/launch.json` with four profiles:

- **Dev** — Debug mode, development environment
- **Prod** — Debug mode, production environment
- **Dev(Profile)** — Profile mode, development environment
- **Prod(Profile)** — Profile mode, production environment

## Project Structure

```
lib/
├── main_dev.dart                  # Dev entry point
├── main_prod.dart                 # Prod entry point
├── main_common.dart               # Shared bootstrap (DI, runApp)
│
├── core/                          # App-wide infrastructure
│   ├── config/                    # Constants, env config, string constants
│   ├── di/                        # Dependency injection (GetIt modules)
│   ├── error/                     # Exception & failure types
│   ├── network/                   # Dio client, interceptors, network checker
│   ├── result/                    # Result<E, V> sealed type
│   ├── router/                    # GoRouter setup & route names
│   ├── storage/                   # SecureStorage & SharedPreferences wrappers
│   ├── theme/                     # AppColors, AppTheme (Material 3, Poppins)
│   └── utils/                     # BuildContext extensions
│
├── data/                          # Data layer (remote datasources, models, repo impls)
├── domain/                        # Domain layer (entities, repositories, use cases)
│
└── presentation/                  # UI layer
    ├── app/                       # App widget, AppBloc (theme management)
    ├── dashboard/                 # Dashboard tab
    ├── schedule/                  # Schedule tab
    ├── notification/              # Notification tab
    ├── settings/                  # Settings tab
    ├── splash/                    # Splash screen
    └── shared/                    # Shared widgets (BottomNavBar, etc.)
```

## Architecture

This project follows **Clean Architecture** with three layers:

| Layer | Directory | Responsibility |
|---|---|---|
| **Presentation** | `lib/presentation/` | Widgets, pages, BLoC (state management) |
| **Domain** | `lib/domain/` | Entities, repository interfaces, use cases |
| **Data** | `lib/data/` | API datasources, models, repository implementations |

### Dependency Injection

Uses [GetIt](https://pub.dev/packages/get_it) with a modular registration pattern:

1. **Service Module** — `SecureStorageService`, `LocalCacheService`
2. **Network Module** — `DioClient`, `NetworkChecker`
3. **Feature Module** — BLoCs per feature

### Environment Configuration

Two environments are supported via `EnvConfig`:

| Environment | Entry Point | Base URL |
|---|---|---|
| Development | `lib/main_dev.dart` | `https://api.dev.maorihealth.com/api/v1/` |
| Production | `lib/main_prod.dart` | `https://api.maorihealth.com/api/v1/` |

### Navigation

- **GoRouter** with named routes
- **BottomNavigationBar** with 4 tabs: Dashboard, Schedule, Notification, Settings
- Splash screen on initial launch

### Theming

- Primary color: `#54E378`
- Material 3 with `ColorScheme.fromSeed`
- Google Fonts (Poppins)
- Light and dark theme support

## Adding a New Feature

1. Create domain entities in `lib/domain/<feature>/entities/`
2. Define the repository interface in `lib/domain/<feature>/repositories/`
3. Create use cases in `lib/domain/<feature>/usecases/`
4. Implement the remote datasource in `lib/data/<feature>/datasources/`
5. Create data models in `lib/data/<feature>/models/`
6. Implement the repository in `lib/data/<feature>/repositories/`
7. Create BLoC (events, states, bloc) in `lib/presentation/<feature>/bloc/`
8. Build pages and widgets in `lib/presentation/<feature>/pages/` and `widgets/`
9. Register all dependencies in `lib/core/di/feature_module.dart`
10. Add routes in `lib/core/router/app_router.dart`
