// =============================================================================
// REFERENCE ONLY — GetX structure. Mirror of: lib/features/users/users_list_page.dart
// =============================================================================
//
// import 'package:core_state/core_state.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class UsersListPageGetX extends StatelessWidget {
//   const UsersListPageGetX({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.find<UsersListController>();
//
//     return Scaffold(
//       appBar: AppBar(title: const Text('Users')),
//       body: Obx(() {
//         final state = controller.state;
//         return state.when(
//           initial: () => const Center(child: CircularProgressIndicator()),
//           loading: () => const Center(child: CircularProgressIndicator()),
//           success: (page) {
//             if (page.items.isEmpty) {
//               return const Center(child: Text('No users found'));
//             }
//             return ListView.separated(
//               padding: const EdgeInsets.symmetric(vertical: 8),
//               itemCount: page.items.length,
//               separatorBuilder: (_, __) => const Divider(height: 1),
//               itemBuilder: (context, index) {
//                 final user = page.items[index];
//                 return ListTile(
//                   title: Text(user.displayName),
//                   subtitle: Text(user.email ?? user.id),
//                 );
//               },
//             );
//           },
//           failure: (message, _) => Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(message, textAlign: TextAlign.center),
//                 const SizedBox(height: 16),
//                 FilledButton(
//                   onPressed: () => controller.getUsers(),
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
