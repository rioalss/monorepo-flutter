/// Public entry point for the `core_domain` package.
///
/// Re-exports contracts, models, parsers, converters, repositories, and
/// utilities shared across feature and data layers.
library;

// Contracts
export 'src/contracts/local_storage_contract.dart';
export 'src/contracts/network_info_contract.dart';
export 'src/contracts/secure_storage_contract.dart';

// Converters
export 'src/converters/safe_json_converters.dart';

// Features — auth
export 'src/features/auth/models/auth_session_model.dart';
export 'src/features/auth/repositories/auth_repository.dart';

// Features — user
export 'src/features/user/models/user_model.dart';
export 'src/features/user/repositories/user_repository.dart';

// Models — response
export 'src/models/response/api_error_model.dart';
export 'src/models/response/api_response_model.dart';
export 'src/models/response/paginated_response_model.dart';

// Models — result
export 'src/models/result/app_result.dart';

// Parsers
export 'src/parsers/safe_json_parsers.dart';

// Utils
export 'src/utils/safe_call.dart';
