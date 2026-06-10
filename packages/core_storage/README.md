# core_storage

> Secure storage, Hive local storage, Drift SQLite, and authentication token persistence.

## Overview

Data layer for local persistence. Implements domain storage contracts (`ILocalStorage`, `ISecureStorage`) and provides typed helpers for auth tokens and a starter Drift database.

## Features

- **`SecureStorage`** — Encrypted key-value via `flutter_secure_storage`
- **`HiveLocalStorage`** — Non-sensitive typed key-value via Hive CE
- **`TokenStorage`** — Typed accessors for access/refresh tokens, expiry, userId
- **`AppDatabase`** — Drift SQLite with starter `ExampleItems` table
- **`HiveInitializer`** — Bootstrap helper for opening Hive boxes

## Installation

```yaml
dependencies:
  core_storage:
```

## Usage

```dart
import 'package:core_storage/core_storage.dart';
```

## Examples

### Initialize Hive and local storage

```dart
final localStorage = await HiveInitializer.initApp(subDirectory: 'my_app');

await localStorage.write(key: 'theme_mode', value: 'dark');
final themeMode = localStorage.read<String>(key: 'theme_mode');
```

Theme read/write logic lives in `core_state` — see `ThemeRepositoryImpl`, which uses the `theme_mode` key above.

### Persist auth tokens

```dart
final tokenStorage = TokenStorage();

await tokenStorage.saveTokens(
  accessToken: session.accessToken,
  refreshToken: session.refreshToken,
  userId: session.userId,
);

final isLoggedIn = await tokenStorage.isLoggedIn();
final accessToken = await tokenStorage.getAccessToken();

// On logout
await tokenStorage.clearTokens();
```

### Drift SQLite

```dart
final db = AppDatabase.connect();

await db.into(db.exampleItems).insert(
  ExampleItemsCompanion.insert(
    name: 'Sample',
    createdAt: DateTime.now().toUtc(),
  ),
);

final items = await db.select(db.exampleItems).get();
```

## API / Components

### Secure storage

| Type | Description |
|------|-------------|
| `SecureStorage` | Implements `ISecureStorage`; singleton `SecureStorage.instance` |
| `TokenStorage` | Auth token read/write/clear; wraps `ISecureStorage` |

### Local storage

| Type | Description |
|------|-------------|
| `HiveInitializer` | Singleton; `initApp()` bootstraps Hive + settings box; `openBox<T>()` for extra boxes |
| `HiveLocalStorage` | Implements `ILocalStorage`; usually obtained via `HiveInitializer.initApp()` |

### Database

| Type | Description |
|------|-------------|
| `AppDatabase` | Drift database at `app.sqlite` in documents directory |
| `ExampleItems` | Starter table for local data examples |

## Folder Structure

```
lib/
├── core_storage.dart
└── src/
    ├── auth/
    ├── database/
    │   └── tables/
    ├── local/
    └── secure/
```

## Notes / Limitations

- **Bootstrap order:** Call `HiveInitializer.initApp()` once before using `ILocalStorage` or opening extra boxes
- `TokenStorage` defaults to `SecureStorage.instance` — pass a custom `ISecureStorage` if needed
- `AppDatabase` includes a starter `ExampleItems` table — replace or extend for production schemas
- iOS secure storage uses `first_unlock_this_device` accessibility

## Related Packages

- [core_domain](../core_domain/README.md) — `ILocalStorage`, `ISecureStorage` contracts
- [core_network](../core_network/README.md) — uses `TokenStorage` in auth interceptor
- [core_state](../core_state/README.md) — registers storage in DI
- [Root README](../../README.md)

## License

License not specified. See root [README.md](../../README.md).
