# Flutter App Monorepo

A Flutter/Dart monorepo template with layered core packages, a shared design system, reusable UI components, and feature state that supports **BLoC**, **GetX**, and **Riverpod**.

## Overview

This workspace uses [Melos](https://melos.invertase.dev/) and Dart 3 workspace resolution to manage multiple apps and packages from a single root. Packages follow clean architecture: domain contracts and models are separated from network, storage, and state layers.

- **Dart SDK:** `^3.6.0`
- **Flutter:** `>=3.16.9`
- **Publishing:** Private (`publish_to: none`) — workspace-local packages only

## Features

- **Design system** — Material 3 theme, color tokens, typography, spacing, motion, and icons
- **Reusable UI** — Themed dialogs, bottom sheets, and date pickers
- **Clean architecture** — Domain, network, storage, and state layers with clear boundaries
- **Auth & session** — Login, register, token refresh, and session invalidation
- **Multi-framework state** — BLoC (default), GetX, and Riverpod implementations for the same features
- **Demo API** — [DummyJSON](https://dummyjson.com) integration with sample requests in [api_example.md](api_example.md)

## Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) (3.16.9 or newer)
- [Melos](https://melos.invertase.dev/) — install globally:

```bash
dart pub global activate melos
```

## Installation

```bash
git clone <repository-url>
cd template_flutter
dart pub get
melos bootstrap
cp apps/example_app/.env.example apps/example_app/.env
```

## Running the Example App

```bash
cd apps/example_app
flutter run
```

### Workspace Scripts

Run from the repository root via Melos:

| Command | Description |
|---------|-------------|
| `melos run get` | Run `flutter pub get` in all packages |
| `melos run analyze` | Run `dart analyze --fatal-infos` |
| `melos run test` | Run tests in packages with a `test/` folder |
| `melos run build:runner` | Run code generation (e.g. `core_state` injectable) |
| `melos run format` | Format all packages |

After adding `@injectable` classes in `core_state`:

```bash
melos run build:runner
```

## Packages

| Package | Purpose | Import | README |
|---------|---------|--------|--------|
| `design_system` | Theme, colors, typography, spacing, motion | `package:design_system/design_system.dart` | [packages/design_system/README.md](packages/design_system/README.md) |
| `core_ui` | Dialogs, bottom sheets, date pickers | `package:core_ui/core_ui.dart` | [packages/core_ui/README.md](packages/core_ui/README.md) |
| `core_domain` | Models, `AppResult`, repository contracts | `package:core_domain/core_domain.dart` | [packages/core_domain/README.md](packages/core_domain/README.md) |
| `core_network` | Dio client, interceptors, API services | `package:core_network/core_network.dart` | [packages/core_network/README.md](packages/core_network/README.md) |
| `core_storage` | Secure storage, Hive, Drift, token persistence | `package:core_storage/core_storage.dart` | [packages/core_storage/README.md](packages/core_storage/README.md) |
| `core_state` | Feature state, DI, repository implementations | `package:core_state/core_state.dart` | [packages/core_state/README.md](packages/core_state/README.md) |
| `core_utils` | Extensions, validators, debounce, pickers, logging | `package:core_utils/core_utils.dart` | [packages/core_utils/README.md](packages/core_utils/README.md) |

## Architecture

```
apps/example_app/
packages/
  design_system/     ← tokens only (no app dependencies)
  core_ui/           ← reusable widgets (depends on design_system)
  core_domain/       ← models, contracts, AppResult
  core_network/      ← HTTP client, services (no repository impl)
  core_storage/      ← secure/local/Drift storage
  core_state/        ← repository impl, BLoC/GetX/Riverpod, DI
  core_utils/        ← shared helpers
```

**Dependency flow:** Apps → `core_state` / `core_ui` / `design_system` → `core_network` / `core_storage` → `core_domain`

## Quick Start

Minimal bootstrap pattern (see [apps/example_app/lib/bootstrap/app_bootstrap.dart](apps/example_app/lib/bootstrap/app_bootstrap.dart)):

```dart
import 'package:core_network/core_network.dart';
import 'package:core_state/core_state.dart';
import 'package:core_storage/core_storage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> bootstrapApp() async {
  await dotenv.load(fileName: '.env');

  final tokenStorage = TokenStorage();
  final sessionInvalidationHub = SessionInvalidationHub();
  const factory = DioClientFactory();

  final mainClient = factory.create(
    config: ApiConfig.defaultConfig(),
    tokenStorage: tokenStorage,
    onSessionInvalidated: sessionInvalidationHub.notify,
  );

  await const SetupBloc().init(
    registerDependencies: () async {
      registerExternalDependencies(
        dioClient: mainClient,
        tokenStorage: tokenStorage,
        sessionInvalidationHub: sessionInvalidationHub,
      );
      await configureDependencies();
    },
  );
}
```

Apply the design system in your app root:

```dart
import 'package:design_system/design_system.dart';

MaterialApp(
  theme: AppTheme.light,
  darkTheme: AppTheme.dark,
  themeMode: ThemeMode.system,
  // ...
);
```

## Choosing State Management

| Framework | Setup helper | Example app location |
|-----------|--------------|----------------------|
| **BLoC** (default) | `SetupBloc` | `apps/example_app/lib/` |
| **Riverpod** | `SetupRiverpod` | `apps/example_app/lib/alternatives/riverpod/` |
| **GetX** | `SetupGetX` | `apps/example_app/lib/alternatives/getx/` |

All three share the same sealed state classes (`LoginState`, `SessionState`, etc.) and repository layer. Pick one setup helper and wire UI accordingly.

## Adding a New Feature

1. **Service** — Add `XxxService` in `core_network` (HTTP calls only)
2. **Contract** — Add abstract `XxxRepository` and models in `core_domain`
3. **Implementation** — Add `XxxRepositoryImpl` in `core_state`
4. **State & DI** — Add BLoC/GetX/Riverpod module and register in DI

See [packages/core_state/README.md](packages/core_state/README.md) for DI rules and codegen steps.

## Folder Structure

```
template_flutter/
├── apps/
│   └── example_app/          # Reference app (BLoC + go_router)
├── packages/
│   ├── core_domain/
│   ├── core_network/
│   ├── core_storage/
│   ├── core_state/
│   ├── core_ui/
│   ├── core_utils/
│   └── design_system/
├── api_example.md            # DummyJSON request/response samples
├── pubspec.yaml                # Workspace root + Melos config
└── README.md
```

## Notes / Limitations

- **Not published to pub.dev** — Add packages via workspace `resolution: workspace` in your app's `pubspec.yaml`
- **Demo API** — Defaults to DummyJSON; configure via `.env` (see [apps/example_app/.env.example](apps/example_app/.env.example))
- **FVM** — Not configured in this repo; use your project's Flutter version manager if needed *(optional)*
- **`AppNetworkImage`** — Exists in `core_ui` but is not exported from the public barrel *(optional: export if needed)*

## License

License not specified. Add a `LICENSE` file if you plan to open-source this project.
