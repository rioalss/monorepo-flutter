// =============================================================================
// REFERENCE ONLY — Riverpod structure. Mirror of: lib/features/splash/splash_page.dart
// =============================================================================
//
// import 'package:core_state/core_state.dart';
// import 'package:example_app/features/splash/splash_view.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// class SplashPageRiverpod extends ConsumerStatefulWidget {
//   const SplashPageRiverpod({super.key});
//
//   @override
//   ConsumerState<SplashPageRiverpod> createState() => _SplashPageRiverpodState();
// }
//
// class _SplashPageRiverpodState extends ConsumerState<SplashPageRiverpod> {
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       ref.read(sessionProvider.notifier).checkSession();
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return const SplashView();
//   }
// }
