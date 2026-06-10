/// Ergonomic [BuildContext] access to [AppLocalizations].
library;

import 'package:core_l10n/src/generated/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

/// Shortcuts for reading localized strings from [BuildContext].
extension ContextL10nExtension on BuildContext {
  /// Current [AppLocalizations] for this subtree.
  AppLocalizations get l10n => AppLocalizations.of(this);
}
