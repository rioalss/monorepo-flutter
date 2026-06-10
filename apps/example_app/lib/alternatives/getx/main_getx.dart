// =============================================================================
// REFERENCE ONLY — GetX structure. Mirror of: lib/main.dart
// App aktif memakai BLoC. Uncomment & adapt jika switch ke GetX.
// Theme: getIt<ThemeController>()..load(); Get.put(..., permanent: true);
// GetMaterialApp(theme: AppTheme.light, darkTheme: AppTheme.dark,
//   themeMode: themeController.themeMode.value) wrapped in Obx.
// =============================================================================
//
// import 'package:core_state/core_state.dart';
// import 'package:example_app/alternatives/getx/app_getx.dart';
// import 'package:example_app/alternatives/getx/app_bootstrap_getx.dart';
// import 'package:example_app/alternatives/getx/app_router_getx.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// Future<void> main() async {
//   await bootstrapAppGetX();
//
//   final sessionController = getIt<SessionController>();
//   Get.put(sessionController, permanent: true);
//
//   final router = createAppRouterGetX(sessionController: sessionController);
//
//   runApp(ExampleAppGetX(router: router));
// }
