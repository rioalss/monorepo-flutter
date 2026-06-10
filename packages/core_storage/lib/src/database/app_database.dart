/// Drift SQLite database definition and connection setup.
///
/// Defines [AppDatabase] with its schema, migrations, and a lazy file-backed
/// connection under the application documents directory. Extend tables in
/// `tables/` and regenerate code after schema changes.
library;

import 'dart:io';

import 'package:core_storage/src/database/tables/example_table.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

part 'app_database.g.dart';

/// Application SQLite database managed by Drift.
///
/// Add tables and DAOs here, then run `melos run build:runner` to regenerate
/// `app_database.g.dart`.
///
/// To open the database:
/// ```dart
/// final db = AppDatabase.connect();
/// ```
@DriftDatabase(tables: [ExampleItems])
class AppDatabase extends _$AppDatabase {
  /// Creates a database instance backed by the given [QueryExecutor].
  AppDatabase(super.e);

  /// Opens the default on-device SQLite database at `app.sqlite`.
  factory AppDatabase.connect() => AppDatabase(_openConnection());

  /// Current schema version; increment when adding migrations in [migration].
  @override
  int get schemaVersion => 1;

  /// Schema creation and upgrade strategy.
  ///
  /// `onCreate` builds all tables on first launch. Add version-gated steps to
  /// `onUpgrade` as [schemaVersion] increases.
  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) => m.createAll(),
        // ignore: no-op-empty-async-method
        onUpgrade: (m, from, to) async {
          // Add step-by-step migration logic here as schemaVersion increases.
          // Example:
          // if (from < 2) await m.addColumn(exampleItems, exampleItems.someNewColumn);
        },
      );
}

/// Lazily opens a native SQLite connection at `app.sqlite` in the documents
/// directory.
QueryExecutor _openConnection() => LazyDatabase(() async {
      final dbFolder = await getApplicationDocumentsDirectory();
      final file = File(path.join(dbFolder.path, 'app.sqlite'));
      return NativeDatabase(file);
    });
