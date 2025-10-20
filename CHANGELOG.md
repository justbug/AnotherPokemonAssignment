# Changelog

All notable changes to this project will be documented in this file.

## [Unreleased] - 2025-10-20

### Added
- **Cursor Rules System**: Comprehensive development guidelines and best practices
  - Project structure and architecture guidelines
  - Flutter BLoC pattern implementation rules
  - iOS MVVM pattern and Swift coding standards
  - Testing guidelines for both platforms
  - Networking and API integration patterns
  - Error handling and user experience guidelines
  - Flutter dependencies and package management

- SQLite-backed local persistence for favorites in Flutter:
  - `flutter_another_pokemon_assignment/lib/services/local_pokemon_database.dart`
  - `flutter_another_pokemon_assignment/lib/services/local_pokemon_telemetry.dart`
- Telemetry for persistence operations via `LocalPokemonTelemetry`
- Specs and plans for the feature under `specs/001-sqflite-local-storage/` (plan, spec, tasks, contracts, data-model, quickstart, research, checklist)

### Documentation
- Updated main README.md with Cursor Rules integration
- Updated Flutter README.md with development guidelines
- Added comprehensive Cursor Rules documentation in `.cursor/README.md`
- Enhanced project documentation with automated development assistance
 - Updated favorites documentation to reflect SQLite storage and diagnostics

### Development Experience
- Automated code generation guidance for Flutter BLoC pattern
- iOS MVVM architecture enforcement
- Testing strategy recommendations
- Error handling pattern implementation
- Dependency management best practices

### Changed
- Migrated Flutter favorites persistence to SQLite (fresh store, no legacy SharedPreferences migration) with telemetry and schema audit tracking.
- Updated `FavoritePokemonRepository` ordering logic to rely on `updatedAt` timestamps for parity with the Swift client.
 - `pubspec.yaml` updated with required packages: `sqflite`, `path`, `path_provider`, `synchronized`, and test-time `sqflite_common_ffi`.

### Diagnostics
- Added structured telemetry events for persistence operations to aid support analysis.

### Testing
- Introduced sqflite-backed service tests covering CRUD, concurrency, and durability flows.
- Extended FavoriteBloc and repository test suites to validate diagnostics workflows and telemetry-triggering scenarios.

## Features
- Pokemon list with pagination (30 items per page)
- Pull-to-refresh functionality
- Infinite scroll loading
- Favorite toggle per Pokemon
- Local persistence of favorites
- Error handling with user feedback
- Cross-platform feature parity (iOS and Flutter)

## Architecture
- **iOS**: MVVM pattern with Swift
- **Flutter**: BLoC pattern with Dart
- **Testing**: Comprehensive unit tests for both platforms
- **Networking**: Shared API patterns and error handling
- **Storage**: Local persistence for favorites
