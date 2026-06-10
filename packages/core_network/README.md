# core_network

> HTTP client, interceptors, connectivity checks, and API services built on Dio.

## Overview

Data layer for remote calls. Provides a configured Dio client with auth, connectivity, and retry interceptors, plus typed API services (`AuthService`, `UserService`) and exception mapping to domain errors.

**Does not contain repository implementations** — wiring lives in `core_state`.

## Features

- **`DioClientFactory`** — Creates isolated Dio instances per base URL
- **Interceptors** — Auth (token attach + refresh), connectivity, retry with backoff
- **Services** — `AuthService`, `UserService` with envelope parsing via `BaseApiService`
- **Exception mapping** — `ExceptionMapper` converts network errors to `AppErrorModel`
- **Env-driven config** — `ApiConfig` reads from `.env` via `flutter_dotenv`

## Installation

```yaml
dependencies:
  core_network:
  core_storage:    # required for TokenStorage in auth interceptor
  flutter_dotenv:
```

Copy and configure environment variables:

```env
API_BASE_URL=https://dummyjson.com
API_LIST_BASE_URL=https://list.dummyjson.com
API_USE_VERSION=false
ENVIRONMENT=development
```

See [apps/example_app/.env.example](../../apps/example_app/.env.example) and [api_example.md](../../api_example.md) for API samples.

## Usage

```dart
import 'package:core_network/core_network.dart';
import 'package:core_storage/core_storage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
```

## Examples

### Bootstrap Dio clients

```dart
await dotenv.load(fileName: '.env');

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
```

### Call API services

```dart
final authService = AuthService(client: mainClient);

final response = await authService.login(
  username: 'emilys',
  password: 'emilyspass',
);

if (response.data != null) {
  final session = response.data!;
  // persist tokens via TokenStorage
}
```

### Map errors in a repository

```dart
try {
  final resp = await authService.login(username: u, password: p);
  if (resp.data != null) return AppSuccess(resp.data!);
  return AppFailure(AppErrorModel(message: resp.message ?? 'Login failed'));
} on Object catch (e) {
  return AppFailure(ExceptionMapper.map(e));
}
```

## API / Components

### Client

| Type | Description |
|------|-------------|
| `DioClient` | Thin wrapper: `get`, `post`, `put`, `delete`, `request` |
| `DioClientConfig` | Per-instance: base URL, timeouts, auth, retry, public paths |
| `DioClientFactory` | Builds configured Dio with interceptors |
| `DioDefaultHeaders` | Common request headers |
| `DioErrorBodyParser` | Parses error response bodies |

### Config

| Type | Description |
|------|-------------|
| `ApiConfig` | `defaultConfig()`, `listConfig()` from env |
| `Endpoints` | Path constants (`signIn`, `signUp`, `refreshToken`, `listUsers`, etc.) |

### Interceptors

| Type | Description |
|------|-------------|
| `AuthInterceptor` | Bearer token, 401 refresh, session invalidation |
| `ConnectivityInterceptor` | Rejects requests when offline |
| `RetryInterceptor` | Exponential backoff for timeouts and 5xx |

### Services

| Type | Description |
|------|-------------|
| `BaseApiService` | Parses responses into `ApiResponseModel<T>` |
| `AuthService` | `login()`, `register()` |
| `UserService` | `getUserById()`, `getUsers()` |

### Connection & errors

| Type | Description |
|------|-------------|
| `NetworkInfoImpl` / `defaultNetworkInfo` | Connectivity check |
| `ConnectivityService` | Connection status stream |
| `ExceptionMapper` | Maps exceptions → `AppErrorModel` |
| Typed exceptions | `NoInternetException`, `ConnectionTimeoutException`, `BadResponseException`, etc. |

## Folder Structure

```
lib/
├── core_network.dart
└── src/
    ├── client/
    ├── config/
    ├── connection/
    ├── exception/
    ├── feature-services/
    │   ├── auth/
    │   └── user/
    ├── interceptor/
    ├── mapper/
    └── service/
```

## Notes / Limitations

- Default template targets [DummyJSON](https://dummyjson.com)
- `core_network` has **no DI** — register services in `core_state` or app bootstrap
- `PrettyDioLogger` is enabled in development for request/response logging

## Related Packages

- [core_domain](../core_domain/README.md) — models and `AppResult`
- [core_storage](../core_storage/README.md) — `TokenStorage` for auth interceptor
- [core_state](../core_state/README.md) — repository implementations
- [api_example.md](../../api_example.md)
- [Root README](../../README.md)

## License

License not specified. See root [README.md](../../README.md).
