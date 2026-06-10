// =============================================================================
// REFERENCE ONLY — Riverpod structure. Mirror of: lib/main.dart
// App aktif memakai BLoC. Uncomment & adapt jika switch ke Riverpod.
// Theme: MaterialApp(theme: AppTheme.light, darkTheme: AppTheme.dark,
//   themeMode: ref.watch(themeProvider))
// Panggil ref.read(themeProvider.notifier).load() saat startup.
// =============================================================================
//
// import 'package:core_state/core_state.dart';
// import 'package:example_app/alternatives/riverpod/app_bootstrap_riverpod.dart';
// import 'package:example_app/alternatives/riverpod/app_riverpod.dart';
// import 'package:flutter/material.dart';
//
// Future<void> main() async {
//   final localStorage = await bootstrapAppRiverpod();
//
//   runApp(
//     SetupRiverpod.scope(
//       overrides: [
//         localStorageProvider.overrideWithValue(localStorage),
//       ],
//       child: const ExampleAppRiverpod(),
//     ),
//   );
// }
