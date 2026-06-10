// =============================================================================
// REFERENCE ONLY — GetX structure. Mirror of: lib/features/auth/register_page.dart
// =============================================================================
//
// import 'package:core_state/core_state.dart';
// import 'package:example_app/router/route_paths.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:go_router/go_router.dart';
//
// class RegisterPageGetX extends StatefulWidget {
//   const RegisterPageGetX({super.key});
//
//   @override
//   State<RegisterPageGetX> createState() => _RegisterPageGetXState();
// }
//
// class _RegisterPageGetXState extends State<RegisterPageGetX> {
//   final _formKey = GlobalKey<FormState>();
//   final _firstNameController = TextEditingController();
//   final _lastNameController = TextEditingController();
//   final _ageController = TextEditingController();
//   late final RegisterController _registerController;
//   Worker? _registerWorker;
//
//   @override
//   void initState() {
//     super.initState();
//     _registerController = Get.find<RegisterController>();
//     _registerWorker = ever<RegisterState>(
//       _registerController.rxState,
//       (state) {
//         if (state is RegisterFailure) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text(state.message)),
//           );
//         }
//         if (state is RegisterSuccess) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               content: Text('User created: ${state.user.displayName}'),
//             ),
//           );
//           context.go(RoutePaths.login);
//         }
//       },
//     );
//   }
//
//   @override
//   void dispose() {
//     _registerWorker?.dispose();
//     _firstNameController.dispose();
//     _lastNameController.dispose();
//     _ageController.dispose();
//     super.dispose();
//   }
//
//   void _submit() {
//     if (!_formKey.currentState!.validate()) return;
//     final age = int.tryParse(_ageController.text.trim());
//     if (age == null) return;
//
//     _registerController.register(
//       firstName: _firstNameController.text.trim(),
//       lastName: _lastNameController.text.trim(),
//       age: age,
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Obx(() {
//       final isLoading = _registerController.state is RegisterLoading;
//
//       return Scaffold(
//         appBar: AppBar(title: const Text('Register')),
//         body: SafeArea(
//           child: Padding(
//             padding: const EdgeInsets.all(24),
//             child: Form(
//               key: _formKey,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   TextFormField(
//                     controller: _firstNameController,
//                     decoration: const InputDecoration(
//                       labelText: 'First name',
//                       border: OutlineInputBorder(),
//                     ),
//                     validator: (v) =>
//                         v == null || v.isEmpty ? 'Required' : null,
//                     enabled: !isLoading,
//                   ),
//                   const SizedBox(height: 16),
//                   TextFormField(
//                     controller: _lastNameController,
//                     decoration: const InputDecoration(
//                       labelText: 'Last name',
//                       border: OutlineInputBorder(),
//                     ),
//                     validator: (v) =>
//                         v == null || v.isEmpty ? 'Required' : null,
//                     enabled: !isLoading,
//                   ),
//                   const SizedBox(height: 16),
//                   TextFormField(
//                     controller: _ageController,
//                     decoration: const InputDecoration(
//                       labelText: 'Age',
//                       border: OutlineInputBorder(),
//                     ),
//                     keyboardType: TextInputType.number,
//                     validator: (v) {
//                       if (v == null || v.isEmpty) return 'Required';
//                       if (int.tryParse(v) == null) return 'Invalid number';
//                       return null;
//                     },
//                     enabled: !isLoading,
//                   ),
//                   const SizedBox(height: 24),
//                   FilledButton(
//                     onPressed: isLoading ? null : _submit,
//                     child: isLoading
//                         ? const SizedBox(
//                             height: 20,
//                             width: 20,
//                             child: CircularProgressIndicator(strokeWidth: 2),
//                           )
//                         : const Text('Register'),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       );
//     });
//   }
// }
