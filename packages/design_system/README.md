# design_system

> Shared design tokens for Flutter apps — theme, colors, typography, spacing, shape, motion, and icons.

## Overview

Foundation layer for visual consistency across apps in this monorepo. Provides Material 3 themes, brightness-aware color tokens, a fluent typography API, and semantic spacing/radius/elevation values. Ships with **DM Sans** font assets.

No dependencies on other workspace packages.

## Features

- Material 3 light/dark themes via `AppTheme`
- Brightness-aware `AppColorTokens` registered as a `ThemeExtension`
- Fluent typography: `AppTypography.fs18.semibold.color(...)` or semantic `AppTypography.heading1()`
- 8px-based spacing scale and pre-composed `AppEdgeInsets`
- Semantic border radius and elevation presets
- Animation curves and durations for common UI transitions
- Curated `AppIcons` aliases grouped by domain

## Installation

Add to your app's `pubspec.yaml` (workspace):

```yaml
dependencies:
  design_system:
```

Then run `dart pub get` from the workspace root.

## Usage

```dart
import 'package:design_system/design_system.dart';
```

## Examples

### Theme setup

```dart
MaterialApp(
  theme: AppTheme.light,
  darkTheme: AppTheme.dark,
  themeMode: ThemeMode.system,
  home: MyHomePage(),
);
```

### Typography with theme-aware colors

```dart
Text(
  'Welcome',
  style: AppTypography.heading1().copyWith(
    color: context.colorTokens.onSurface,
  ),
);

Text(
  'Section title',
  style: AppTypography.heading3().copyWith(
    color: context.colorTokens.onSurface,
  ),
);

Text(
  'Error message',
  style: AppTypography.bodySmall().copyWith(
    color: context.colorTokens.error,
  ),
);

// Ad-hoc sizes — use fsXX when semantic roles do not fit
Text(
  'Custom size',
  style: AppTypography.fs24.semibold.color(context.colorTokens.onSurface),
);
```

### Declare semantic typography

Edit [`app_semantic_typography.dart`](lib/src/typography/app_semantic_typography.dart) using the fluent `AppTypography` chain:

```dart
abstract final class AppSemanticTypography {
  static TextStyle get heading1 => AppTypography.fs32.semibold.black();
  static TextStyle get heading2 => AppTypography.fs28.semibold.black();
  // ...
}
```

Use `.style` instead of a color terminal when you want theme color at call site:

```dart
static TextStyle get heading1 => AppTypography.fs32.semibold.style;
```

### Semantic typography customization

```dart
// Default from registry
Text('Welcome', style: AppTypography.heading1())

// Override color or metrics via TextStyle.copyWith
Text(
  'Welcome',
  style: AppTypography.heading1().copyWith(
    color: context.colorTokens.onSurface,
    fontSize: 28,
    fontWeight: FontWeight.bold,
  ),
);
```

### Spacing and motion

```dart
AnimatedContainer(
  duration: AppDurations.pageTransition,
  curve: AppCurves.pagePush,
  padding: AppEdgeInsets.screen,
  decoration: BoxDecoration(
    borderRadius: AppRadius.card,
    color: SemanticColors.primary(context),
  ),
  child: Text('Card', style: AppTypography.fs16.medium),
);
```

## API / Components

| Category | Key types |
|----------|-----------|
| **Theme** | `AppTheme`, `AppThemeContext`, `ThemeDataColorExtensions` |
| **Colors** | `AppColors`, `AppColorTokens`, `SemanticColors` |
| **Typography** | `AppTypography`, `AppSemanticTypography`, `AppTextStyleBuilder`, `AppFontScale`, `AppFontFamily` |
| **Spacing** | `AppSpacing`, `AppEdgeInsets` |
| **Shape** | `AppRadius`, `AppElevation` |
| **Motion** | `AppCurves`, `AppDurations` |
| **Icons** | `AppIcons` |

### Context extensions

- `context.colorTokens` — brightness-aware color tokens
- `context.colors` — semantic color shortcuts
- `context.isDarkMode` — current brightness
- `context.appTheme` — full theme extension

## Folder Structure

```
lib/
├── design_system.dart          # Public barrel
└── src/
    ├── animations/
    ├── colors/
    ├── icons/
    ├── shape/
    ├── spacing/
    ├── theme/
    └── typography/
```

## Notes / Limitations

- Prefer semantic typography (`AppTypography.heading1()`, `body()`, etc.) for standard UI text; use `AppTypography.fsXX.<weight>` for ad-hoc sizes
- Font assets are bundled in this package; no external font CDN required

## Related Packages

- [core_ui](../core_ui/README.md) — reusable widgets built on these tokens
- [Root README](../../README.md)

## License

License not specified. See root [README.md](../../README.md).
