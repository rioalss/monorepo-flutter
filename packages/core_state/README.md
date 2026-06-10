# core_state

> Feature state, dependency injection, and repository implementations with BLoC, GetX, and Riverpod support.

## Overview

State and DI layer for the monorepo. Implements domain repository contracts, exposes feature state (auth, session, theme, user), and provides setup helpers for three state-management frameworks sharing the same sealed state classes.

For monorepo setup and Melos commands, see the [root README](../../README.md).

## Features

- **Triple framework support** — BLoC, GetX, and Riverpod for auth, session, theme, and user features
- **Sealed states** — `LoginState`, `SessionState`, etc. with `.when()` pattern matching
- **DI** — GetIt + injectable (BLoC/GetX) or manual Riverpod providers
- **Session bridge** — `SessionInvalidationHub` connects auth interceptor to logout flow
- **Repository impl** — `AuthRepositoryImpl`, `UserRepositoryImpl`, `ThemeRepositoryImpl` wire network + storage

## Layer Architecture

| Package | Contents | Must NOT contain |
|---------|----------|------------------|
| `core_domain` | Models, `AppResult`, abstract repositories | HTTP, Dio, implementations |
| `core_network` | Services, interceptors, `DioClient` | Repository, RepositoryImpl |
| `core_storage` | Secure/local/Drift implementations | Feature state |
| `core_state` | State, RepositoryImpl, DI | Direct HTTP calls |

## Installation

```yaml
dependencies:
  core_state:
  core_network:
  core_storage:
  flutter_dotenv:
```

Configure `.env` for the demo API — see [apps/example_app/.env.example](../../apps/example_app/.env.example) and [api_example.md](../../api_example.md).

## Usage

```dart
import 'package:core_state/core_state.dart';
```

## DI Rules

| Framework | DI mechanism | Location |
|-----------|--------------|----------|
| **BLoC** | `get_it` + `injectable` (build_runner) | `lib/src/di/` |
| **GetX** | `get_it` + `injectable` (build_runner) | `lib/src/di/` |
| **Riverpod** | Manual `Provider` / `NotifierProvider` | `lib/src/di/riverpod/`, `lib/src/features/*/riverpod/` |

`core_network` has **no DI** — wiring lives here only.

## Examples

### BLoC bootstrap (default in example_app)

```dart
await dotenv.load(fileName: '.env');

final localStorage = await HiveInitializer.initApp(subDirectory: 'my_app');

final tokenStorage = TokenStorage();
final sessionInvalidationHub = SessionInvalidationHub();
const factory = DioClientFactory();

final mainClient = factory.create(
  config: ApiConfig.defaultConfig(),
  tokenStorage: tokenStorage,
  onSessionInvalidated: sessionInvalidationHub.notify,
);

final listClient = factory.create(
  config: ApiConfig.listConfig(),
  tokenStorage: tokenStorage,
  onSessionInvalidated: sessionInvalidationHub.notify,
);

await const SetupBloc().init(
  registerDependencies: () async {
    registerExternalDependencies(
      dioClient: mainClient,
      listDioClient: listClient,
      tokenStorage: tokenStorage,
      sessionInvalidationHub: sessionInvalidationHub,
      localStorage: localStorage,
    );
    await configureDependencies();
  },
);

// App root
final sessionCubit = getIt<SessionCubit>();
final themeCubit = getIt<ThemeCubit>()..load();

// Per route
context.read<LoginBloc>().add(LoginSubmitted(username: u, password: p));
await context.read<SessionCubit>().onLoginSuccess();
```

After adding `@injectable` classes:

```bash
cd packages/core_state && dart run build_runner build --delete-conflicting-outputs
```

### Riverpod bootstrap

```dart
await dotenv.load(fileName: '.env');

final localStorage = await HiveInitializer.initApp(subDirectory: 'my_app');

await const SetupRiverpod().init();

runApp(
  SetupRiverpod.scope(
    overrides: [
      localStorageProvider.overrideWithValue(localStorage),
    ],
    child: const MyApp(),
  ),
);

// In a ConsumerWidget:
ref.read(themeProvider.notifier).load();
ref.read(loginProvider.notifier).login(username: u, password: p);
await ref.read(sessionProvider.notifier).onLoginSuccess();
final themeMode = ref.watch(themeProvider);
```

Reference implementation: `apps/example_app/lib/alternatives/riverpod/`

### GetX bootstrap

```dart
await const SetupGetX().init(
  registerDependencies: () async {
    registerExternalDependencies(/* same as BLoC */);
    await configureDependencies();
  },
);

// UI
Get.put(getIt<LoginController>());
Get.put(getIt<SessionController>());
```

Reference implementation: `apps/example_app/lib/alternatives/getx/`

## Feature State

| Feature | State | Success data |
|---------|-------|--------------|
| Session | `SessionState` | `SessionAuthenticated(userId)` |
| Login | `LoginState` | `AuthSessionModel` |
| Register | `RegisterState` | `UserModel` |
| User detail | `UserDetailState` | `UserModel` |
| Users list | `UsersListState` | `PaginatedResponseModel<UserModel>` |

### Session handling

| Framework | Type | Usage |
|-----------|------|-------|
| BLoC | `SessionCubit` | `getIt<SessionCubit>()` at app root |
| GetX | `SessionController` | `Get.put(getIt<SessionController>())` |
| Riverpod | `sessionProvider` | `ref.watch(sessionProvider)` |

After login: `onLoginSuccess()`. Logout: `logout()`. Router listens to session for redirects. `AuthInterceptor` notifies `SessionInvalidationHub` on 401 / refresh failure.

### UI state binding

```dart
// BLoC
BlocBuilder<LoginBloc, LoginState>(
  builder: (context, state) => state.when(
    initial: () => const SizedBox.shrink(),
    loading: () => const CircularProgressIndicator(),
    success: (session) => Text('Logged in: ${session.userId}'),
    failure: (message, _) => Text(message),
  ),
);

// Riverpod
ref.watch(loginProvider).when(
  initial: () => const SizedBox.shrink(),
  loading: () => const CircularProgressIndicator(),
  success: (session) => Text(session.userId),
  failure: (message, _) => Text(message),
);
```

### Repository result mapping (manual)

```dart
emit(const LoginLoading());
final result = await _repository.login(username: username, password: password);

switch (result) {
  case AppSuccess(:final data):
    emit(LoginSuccess(data));
  case AppFailure(:final error):
    emit(LoginFailure(
      message: error.message,
      error: error.originalError,
    ));
}
```

## API / Components

### Setup

| Type | Description |
|------|-------------|
| `SetupBloc` | BLoC + GetIt init |
| `SetupGetX` | GetX + GetIt init |
| `SetupRiverpod` | Riverpod init + `SetupRiverpod.scope()` |
| `StateManagementSetup` | Shared init contract |

### DI

| Type | Description |
|------|-------------|
| `getIt` / `configureDependencies()` | Injectable bootstrap |
| `registerExternalDependencies()` | App-provided Dio, token/local storage, session hub |
| `ServiceLocator` | Typed GetIt facade |
| `tokenStorageProvider`, `localStorageProvider`, `dioClientProvider`, etc. | Riverpod infrastructure |

### Features (per framework)

| Feature | BLoC | GetX | Riverpod |
|---------|------|------|----------|
| Auth | `LoginBloc`, `RegisterBloc` | `LoginController`, `RegisterController` | `loginProvider`, `registerProvider` |
| Session | `SessionCubit` | `SessionController` | `sessionProvider` |
| Theme | `ThemeCubit` | `ThemeController` | `themeProvider` |
| User | `UserDetailBloc`, `UsersListBloc` | Controllers | `userDetailProvider`, `usersListProvider` |

## Folder Structure

```
lib/
├── core_state.dart
└── src/
    ├── di/
    ├── features/
    │   ├── auth/
    │   ├── session/
    │   ├── theme/
    │   └── user/
    ├── repositories/
    └── setup/
```

Each feature folder contains `bloc/`, `getx/`, `riverpod/`, `state/`, and `repositories/`.

## Notes / Limitations

- Pick **one** state-management framework per app — do not mix BLoC and Riverpod in the same widget tree
- Riverpod alternatives do not use GetIt; BLoC/GetX require `build_runner` after DI changes
- Register flow (DummyJSON `POST /users/add`) returns `UserModel` — tokens are not saved on register

## Related Packages

- [core_domain](../core_domain/README.md) — contracts and models
- [core_network](../core_network/README.md) — HTTP services
- [core_storage](../core_storage/README.md) — token persistence
- [Root README](../../README.md)

## License

License not specified. See root [README.md](../../README.md).
