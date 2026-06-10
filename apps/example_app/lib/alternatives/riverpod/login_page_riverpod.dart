// =============================================================================
// REFERENCE ONLY — Riverpod structure. Mirror of: lib/features/auth/login_page.dart
// =============================================================================
//
// import 'package:core_state/core_state.dart';
// import 'package:example_app/router/route_paths.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:go_router/go_router.dart';
//
// class LoginPageRiverpod extends ConsumerStatefulWidget {
//   const LoginPageRiverpod({super.key});
//
//   @override
//   ConsumerState<LoginPageRiverpod> createState() => _LoginPageRiverpodState();
// }
//
// class _LoginPageRiverpodState extends ConsumerState<LoginPageRiverpod> {
//   final _formKey = GlobalKey<FormState>();
//   final _usernameController = TextEditingController(
//     text: kDebugMode ? 'emilys' : '',
//   );
//   final _passwordController = TextEditingController(
//     text: kDebugMode ? 'emilyspass' : '',
//   );
//
//   @override
//   void dispose() {
//     _usernameController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }
//
//   void _submit() {
//     if (!_formKey.currentState!.validate()) return;
//     ref.read(loginProvider.notifier).login(
//           username: _usernameController.text.trim(),
//           password: _passwordController.text,
//         );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     ref.listen(loginProvider, (previous, next) async {
//       if (next is LoginFailure) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text(next.message)),
//         );
//       }
//       if (next is LoginSuccess) {
//         await ref.read(sessionProvider.notifier).onLoginSuccess();
//       }
//     });
//
//     final state = ref.watch(loginProvider);
//     final isLoading = state is LoginLoading;
//
//     return Scaffold(
//       appBar: AppBar(title: const Text('Login')),
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(24),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 TextFormField(
//                   controller: _usernameController,
//                   decoration: const InputDecoration(
//                     labelText: 'Username',
//                     border: OutlineInputBorder(),
//                   ),
//                   validator: (v) =>
//                       v == null || v.isEmpty ? 'Required' : null,
//                   enabled: !isLoading,
//                 ),
//                 const SizedBox(height: 16),
//                 TextFormField(
//                   controller: _passwordController,
//                   decoration: const InputDecoration(
//                     labelText: 'Password',
//                     border: OutlineInputBorder(),
//                   ),
//                   obscureText: true,
//                   validator: (v) =>
//                       v == null || v.isEmpty ? 'Required' : null,
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
//                       : const Text('Login'),
//                 ),
//                 const SizedBox(height: 16),
//                 TextButton(
//                   onPressed: isLoading
//                       ? null
//                       : () => context.push(RoutePaths.register),
//                   child: const Text('Create account'),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
