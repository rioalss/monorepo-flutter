/// Public entry point for the `core_l10n` package.
///
/// Re-exports generated localizations, delegate configuration, locale
/// constants, and context localization helpers.
library;

export 'package:flutter_localizations/flutter_localizations.dart'
    show
        GlobalCupertinoLocalizations,
        GlobalMaterialLocalizations,
        GlobalWidgetsLocalizations;

export 'src/config/app_localizations_config.dart';
export 'src/config/device_locale_resolver.dart';
export 'src/constants/supported_locales.dart';
export 'src/extensions/context_l10n_extension.dart';
export 'src/generated/l10n/app_localizations.dart';
export 'src/helpers/validation_l10n.dart';
