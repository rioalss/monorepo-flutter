/// Public entry point for the `core_state` package.
///
/// Re-exports dependency injection, feature state (auth, locale, session, theme, user),
/// and setup helpers for BLoC, GetX, and Riverpod.
library;

// DI
export 'src/di/external_dependencies.dart';
export 'src/di/injection.dart';
export 'src/di/riverpod/infrastructure_providers.dart';
export 'src/di/service_locator.dart';

// Features — auth
export 'src/features/auth/bloc/login_bloc.dart';
export 'src/features/auth/bloc/login_event.dart';
export 'src/features/auth/bloc/register_bloc.dart';
export 'src/features/auth/bloc/register_event.dart';
export 'src/features/auth/getx/login_controller.dart';
export 'src/features/auth/getx/register_controller.dart';
export 'src/features/auth/riverpod/auth_providers.dart';
export 'src/features/auth/state/login_state.dart';
export 'src/features/auth/state/register_state.dart';

// Features — locale
export 'src/features/locale/bloc/locale_cubit.dart';
export 'src/features/locale/getx/locale_controller.dart';
export 'src/features/locale/repositories/locale_repository.dart';
export 'src/features/locale/repositories/locale_repository_impl.dart';
export 'src/features/locale/riverpod/locale_providers.dart';

// Features — session
export 'src/features/session/bloc/session_cubit.dart';
export 'src/features/session/getx/session_controller.dart';
export 'src/features/session/riverpod/session_providers.dart';
export 'src/features/session/session_invalidation_hub.dart';
export 'src/features/session/state/session_state.dart';

// Features — theme
export 'src/features/theme/bloc/theme_cubit.dart';
export 'src/features/theme/getx/theme_controller.dart';
export 'src/features/theme/repositories/theme_repository.dart';
export 'src/features/theme/repositories/theme_repository_impl.dart';
export 'src/features/theme/riverpod/theme_providers.dart';

// Features — user
export 'src/features/user/bloc/user_detail_bloc.dart';
export 'src/features/user/bloc/user_detail_event.dart';
export 'src/features/user/bloc/users_list_bloc.dart';
export 'src/features/user/bloc/users_list_event.dart';
export 'src/features/user/getx/user_detail_controller.dart';
export 'src/features/user/getx/users_list_controller.dart';
export 'src/features/user/riverpod/user_providers.dart';
export 'src/features/user/state/user_detail_state.dart';
export 'src/features/user/state/users_list_state.dart';

// Setup
export 'src/setup/setup_bloc.dart';
export 'src/setup/setup_getx.dart';
export 'src/setup/setup_riverpod.dart';
export 'src/setup/state_management_setup.dart';
