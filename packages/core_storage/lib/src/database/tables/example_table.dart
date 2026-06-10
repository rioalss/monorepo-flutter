/// Drift table definitions for the application database schema.
///
/// Each table class extends [Table] and is registered on `AppDatabase`.
/// Run `melos run build:runner` after any schema change to regenerate
/// `app_database.g.dart`.
library;

import 'package:drift/drift.dart';

/// Starter table demonstrating the Drift schema pattern.
///
/// Replace or extend with domain-specific tables; register new tables on
/// `AppDatabase` and bump its schema version when migrating.
class ExampleItems extends Table {
  /// Surrogate primary key.
  IntColumn get id => integer().autoIncrement()();

  /// Display name of the item.
  TextColumn get name => text()();

  /// UTC timestamp when the row was created.
  DateTimeColumn get createdAt => dateTime()();
}
