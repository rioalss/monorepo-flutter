// =============================================================================
// REFERENCE ONLY — GetX structure. Mirror of: lib/features/dashboard/dashboard_page.dart
// =============================================================================
//
// import 'package:core_state/core_state.dart';
// import 'package:example_app/router/route_paths.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:go_router/go_router.dart';
//
// class DashboardPageGetX extends StatefulWidget {
//   const DashboardPageGetX({super.key});
//
//   @override
//   State<DashboardPageGetX> createState() => _DashboardPageGetXState();
// }
//
// class _DashboardPageGetXState extends State<DashboardPageGetX> {
//   late final UserDetailController _userDetailController;
//   late final SessionController _sessionController;
//
//   @override
//   void initState() {
//     super.initState();
//     _userDetailController = Get.find<UserDetailController>();
//     _sessionController = Get.find<SessionController>();
//     _loadUser();
//   }
//
//   Future<void> _loadUser() async {
//     final userId = _sessionController.state.userIdOrNull;
//     if (!mounted || userId == null || userId.isEmpty) return;
//     await _userDetailController.getUserById(userId);
//   }
//
//   Future<void> _logout() async {
//     await _sessionController.logout();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Dashboard'),
//         actions: [
//           IconButton(
//             onPressed: _logout,
//             icon: const Icon(Icons.logout),
//             tooltip: 'Logout',
//           ),
//         ],
//       ),
//       body: Obx(() {
//         final state = _userDetailController.state;
//         return state.when(
//           initial: () => const Center(child: Text('Loading profile...')),
//           loading: () => const Center(child: CircularProgressIndicator()),
//           success: (user) => Padding(
//             padding: const EdgeInsets.all(24),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Welcome, ${user.displayName}',
//                   style: AppTypography.fs24.semibold
//                       .color(context.colorTokens.onSurface),
//                 ),
//                 const SizedBox(height: 12),
//                 Text('ID: ${user.id}'),
//                 if (user.email != null) Text('Email: ${user.email}'),
//                 const SizedBox(height: 32),
//                 FilledButton.icon(
//                   onPressed: () => context.push(RoutePaths.users),
//                   icon: const Icon(Icons.people),
//                   label: const Text('View all users'),
//                 ),
//               ],
//             ),
//           ),
//           failure: (message, _) => Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(message, textAlign: TextAlign.center),
//                 const SizedBox(height: 16),
//                 FilledButton(
//                   onPressed: _loadUser,
//                   child: const Text('Retry'),
//                 ),
//               ],
//             ),
//           ),
//         );
//       }),
//     );
//   }
// }
