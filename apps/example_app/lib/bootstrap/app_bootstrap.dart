import 'package:core_network/core_network.dart';

import 'package:core_state/core_state.dart';

import 'package:core_storage/core_storage.dart';

import 'package:flutter/widgets.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppBootstrapResult {
  const AppBootstrapResult({
    required this.tokenStorage,
    required this.sessionInvalidationHub,
  });

  final TokenStorage tokenStorage;

  final SessionInvalidationHub sessionInvalidationHub;
}

Future<AppBootstrapResult> bootstrapApp() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: '.env');

  final localStorage = await HiveInitializer.initApp(
    subDirectory: 'example_app',
  );

  final tokenStorage = TokenStorage();

  final sessionInvalidationHub = SessionInvalidationHub();

  const factory = DioClientFactory();

  final mainClient = factory.create(
    config: ApiConfig.defaultConfig(),
    tokenStorage: tokenStorage,
    onSessionInvalidated: sessionInvalidationHub.notify,
  );

  final listClient = factory.create(
    config: ApiConfig.listConfig(),
    tokenStorage: tokenStorage,
    onSessionInvalidated: sessionInvalidationHub.notify,
  );

  await const SetupBloc().init(
    registerDependencies: () async {
      registerExternalDependencies(
        dioClient: mainClient,
        listDioClient: listClient,
        tokenStorage: tokenStorage,
        sessionInvalidationHub: sessionInvalidationHub,
        localStorage: localStorage,
      );

      await configureDependencies();
    },
  );

  return AppBootstrapResult(
    tokenStorage: tokenStorage,
    sessionInvalidationHub: sessionInvalidationHub,
  );
}
