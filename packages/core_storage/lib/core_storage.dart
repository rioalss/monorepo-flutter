/// Public API surface for the `core_storage` package.
///
/// Re-exports secure key-value storage, Hive-backed local storage,
/// Drift SQLite database types, and authentication token persistence.
library;

// Auth
export 'src/auth/token_storage.dart';

// Database
export 'src/database/app_database.dart';
export 'src/database/tables/example_table.dart';

// Local
export 'src/local/hive_initializer.dart';
export 'src/local/hive_local_storage.dart';

// Secure
export 'src/secure/secure_storage.dart';
