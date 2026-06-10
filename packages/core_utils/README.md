# core_utils

> Shared utilities — extensions, validators, debounce/throttle, pickers, location, URL launcher, logging, and platform helpers.

## Overview

Cross-cutting helpers used across app and feature layers. No dependencies on other workspace packages. Provides form validation, UI extensions, file/image picking with compression, device location, external URL launching, and performance utilities.

## Features

- **Extensions** — `String`, `BuildContext`, `Widget`, `Color`, `List`, `Number`, `Duration`
- **Validation** — Composable `InputValidator` for `TextFormField`
- **Rate limiting** — `Debouncer`, `Throttler` (sync and async variants)
- **Pickers** — `FilePickerService`, `ImagePickerService` returning `PickedFileModel`
- **Location** — `LocationService` with `AppLocationModel` (geolocator facade)
- **URL launcher** — `UrlLauncherService` for web, phone, email, and maps
- **Logging** — `AppLogger` gated wrapper around `logger`
- **Platform** — `PlatformUtils` for iOS/Android/web detection
- **Haptics** — Semantic feedback (`tap`, `success`, `error`, etc.)

## Installation

```yaml
dependencies:
  core_utils:
```

## Usage

```dart
import 'package:core_utils/core_utils.dart';
```

## Examples

### Form validation

```dart
TextFormField(
  validator: InputValidator.combine([
    InputValidator.required(),
    InputValidator.email(),
    InputValidator.minLength(5),
  ]),
);
```

### Current location and open in maps

```dart
final location = await LocationService.getCurrentPosition();
if (location == null) return;

final distanceKm = LocationService.distanceBetweenKm(
  startLatitude: location.latitude,
  startLongitude: location.longitude,
  endLatitude: -6.2,
  endLongitude: 106.8,
);

await UrlLauncherService.launchMaps(
  latitude: location.latitude,
  longitude: location.longitude,
  label: 'My location',
);
```

### Launch phone, email, and external URL

```dart
await UrlLauncherService.launchPhone('+6281234567890');

await UrlLauncherService.launchEmail(
  email: 'support@example.com',
  subject: 'Help',
  body: 'I need assistance with...',
);

await UrlLauncherService.launchExternal('https://example.com');
```

### Search debounce

```dart
final debouncer = Debouncer(duration: AppDurations.debounce);

void onQueryChanged(String query) {
  debouncer.run(() => performSearch(query));
}
```

### Image pick with context helpers

```dart
final file = await ImagePickerService.pickFromGallery(minSizeMb: 2);

if (file != null && context.mounted) {
  context.showSuccess('Selected ${file.name}');
  Haptics.success();
}
```

## API / Components

### Extensions

| Extension | Highlights |
|-----------|------------|
| `ContextExtensions` | Theme, screen size, keyboard, `go_router` navigation, snackbars |
| `WidgetExtensions` | Padding, tap, visibility, sliver helpers |
| `StringExtensions` | String utilities |
| `ColorExtensions` | Color manipulation |
| `ListExtensions` | List utilities |
| `NumberExtensions` | Number formatting |
| `DurationExtensions` | Duration helpers |

### Helpers

| Type | Description |
|------|-------------|
| `InputValidator` | Email, password, phone, OTP, coordinates, required, min/max length, etc. |
| `ValidationMessages` | Default validation error messages |
| `PhoneNumberFormatter` / `FirstZeroFormatter` | Input formatters |
| `Debouncer` / `AsyncDebouncer` | Delay execution until input stops |
| `Throttler` / `AsyncThrottler` | Limit execution frequency |
| `AppLogger` | Configurable logging |
| `PlatformUtils` | `isIOS`, `isAndroid`, `isWeb`, `platformValue<T>()` |
| `Haptics` | Haptic feedback helpers |

### Services

| Type | Description |
|------|-------------|
| `FilePickerService` | Pick documents/files |
| `ImagePickerService` | Pick from gallery/camera; auto-compresses images |
| `PickedFileModel` | Normalized file result (path, name, size, mime) |
| `LocationService` | Permission, GPS read, distance helpers |
| `AppLocationModel` | Normalized lat/lng and optional accuracy metadata |
| `UrlLauncherService` | Open URLs, phone, email, Google Maps |
| `LocationPermission` / `LocationAccuracy` | Re-exported from `geolocator` |
| `LaunchMode` | Re-exported from `url_launcher` |

### Constants

| Type | Description |
|------|-------------|
| `AppConstant` | Phone country codes, US states |
| `AppSizes` | Common size constants |
| `AppDurations` | Debounce, animation, and timing defaults |

## Folder Structure

```
lib/
├── core_utils.dart
└── src/
    ├── constants/
    ├── extensions/
    ├── haptics/
    ├── helpers/
    └── service/
        ├── file_picker/
        ├── image_picker/
        ├── location/
        ├── url_launcher/
        └── models/
```

## Notes / Limitations

- `ImageCompressHelper` is **internal** — used by `ImagePickerService`, not exported
- `go_router` is a dependency for navigation extensions in `ContextExtensions`
- Pickers require platform permissions (camera, storage) configured in your app
- **Location** — apps must declare permissions in the app layer:
  - **Android:** `ACCESS_FINE_LOCATION` / `ACCESS_COARSE_LOCATION` in `AndroidManifest.xml`
  - **iOS:** `NSLocationWhenInUseUsageDescription` in `Info.plist`
- **URL launcher** — on Android 11+, add `<queries>` for `https`, `tel`, and `mailto` if launching external apps
- `getPositionStream()` is not exposed to avoid stream lifecycle concerns *(optional: add later if needed)*

## Related Packages

- [Root README](../../README.md)

## License

License not specified. See root [README.md](../../README.md).
