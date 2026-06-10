/// Riverpod startup helper and [ProviderScope] factory.
///
/// Does not use GetIt; dependencies are declared as Riverpod providers in
/// `core_state`.

library;

import 'package:core_state/src/setup/state_management_setup.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Initialises the Riverpod setup.
///
/// Riverpod DI uses manual `Provider` / `NotifierProvider` in `core_state`
/// (no `@riverpod` codegen). GetIt is not used.
///
/// Usage in `main.dart`:
/// ```dart
/// void main() async {
///   WidgetsFlutterBinding.ensureInitialized();
///   await dotenv.load(fileName: '.env');
///   await const SetupRiverpod().init();
///   runApp(SetupRiverpod.scope(child: const MyApp()));
/// }
/// // ref.watch(loginProvider);
/// // ref.read(loginProvider.notifier).login(username: u, password: p);
/// ```
class SetupRiverpod implements StateManagementSetup {
  /// Creates a const setup instance for use in `main`.
  const SetupRiverpod();

  @override
  Future<void> init({Future<void> Function()? registerDependencies}) async {
    await registerDependencies?.call();
  }

  /// Wraps [child] in [ProviderScope], required for Riverpod to work.
  ///
  /// Pass [overrides] for tests and [observers] for debugging provider lifecycle.
  static Widget scope({
    required Widget child,
    List<Override> overrides = const [],
    List<ProviderObserver>? observers,
  }) =>
      ProviderScope(
        overrides: overrides,
        observers: observers ?? const [],
        child: child,
      );
}
