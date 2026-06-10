/// Typed facade over [getIt] for BLoC and GetX dependency resolution.
///
/// Riverpod features use `Provider` instead and do not depend on this class.

library;

import 'package:core_state/src/di/injection.dart';
import 'package:get_it/get_it.dart';

/// Thin wrapper around [getIt] for BLoC and GetX.
///
/// Riverpod does not use this — dependencies are provided via `Provider`.
class ServiceLocator {
  const ServiceLocator._();

  /// Shared [GetIt] instance used by injectable codegen.
  static GetIt get instance => getIt;

  /// Registers [value] as a singleton, optionally under [instanceName].
  static void registerSingleton<T extends Object>(
    T value, {
    String? instanceName,
  }) =>
      getIt.registerSingleton<T>(value, instanceName: instanceName);

  /// Registers a lazy singleton factory evaluated on first [get].
  static void registerLazySingleton<T extends Object>(
    T Function() factoryFunc, {
    String? instanceName,
  }) =>
      getIt.registerLazySingleton<T>(factoryFunc, instanceName: instanceName);

  /// Registers a factory that produces a new instance on every [get].
  static void registerFactory<T extends Object>(
    T Function() factoryFunc, {
    String? instanceName,
  }) =>
      getIt.registerFactory<T>(factoryFunc, instanceName: instanceName);

  /// Resolves a registered dependency of type [T].
  ///
  /// Throws if [T] is not registered or [instanceName] does not match.
  static T get<T extends Object>({String? instanceName}) =>
      getIt.get<T>(instanceName: instanceName);

  /// Returns whether a registration exists for type [T].
  static bool isRegistered<T extends Object>({String? instanceName}) =>
      getIt.isRegistered<T>(instanceName: instanceName);

  /// Clears all registrations; optionally disposes singletons when [dispose] is true.
  static Future<void> reset({bool dispose = false}) => getIt.reset(dispose: dispose);
}
