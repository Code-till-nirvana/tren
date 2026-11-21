# TREN

**TRAIN. EVOLVE. BECOME.**

TREN is a fitness and workout companion focused on helping you plan training, log workouts, understand progress, and build consistent habits.

This repository contains the TREN application source code. The project is being actively customized: some inherited modules and platform integrations may still be under review, so feature availability can vary by platform and build.

## Project

- **App name:** TREN
- **Tagline:** TRAIN. EVOLVE. BECOME.
- **Supported platform:** Android only
- **Framework:** Flutter
- **Language:** Dart
- **Repository:** [Code-till-nirvana/tren](https://github.com/Code-till-nirvana/tren)

## Product direction

TREN is being shaped around a focused, premium training experience:

- Workout logging and training history
- Exercise discovery and workout planning
- Strength and activity progress tracking
- Personal fitness metrics and training insights
- A consistent dark interface using charcoal and burgundy
- A simple, distraction-conscious experience

TREN is maintained as an Android-only Flutter application. Other platform project folders and build workflows are intentionally excluded.

## Design system

The current visual direction uses a charcoal foundation with restrained burgundy accents.

| Role | Color |
|---|---|
| Main background | `#202124` |
| Primary surface | `#29292D` |
| Raised surface | `#37363B` |
| Primary burgundy | `#873F50` |
| Secondary burgundy | `#B87988` |
| Main text | `#F1F0EF` |
| Secondary text | `#B6B2B4` |
| Borders | `#414047` |

## Getting started

### Requirements

- Flutter SDK compatible with the project's `pubspec.yaml`
- Android Studio or Visual Studio Code
- Android SDK and an emulator or Android device

### Run locally

```bash
git clone https://github.com/Code-till-nirvana/tren.git
cd tren
flutter pub get
flutter run
```

### Build an Android APK

```bash
flutter build apk --release
```

The generated APK is normally written to:

```text
build/app/outputs/flutter-apk/app-release.apk
```

## Development notes

- Keep changes focused and test affected flows after modifying them.
- Avoid removing existing functionality unless it is intentionally being replaced.
- Keep Android configuration in sync when changing the application identifier, app label, icons, or permissions.
- Do not commit signing keys, API secrets, local environment files, or generated build artifacts.

## Credits and licensing

TREN is an independently branded customization of an existing open-source codebase.

The project includes inherited open-source components and third-party assets. All applicable licence notices and attribution requirements are retained in the files linked below.

The inherited source is distributed under the GNU General Public License v3.0 together with the applicable additional terms. See [LICENSE](LICENSE) and [ADDITIONAL_TERMS.md](ADDITIONAL_TERMS.md) before redistributing modified builds or source.

Third-party artwork, fonts, and other assets retain their respective licences and attribution requirements. See [CREDITS.md](CREDITS.md).

## Contributing

Issues and improvement suggestions are welcome. Before submitting a substantial change, describe the intended behavior and the parts of the app it affects.

## Status

TREN is under active customization. Documentation, branding, platform identifiers, and visual assets are being updated incrementally. Android builds should be tested after each substantial change.
