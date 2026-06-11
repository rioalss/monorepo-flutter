// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:core_domain/core_domain.dart' as _i856;
import 'package:core_network/core_network.dart' as _i309;
import 'package:core_state/src/di/register_module.dart' as _i625;
import 'package:core_state/src/features/auth/bloc/login_bloc.dart' as _i164;
import 'package:core_state/src/features/auth/bloc/register_bloc.dart' as _i1050;
import 'package:core_state/src/features/auth/getx/login_controller.dart'
    as _i1008;
import 'package:core_state/src/features/auth/getx/register_controller.dart'
    as _i84;
import 'package:core_state/src/features/locale/bloc/locale_cubit.dart' as _i438;
import 'package:core_state/src/features/locale/getx/locale_controller.dart'
    as _i567;
import 'package:core_state/src/features/locale/repositories/locale_repository.dart'
    as _i967;
import 'package:core_state/src/features/session/bloc/session_cubit.dart'
    as _i714;
import 'package:core_state/src/features/session/getx/session_controller.dart'
    as _i501;
import 'package:core_state/src/features/session/session_invalidation_hub.dart'
    as _i474;
import 'package:core_state/src/features/theme/bloc/theme_cubit.dart' as _i935;
import 'package:core_state/src/features/theme/getx/theme_controller.dart'
    as _i996;
import 'package:core_state/src/features/theme/repositories/theme_repository.dart'
    as _i48;
import 'package:core_state/src/features/user/bloc/user_detail_bloc.dart'
    as _i459;
import 'package:core_state/src/features/user/bloc/users_list_bloc.dart'
    as _i1029;
import 'package:core_state/src/features/user/getx/user_detail_controller.dart'
    as _i844;
import 'package:core_state/src/features/user/getx/users_list_controller.dart'
    as _i676;
import 'package:core_storage/core_storage.dart' as _i78;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    gh.lazySingleton<_i48.ThemeRepository>(
      () => registerModule.themeRepository(gh<_i856.ILocalStorage>()),
    );
    gh.lazySingleton<_i967.LocaleRepository>(
      () => registerModule.localeRepository(gh<_i856.ILocalStorage>()),
    );
    gh.lazySingleton<_i309.AuthService>(
      () => registerModule.authService(gh<_i309.DioClient>()),
    );
    gh.lazySingleton<_i714.SessionCubit>(
      () => _i714.SessionCubit(
        gh<_i78.TokenStorage>(),
        gh<_i474.SessionInvalidationHub>(),
      ),
    );
    gh.lazySingleton<_i501.SessionController>(
      () => _i501.SessionController(
        gh<_i78.TokenStorage>(),
        gh<_i474.SessionInvalidationHub>(),
      ),
    );
    gh.lazySingleton<_i309.UserService>(
      () => registerModule.userService(
        gh<_i309.DioClient>(),
        gh<_i309.DioClient>(instanceName: 'list'),
      ),
    );
    gh.lazySingleton<_i856.UserRepository>(
      () => registerModule.userRepository(gh<_i309.UserService>()),
    );
    gh.lazySingleton<_i438.LocaleCubit>(
      () => _i438.LocaleCubit(gh<_i967.LocaleRepository>()),
    );
    gh.lazySingleton<_i567.LocaleController>(
      () => _i567.LocaleController(gh<_i967.LocaleRepository>()),
    );
    gh.lazySingleton<_i935.ThemeCubit>(
      () => _i935.ThemeCubit(gh<_i48.ThemeRepository>()),
    );
    gh.lazySingleton<_i996.ThemeController>(
      () => _i996.ThemeController(gh<_i48.ThemeRepository>()),
    );
    gh.lazySingleton<_i856.AuthRepository>(
      () => registerModule.authRepository(
        gh<_i309.AuthService>(),
        gh<_i78.TokenStorage>(),
      ),
    );
    gh.factory<_i164.LoginBloc>(
      () => _i164.LoginBloc(gh<_i856.AuthRepository>()),
    );
    gh.factory<_i1050.RegisterBloc>(
      () => _i1050.RegisterBloc(gh<_i856.AuthRepository>()),
    );
    gh.factory<_i1008.LoginController>(
      () => _i1008.LoginController(gh<_i856.AuthRepository>()),
    );
    gh.factory<_i84.RegisterController>(
      () => _i84.RegisterController(gh<_i856.AuthRepository>()),
    );
    gh.factory<_i459.UserDetailBloc>(
      () => _i459.UserDetailBloc(gh<_i856.UserRepository>()),
    );
    gh.factory<_i1029.UsersListBloc>(
      () => _i1029.UsersListBloc(gh<_i856.UserRepository>()),
    );
    gh.factory<_i844.UserDetailController>(
      () => _i844.UserDetailController(gh<_i856.UserRepository>()),
    );
    gh.factory<_i676.UsersListController>(
      () => _i676.UsersListController(gh<_i856.UserRepository>()),
    );
    return this;
  }
}

class _$RegisterModule extends _i625.RegisterModule {}
