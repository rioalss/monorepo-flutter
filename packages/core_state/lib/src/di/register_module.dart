/// Injectable module that wires network services and repositories into GetIt.
///
/// Used by the BLoC / GetX path after external clients and storage are
/// registered via [registerExternalDependencies].

library;

import 'package:core_domain/core_domain.dart';
import 'package:core_network/core_network.dart';
import 'package:core_state/src/features/auth/repositories/auth_repository_impl.dart';
import 'package:core_state/src/features/locale/repositories/locale_repository.dart';
import 'package:core_state/src/features/locale/repositories/locale_repository_impl.dart';
import 'package:core_state/src/features/theme/repositories/theme_repository.dart';
import 'package:core_state/src/features/theme/repositories/theme_repository_impl.dart';
import 'package:core_state/src/features/user/repositories/user_repository_impl.dart';
import 'package:core_storage/core_storage.dart';
import 'package:injectable/injectable.dart';

/// Wires the data layer into GetIt (BLoC / GetX path).
@module
abstract class RegisterModule {
  /// Provides persistent theme preference storage via [ILocalStorage].
  @lazySingleton
  ThemeRepository themeRepository(ILocalStorage localStorage) =>
      ThemeRepositoryImpl(localStorage: localStorage);

  /// Provides persistent locale preference storage via [ILocalStorage].
  @lazySingleton
  LocaleRepository localeRepository(ILocalStorage localStorage) =>
      LocaleRepositoryImpl(localStorage: localStorage);

  /// Creates the auth API client bound to the primary [DioClient].
  @lazySingleton
  AuthService authService(DioClient client) => AuthService(client: client);

  /// Creates the user API client using primary and list-scoped [DioClient] instances.
  @lazySingleton
  UserService userService(
    DioClient client,
    @Named('list') DioClient listClient,
  ) =>
      UserService(
        client: client,
        listClient: listClient,
      );

  /// Maps [AuthService] responses to domain results and persists tokens on login.
  @lazySingleton
  AuthRepository authRepository(
    AuthService service,
    TokenStorage tokenStorage,
  ) =>
      AuthRepositoryImpl(
        service: service,
        tokenStorage: tokenStorage,
      );

  /// Maps [UserService] responses to domain [UserRepository] operations.
  @lazySingleton
  UserRepository userRepository(UserService service) =>
      UserRepositoryImpl(service: service);
}
