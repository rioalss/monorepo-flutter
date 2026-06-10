// =============================================================================
// REFERENCE ONLY — GetX structure. Mirror of: lib/router/app_router.dart
// =============================================================================
//
// import 'package:core_state/core_state.dart';
// import 'package:example_app/alternatives/getx/dashboard_page_getx.dart';
// import 'package:example_app/alternatives/getx/login_page_getx.dart';
// import 'package:example_app/alternatives/getx/register_page_getx.dart';
// import 'package:example_app/alternatives/getx/splash_page_getx.dart';
// import 'package:example_app/alternatives/getx/users_list_page_getx.dart';
// import 'package:example_app/router/go_router_refresh_stream.dart';
// import 'package:example_app/router/route_paths.dart';
// import 'package:get/get.dart';
// import 'package:go_router/go_router.dart';
//
// /// Opsional: tambah di SessionController jika belum ada:
// /// Stream<SessionState> get sessionStream => _state.stream;
// GoRouter createAppRouterGetX({
//   required SessionController sessionController,
// }) {
//   return GoRouter(
//     initialLocation: RoutePaths.splash,
//     refreshListenable: GoRouterRefreshStream(
//       sessionController.sessionStream,
//     ),
//     redirect: (context, state) {
//       final session = sessionController.state;
//       final location = state.matchedLocation;
//       final onAuthRoute =
//           location == RoutePaths.login || location == RoutePaths.register;
//
//       if (session is SessionChecking) {
//         return location == RoutePaths.splash ? null : RoutePaths.splash;
//       }
//       if (session is SessionUnauthenticated && !onAuthRoute) {
//         return RoutePaths.login;
//       }
//       if (session is SessionAuthenticated &&
//           (onAuthRoute || location == RoutePaths.splash)) {
//         return RoutePaths.dashboard;
//       }
//       return null;
//     },
//     routes: [
//       GoRoute(
//         path: RoutePaths.splash,
//         builder: (context, state) => const SplashPageGetX(),
//       ),
//       GoRoute(
//         path: RoutePaths.login,
//         builder: (context, state) {
//           Get.lazyPut(() => getIt<LoginController>());
//           return const LoginPageGetX();
//         },
//       ),
//       GoRoute(
//         path: RoutePaths.register,
//         builder: (context, state) {
//           Get.lazyPut(() => getIt<RegisterController>());
//           return const RegisterPageGetX();
//         },
//       ),
//       GoRoute(
//         path: RoutePaths.dashboard,
//         builder: (context, state) {
//           Get.lazyPut(() => getIt<UserDetailController>());
//           return const DashboardPageGetX();
//         },
//       ),
//       GoRoute(
//         path: RoutePaths.users,
//         builder: (context, state) {
//           Get.lazyPut(() => getIt<UsersListController>());
//           Get.find<UsersListController>().getUsers();
//           return const UsersListPageGetX();
//         },
//       ),
//     ],
//   );
// }
