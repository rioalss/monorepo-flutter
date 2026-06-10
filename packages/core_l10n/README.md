# core_l10n

> Shared localization — generated `AppLocalizations`, delegate configuration, locale constants, and validation message helpers.

## Overview

Centralized internationalization package for apps in this monorepo. Uses Flutter `gen-l10n` with ARB source files. Ships English (`en`) and Indonesian (`id`) out of the box.

This package owns **strings and delegate wiring only** — no locale persistence or state. Locale switching state belongs in `core_state` (future), following the same pattern as `ThemeCubit`.

## Features

- **Generated `AppLocalizations`** — type-safe accessors from ARB files
- **`AppLocalizationsConfig`** — ready-to-use delegates and locale resolution for `MaterialApp`
- **`SupportedLocales`** — locale constants, enum mapping, and display names
- **`context.l10n`** — ergonomic `BuildContext` extension
- **`ValidationL10n`** — facade mirroring `ValidationMessages` in `core_utils` for form validators
- **CI-friendly** — `untranslated_messages.json` tracks missing translations

## Installation

```yaml
dependencies:
  core_l10n:
```

## Usage

```dart
import 'package:core_l10n/core_l10n.dart';
```

### Wire into `MaterialApp`

```dart
MaterialApp(
  localizationsDelegates: AppLocalizationsConfig.localizationsDelegates,
  supportedLocales: AppLocalizationsConfig.supportedLocales,
  localeResolutionCallback: AppLocalizationsConfig.localeResolutionCallback,
  // locale: ... from LocaleCubit later
  home: const HomeScreen(),
);
```

### Read strings in widgets

```dart
Text(context.l10n.commonSave);

ElevatedButton(
  onPressed: onRetry,
  child: Text(context.l10n.commonTryAgain),
);
```

### Validation messages

```dart
TextFormField(
  validator: (value) {
    if (value == null || value.isEmpty) {
      return ValidationL10n.required(context.l10n);
    }
    if (value.length < 5) {
      return ValidationL10n.minLength(context.l10n, 5);
    }
    return null;
  },
);
```

## API / Components

### Config

| Type | Description |
|------|-------------|
| `AppLocalizationsConfig` | `supportedLocales`, `localizationsDelegates`, `localeResolutionCallback` |
| `AppLocalizations` | Generated localization class (from ARB) |

### Constants

| Type | Description |
|------|-------------|
| `AppLocale` | Enum: `en`, `id` |
| `SupportedLocales` | `all`, `fallback`, `fromLocale()`, `toLocale()`, `displayName()` |

### Extensions & helpers

| Type | Description |
|------|-------------|
| `ContextL10nExtension` | `context.l10n` shortcut |
| `ValidationL10n` | Static methods for all validation error messages |

## Key naming convention

| Prefix | Example | Use for |
|--------|---------|---------|
| `common_` | `commonOk`, `commonCancel` | Shared UI labels |
| `validation_` | `validationEmail`, `validationMinLength` | Form validation errors |
| `{feature}_` | `auth_loginTitle` | Feature-specific strings (add in apps) |

Always add a `@key` description block in `app_en.arb` for translator context.

## Folder structure

```
packages/core_l10n/
├── l10n.yaml
├── untranslated_messages.json
├── lib/
│   ├── core_l10n.dart
│   ├── l10n/
│   │   ├── app_en.arb          # template locale
│   │   └── app_id.arb
│   └── src/
│       ├── config/
│       ├── constants/
│       ├── extensions/
│       ├── helpers/
│       └── generated/l10n/     # committed gen-l10n output
└── test/
```

## Adding a new locale

1. Create `lib/l10n/app_<locale>.arb` with all keys from `app_en.arb`
2. Run codegen:

   ```bash
   cd packages/core_l10n && flutter gen-l10n
   # or from monorepo root:
   melos run gen:l10n
   ```

3. Update `AppLocale` and `SupportedLocales` in `lib/src/constants/supported_locales.dart`
4. Verify `untranslated_messages.json` is empty (`{}`)

## Adding a new string

1. Add the key and `@key` description to `app_en.arb`
2. Add the translation to every other `.arb` file
3. Run `flutter gen-l10n`
4. Use via `context.l10n.yourNewKey`

## Codegen

Generated files live in `lib/src/generated/l10n/` and are committed so consumers can build without running codegen first.

After editing ARB files:

```bash
flutter gen-l10n   # inside packages/core_l10n
```

Check for missing translations:

```bash
cat untranslated_messages.json   # should be {}
```

## Notes / Limitations

- Locale **persistence** and **runtime switching** are not in this package — wire via `core_state` when needed
- `core_utils` `ValidationMessages` still uses hardcoded English; migrate validators to `ValidationL10n` when `BuildContext` is available
- `core_ui` date picker labels use `MaterialLocalizations` from Flutter — not app strings from this package
- Re-run `flutter gen-l10n` after any ARB change before committing

## Related packages

- `core_utils` — `ValidationMessages` (English defaults, migration target)
- `core_state` — future `LocaleCubit` / `LocaleRepository` for persisted locale
- [Root README](../../README.md)

## License

License not specified. See root [README.md](../../README.md).
