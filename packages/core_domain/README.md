# core_domain

> Domain models, repository contracts, API envelopes, and the `AppResult` type for clean architecture.

## Overview

Pure domain layer with no Flutter UI, HTTP, or storage dependencies. Defines what the app works with — user/auth models, repository interfaces, response wrappers, and safe JSON parsing — without knowing how data is fetched or persisted.

## Features

- **`AppResult<T>`** — Sealed success/failure type for repositories (no exceptions in UI)
- **Freezed models** — `AuthSessionModel`, `UserModel`, API response envelopes
- **Repository contracts** — `AuthRepository`, `UserRepository`
- **Storage/network contracts** — `ILocalStorage`, `ISecureStorage`, `NetworkInfo`
- **Safe JSON** — Defensive parsers and converters for unreliable API payloads

## Installation

```yaml
dependencies:
  core_domain:
```

## Usage

```dart
import 'package:core_domain/core_domain.dart';
```

## Examples

### Handle repository results

```dart
Future<void> loadUser(UserRepository repo) async {
  final result = await repo.getUserById('42');

  result.when(
    success: (user) => print(user.displayName),
    failure: (error) => print(error.message),
  );
}
```

### Pattern match on `AppResult`

```dart
final result = await authRepository.login(username: u, password: p);

switch (result) {
  case AppSuccess(:final data):
    await tokenStorage.saveTokens(
      accessToken: data.accessToken,
      refreshToken: data.refreshToken,
      userId: data.userId,
    );
  case AppFailure(:final error):
    showError(error.message);
}
```

### Safe model parsing

```dart
final user = safeParseModel(
  () => UserModel.fromJson(json),
  debugLabel: 'UserModel.fromJson',
);
```

## API / Components

### Result type

| Type | Description |
|------|-------------|
| `AppResult<T>` | Sealed base — `AppSuccess<T>` or `AppFailure<T>` |
| `AppErrorModel` | Structured error with `message`, `statusCode`, `originalError` |
| `AppResultX` | Extensions: `when`, `dataOrNull`, `errorOrNull`, `isSuccess` |

### Models

| Type | Description |
|------|-------------|
| `AuthSessionModel` | `accessToken`, `refreshToken`, `userId` |
| `UserModel` | User profile with `displayName` getter |
| `ApiResponseModel<T>` | Generic API envelope |
| `ApiErrorModel` | API-level error payload |
| `PaginatedResponseModel<T>` | Paginated list with meta |
| `PaginatedMetaModel` | Pagination metadata |

### Contracts

| Type | Description |
|------|-------------|
| `AuthRepository` | Login/register abstract interface |
| `UserRepository` | User fetch/list abstract interface |
| `ILocalStorage` | Non-sensitive key-value contract |
| `ISecureStorage` | Encrypted key-value contract |
| `NetworkInfo` | Connectivity check contract |

### Safe JSON

| Export | Description |
|--------|-------------|
| `safe_json_parsers.dart` | `safeParseModel`, `safeParseModelOrDefault` |
| `safe_json_converters.dart` | `SafeIntConverter`, `SafeStringConverter`, `SafeEnumConverter`, etc. |

## Folder Structure

```
lib/
├── core_domain.dart
└── src/
    ├── contracts/
    ├── converters/
    ├── features/
    │   ├── auth/
    │   └── user/
    ├── models/
    │   ├── response/
    │   └── result/
    ├── parsers/
    └── utils/
```

## Notes / Limitations

- Repository **implementations** live in `core_state`, not here
- HTTP services live in `core_network`
- Models use `freezed` + `json_serializable` — run codegen after changes

## Related Packages

- [core_state](../core_state/README.md) — repository implementations
- [core_network](../core_network/README.md) — HTTP services
- [core_storage](../core_storage/README.md) — storage implementations
- [Root README](../../README.md)

## License

License not specified. See root [README.md](../../README.md).
