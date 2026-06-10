import 'package:core_state/core_state.dart';
import 'package:example_app/features/auth/login_page.dart';
import 'package:example_app/features/auth/register_page.dart';
import 'package:example_app/features/dashboard/dashboard_page.dart';
import 'package:example_app/features/splash/splash_page.dart';
import 'package:example_app/features/users/users_list_page.dart';
import 'package:example_app/router/go_router_refresh_stream.dart';
import 'package:example_app/router/route_paths.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

GoRouter createAppRouter({
  required SessionCubit sessionCubit,
}) {
  return GoRouter(
    initialLocation: RoutePaths.splash,
    refreshListenable: GoRouterRefreshStream(sessionCubit.stream),
    redirect: (context, state) {
      final session = sessionCubit.state;
      final location = state.matchedLocation;
      final onAuthRoute =
          location == RoutePaths.login || location == RoutePaths.register;

      if (session is SessionChecking) {
        return location == RoutePaths.splash ? null : RoutePaths.splash;
      }
      if (session is SessionUnauthenticated && !onAuthRoute) {
        return RoutePaths.login;
      }
      if (session is SessionAuthenticated &&
          (onAuthRoute || location == RoutePaths.splash)) {
        return RoutePaths.dashboard;
      }
      return null;
    },
    routes: [
      GoRoute(
        path: RoutePaths.splash,
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: RoutePaths.login,
        builder: (context, state) => BlocProvider(
          create: (_) => getIt<LoginBloc>(),
          child: const LoginPage(),
        ),
      ),
      GoRoute(
        path: RoutePaths.register,
        builder: (context, state) => BlocProvider(
          create: (_) => getIt<RegisterBloc>(),
          child: const RegisterPage(),
        ),
      ),
      GoRoute(
        path: RoutePaths.dashboard,
        builder: (context, state) => BlocProvider(
          create: (_) => getIt<UserDetailBloc>(),
          child: const DashboardPage(),
        ),
      ),
      GoRoute(
        path: RoutePaths.users,
        builder: (context, state) => BlocProvider(
          create: (_) => getIt<UsersListBloc>()..add(const UsersListRequested()),
          child: const UsersListPage(),
        ),
      ),
    ],
  );
}
