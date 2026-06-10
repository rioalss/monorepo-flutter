# core_ui

> Themed dialogs, bottom sheets, date pickers, shimmer skeletons, and banner carousels built on the shared design system.

## Overview

Reusable UI components that apply `design_system` tokens for consistent look and feel. Includes modal shells, confirmation bottom sheets, a Syncfusion-backed date picker, skeleton loaders, and carousel banners with page indicators.

## Features

- **Bottom sheets** — `BottomSheetParent`, `ConfirmationBottomSheet` with static `show()` helpers
- **Dialogs** — `DialogParent`, `DatePickerDialog` (single and range modes)
- **Date picker** — Themed `AppDatePicker` with weekday header and bounds helpers
- **Shimmer** — `AppShimmer`, `AppShimmerBox` for skeleton loading states
- **Carousel** — `AppCarousel` with auto-play and `AnimatedSmoothIndicator` dots
- All components use design tokens (`AppSpacing`, `AppTypography`, `AppRadius`, `context.colorTokens`)

## Installation

```yaml
dependencies:
  core_ui:
  design_system:   # transitive, but often imported directly in app code
```

## Usage

```dart
import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart' hide DatePickerDialog;
```

> Hide `DatePickerDialog` from Material if you use the one from `core_ui`.

## Examples

### Skeleton list placeholder

```dart
Column(
  children: List.generate(
    3,
    (_) => Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: AppShimmerBox(
        width: double.infinity,
        height: 16,
      ),
    ),
  ),
);
```

### Banner carousel

```dart
AppCarousel(
  height: 180,
  items: [
    Image.asset('assets/banner1.png', fit: BoxFit.cover),
    Image.asset('assets/banner2.png', fit: BoxFit.cover),
  ],
  onPageChanged: (index) => debugPrint('page $index'),
);
```

### Custom shimmer wrapper

```dart
AppShimmer(
  enabled: isLoading,
  child: Card(
    child: ListTile(
      leading: CircleAvatar(backgroundColor: context.colorTokens.surfaceVariant),
      title: Container(height: 12, color: context.colorTokens.surfaceVariant),
    ),
  ),
);
```

### Single date picker

```dart
final date = await DatePickerDialog.showSingle(
  context,
  title: 'Select date',
  confirmLabel: 'OK',
  cancelLabel: 'Cancel',
  initialDate: DateTime.now(),
);

if (date != null) {
  // use selected date
}
```

### Confirmation bottom sheet

```dart
final confirmed = await ConfirmationBottomSheet.show(
  context,
  title: 'Delete item?',
  message: 'This action cannot be undone.',
  confirmLabel: 'Delete',
  cancelLabel: 'Cancel',
  isDestructive: true,
);

if (confirmed == true) {
  // proceed with deletion
}
```

## API / Components

### Shimmer

| Widget | Description |
|--------|-------------|
| `AppShimmer` | Themed shimmer overlay; uses `AppDurations.shimmer` |
| `AppShimmerBox` | Rectangular skeleton placeholder with default skeleton radius |

### Carousel

| Widget | Description |
|--------|-------------|
| `AppCarousel` | Banner carousel with optional dot indicator |
| `CarouselSliderController` | Re-exported for programmatic page navigation |

### Bottom sheets

| Widget | Description |
|--------|-------------|
| `BottomSheetParent` | Themed shell; use `BottomSheetParent.show<T>()` |
| `BottomSheetHeader` | Title, subtitle, close button |
| `BottomSheetFooter` | Primary/secondary action row |
| `ConfirmationBottomSheet` | Ready-made confirm/cancel sheet |

### Dialogs

| Widget | Description |
|--------|-------------|
| `DialogParent` | Themed dialog shell; use `DialogParent.show<T>()` |
| `DialogHeader` | Title, subtitle, close button |
| `DialogFooter` | Primary/secondary action row |
| `DatePickerDialog` | Full modal; `showSingle()` / `showRange()` |
| `AppDatePicker` | Syncfusion calendar wrapper |
| `DatePickerWeekdayHeader` | Custom weekday row |

### Helpers

| Function | Description |
|----------|-------------|
| `resolveDatePickerBounds` | Compute min/max dates for picker modes |
| `clampDate` / `clampDateRange` | Clamp selection to valid bounds |

## Folder Structure

```
lib/
├── core_ui.dart
└── src/
    └── components/
        ├── bottom_sheets/
        ├── carousel/
        ├── dialog/
        ├── images/              # AppNetworkImage (internal)
        └── shimmer/
```

## Notes / Limitations

- Depends on **Syncfusion Flutter DatePicker** for calendar UI
- **Carousel** auto-play pauses on touch; indicator hidden when there is only one slide
- **Shimmer** with `enabled: false` renders a static placeholder without animation
- `AppNetworkImage` (cached network image wrapper) exists but is **not exported** from the public barrel *(optional: export if needed)*

## Related Packages

- [design_system](../design_system/README.md) — visual tokens
- [Root README](../../README.md)

## License

License not specified. See root [README.md](../../README.md).
