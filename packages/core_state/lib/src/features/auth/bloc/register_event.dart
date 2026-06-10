/// BLoC events for the registration feature.
///
/// Defines user actions dispatched to [RegisterBloc].

library;

import 'package:flutter/foundation.dart';

/// Root type for all registration-related BLoC events.
sealed class RegisterEvent {
  /// Creates a registration event.
  const RegisterEvent();
}

/// User submitted profile data to create an account.
@immutable
final class RegisterSubmitted extends RegisterEvent {
  /// Creates an event with the registration form fields.
  const RegisterSubmitted({
    required this.firstName,
    required this.lastName,
    required this.age,
  });

  /// Given name for the new account.
  final String firstName;

  /// Family name for the new account.
  final String lastName;

  /// Age in years supplied by the registration form.
  final int age;
}
