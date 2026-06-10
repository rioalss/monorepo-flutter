// =============================================================================
// REFERENCE ONLY — Riverpod structure. Mirror of: lib/router/app_router.dart
// =============================================================================
//
// import 'package:core_state/core_state.dart';
// import 'package:example_app/alternatives/riverpod/dashboard_page_riverpod.dart';
// import 'package:example_app/alternatives/riverpod/login_page_riverpod.dart';
// import 'package:example_app/alternatives/riverpod/register_page_riverpod.dart';
// import 'package:example_app/alternatives/riverpod/splash_page_riverpod.dart';
// import 'package:example_app/alternatives/riverpod/users_list_page_riverpod.dart';
// import 'package:example_app/router/route_paths.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:go_router/go_router.dart';
//
// final routerProvider = Provider<GoRouter>((ref) {
//   ref.watch(sessionProvider);
//
//   late final GoRouter router;
//   router = GoRouter(
//     initialLocation: RoutePaths.splash,
//     redirect: (context, state) {
//       final currentSession = ref.read(sessionProvider);
//       final location = state.matchedLocation;
//       final onAuthRoute =
//           location == RoutePaths.login || location == RoutePaths.register;
//
//       if (currentSession is SessionChecking) {
//         return location == RoutePaths.splash ? null : RoutePaths.splash;
//       }
//       if (currentSession is SessionUnauthenticated && !onAuthRoute) {
//         return RoutePaths.login;
//       }
//       if (currentSession is SessionAuthenticated &&
//           (onAuthRoute || location == RoutePaths.splash)) {
//         return RoutePaths.dashboard;
//       }
//       return null;
//     },
//     routes: [
//       GoRoute(
//         path: RoutePaths.splash,
//         builder: (context, state) => const SplashPageRiverpod(),
//       ),
//       GoRoute(
//         path: RoutePaths.login,
//         builder: (context, state) => const LoginPageRiverpod(),
//       ),
//       GoRoute(
//         path: RoutePaths.register,
//         builder: (context, state) => const RegisterPageRiverpod(),
//       ),
//       GoRoute(
//         path: RoutePaths.dashboard,
//         builder: (context, state) => const DashboardPageRiverpod(),
//       ),
//       GoRoute(
//         path: RoutePaths.users,
//         builder: (context, state) {
//           ref.read(usersListProvider.notifier).getUsers();
//           return const UsersListPageRiverpod();
//         },
//       ),
//     ],
//   );
//
//   ref.listen(sessionProvider, (_, __) => router.refresh());
//
//   return router;
// });
