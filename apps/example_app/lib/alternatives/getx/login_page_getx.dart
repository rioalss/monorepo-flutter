// =============================================================================
// REFERENCE ONLY — GetX structure. Mirror of: lib/features/auth/login_page.dart
// =============================================================================
//
// import 'package:core_state/core_state.dart';
// import 'package:example_app/router/route_paths.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:go_router/go_router.dart';
//
// class LoginPageGetX extends StatefulWidget {
//   const LoginPageGetX({super.key});
//
//   @override
//   State<LoginPageGetX> createState() => _LoginPageGetXState();
// }
//
// class _LoginPageGetXState extends State<LoginPageGetX> {
//   final _formKey = GlobalKey<FormState>();
//   final _usernameController = TextEditingController(
//     text: kDebugMode ? 'emilys' : '',
//   );
//   final _passwordController = TextEditingController(
//     text: kDebugMode ? 'emilyspass' : '',
//   );
//   late final LoginController _loginController;
//   Worker? _loginWorker;
//
//   @override
//   void initState() {
//     super.initState();
//     _loginController = Get.find<LoginController>();
//     _loginWorker = ever<LoginState>(
//       _loginController.rxState,
//       (state) async {
//         if (state is LoginFailure) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text(state.message)),
//           );
//         }
//         if (state is LoginSuccess) {
//           await Get.find<SessionController>().onLoginSuccess();
//         }
//       },
//     );
//   }
//
//   @override
//   void dispose() {
//     _loginWorker?.dispose();
//     _usernameController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }
//
//   void _submit() {
//     if (!_formKey.currentState!.validate()) return;
//     _loginController.login(
//       username: _usernameController.text.trim(),
//       password: _passwordController.text,
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Obx(() {
//       final state = _loginController.state;
//       final isLoading = state is LoginLoading;
//
//       return Scaffold(
//         appBar: AppBar(title: const Text('Login')),
//         body: SafeArea(
//           child: Padding(
//             padding: const EdgeInsets.all(24),
//             child: Form(
//               key: _formKey,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   TextFormField(
//                     controller: _usernameController,
//                     decoration: const InputDecoration(
//                       labelText: 'Username',
//                       border: OutlineInputBorder(),
//                     ),
//                     validator: (v) =>
//                         v == null || v.isEmpty ? 'Required' : null,
//                     enabled: !isLoading,
//                   ),
//                   const SizedBox(height: 16),
//                   TextFormField(
//                     controller: _passwordController,
//                     decoration: const InputDecoration(
//                       labelText: 'Password',
//                       border: OutlineInputBorder(),
//                     ),
//                     obscureText: true,
//                     validator: (v) =>
//                         v == null || v.isEmpty ? 'Required' : null,
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
//                         : const Text('Login'),
//                   ),
//                   const SizedBox(height: 16),
//                   TextButton(
//                     onPressed: isLoading
//                         ? null
//                         : () => context.push(RoutePaths.register),
//                     child: const Text('Create account'),
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
//
// // LoginController perlu expose Rx untuk ever/Obx:
// // Rx<LoginState> get rxState => _state;
