// =============================================================================
// REFERENCE ONLY — Riverpod structure. Mirror of: lib/features/auth/register_page.dart
// =============================================================================
//
// import 'package:core_state/core_state.dart';
// import 'package:example_app/router/route_paths.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:go_router/go_router.dart';
//
// class RegisterPageRiverpod extends ConsumerStatefulWidget {
//   const RegisterPageRiverpod({super.key});
//
//   @override
//   ConsumerState<RegisterPageRiverpod> createState() =>
//       _RegisterPageRiverpodState();
// }
//
// class _RegisterPageRiverpodState extends ConsumerState<RegisterPageRiverpod> {
//   final _formKey = GlobalKey<FormState>();
//   final _firstNameController = TextEditingController();
//   final _lastNameController = TextEditingController();
//   final _ageController = TextEditingController();
//
//   @override
//   void dispose() {
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
//     ref.read(registerProvider.notifier).register(
//           firstName: _firstNameController.text.trim(),
//           lastName: _lastNameController.text.trim(),
//           age: age,
//         );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     ref.listen(registerProvider, (previous, next) {
//       if (next is RegisterFailure) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text(next.message)),
//         );
//       }
//       if (next is RegisterSuccess) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('User created: ${next.user.displayName}'),
//           ),
//         );
//         context.go(RoutePaths.login);
//       }
//     });
//
//     final isLoading = ref.watch(registerProvider) is RegisterLoading;
//
//     return Scaffold(
//       appBar: AppBar(title: const Text('Register')),
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(24),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 TextFormField(
//                   controller: _firstNameController,
//                   decoration: const InputDecoration(
//                     labelText: 'First name',
//                     border: OutlineInputBorder(),
//                   ),
//                   validator: (v) =>
//                       v == null || v.isEmpty ? 'Required' : null,
//                   enabled: !isLoading,
//                 ),
//                 const SizedBox(height: 16),
//                 TextFormField(
//                   controller: _lastNameController,
//                   decoration: const InputDecoration(
//                     labelText: 'Last name',
//                     border: OutlineInputBorder(),
//                   ),
//                   validator: (v) =>
//                       v == null || v.isEmpty ? 'Required' : null,
//                   enabled: !isLoading,
//                 ),
//                 const SizedBox(height: 16),
//                 TextFormField(
//                   controller: _ageController,
//                   decoration: const InputDecoration(
//                     labelText: 'Age',
//                     border: OutlineInputBorder(),
//                   ),
//                   keyboardType: TextInputType.number,
//                   validator: (v) {
//                     if (v == null || v.isEmpty) return 'Required';
//                     if (int.tryParse(v) == null) return 'Invalid number';
//                     return null;
//                   },
//                   enabled: !isLoading,
//                 ),
//                 const SizedBox(height: 24),
//                 FilledButton(
//                   onPressed: isLoading ? null : _submit,
//                   child: isLoading
//                       ? const SizedBox(
//                           height: 20,
//                           width: 20,
//                           child: CircularProgressIndicator(strokeWidth: 2),
//                         )
//                       : const Text('Register'),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
