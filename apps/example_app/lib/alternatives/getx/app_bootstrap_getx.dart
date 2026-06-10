// =============================================================================
// REFERENCE ONLY — GetX structure. Mirror of: lib/bootstrap/app_bootstrap.dart
// =============================================================================
//
// import 'package:core_network/core_network.dart';
// import 'package:core_state/core_state.dart';
// import 'package:core_storage/core_storage.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
//
// Future<void> bootstrapAppGetX() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await dotenv.load(fileName: '.env');
//
//   final localStorage = await HiveInitializer.initApp(
//     subDirectory: 'example_app',
//   );
//
//   final tokenStorage = TokenStorage();
//   final sessionInvalidationHub = SessionInvalidationHub();
//   const factory = DioClientFactory();
//
//   final mainClient = factory.create(
//     config: ApiConfig.defaultConfig(),
//     tokenStorage: tokenStorage,
//     onSessionInvalidated: sessionInvalidationHub.notify,
//   );
//
//   final listClient = factory.create(
//     config: ApiConfig.listConfig(),
//     tokenStorage: tokenStorage,
//     onSessionInvalidated: sessionInvalidationHub.notify,
//   );
//
//   await const SetupGetX().init(
//     registerDependencies: () async {
//       registerExternalDependencies(
//         dioClient: mainClient,
//         listDioClient: listClient,
//         tokenStorage: tokenStorage,
//         sessionInvalidationHub: sessionInvalidationHub,
//         localStorage: localStorage,
//       );
//       await configureDependencies();
//     },
//   );
// }
