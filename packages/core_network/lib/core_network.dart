/// Public API surface for the `core_network` package.
///
/// Re-exports HTTP clients, interceptors, connectivity helpers, API services,
/// configuration, and exception mapping utilities used across feature modules.
library;

// Client
export 'src/client/constant/dio_default_headers.dart';
export 'src/client/dio_client.dart';
export 'src/client/dio_client_config.dart';
export 'src/client/factory/dio_client_factory.dart';
export 'src/client/parser/dio_error_body_parser.dart';

// Config
export 'src/config/api_config.dart';
export 'src/config/endpoints.dart';

// Connection
export 'src/connection/connectivity_service.dart';
export 'src/connection/network_info.dart';

// Exceptions
export 'src/exception/exceptions.dart';

// Features — auth
export 'src/feature-services/auth/auth_service.dart';

// Features — user
export 'src/feature-services/user/user_service.dart';

// Interceptors
export 'src/interceptor/auth_interceptor.dart';
export 'src/interceptor/connectivity_interceptor.dart';
export 'src/interceptor/retry_interceptor.dart';

// Mapper
export 'src/mapper/exception_mapper.dart';

// Service base
export 'src/service/base_api_service.dart';
