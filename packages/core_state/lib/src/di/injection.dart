/// Injectable / GetIt bootstrap for the BLoC and GetX dependency graph.
///
/// Call [configureDependencies] after registering external singletons via
/// [registerExternalDependencies].

library;

import 'package:core_state/src/di/injection.config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

/// Global [GetIt] instance used by injectable codegen and [ServiceLocator].
final GetIt getIt = GetIt.instance;

/// Initializes all `@injectable` registrations in [injection.config.dart].
///
/// Must be called after app-provided dependencies (Dio, storage, etc.) are
/// registered on [getIt].
@InjectableInit()
Future<void> configureDependencies() async => getIt.init();
