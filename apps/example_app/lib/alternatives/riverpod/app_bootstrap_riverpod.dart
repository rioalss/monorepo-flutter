// =============================================================================
// REFERENCE ONLY — Riverpod structure. Mirror of: lib/bootstrap/app_bootstrap.dart
// Riverpod tidak pakai GetIt — Dio/token dari providers di core_state.
// =============================================================================
//
// import 'package:core_state/core_state.dart';
// import 'package:core_storage/core_storage.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
//
// Future<ILocalStorage> bootstrapAppRiverpod() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await dotenv.load(fileName: '.env');
//
//   final localStorage = await HiveInitializer.initApp(
//     subDirectory: 'example_app',
//   );
//
//   await const SetupRiverpod().init();
//
//   return localStorage;
//
//   // Session check dilakukan di ExampleAppRiverpod via:
//   // ref.read(sessionProvider.notifier).checkSession()
//   //
//   // sessionInvalidationHub sudah di-wire di
//   // core_state/infrastructure_providers.dart → dioClientProvider
// }
