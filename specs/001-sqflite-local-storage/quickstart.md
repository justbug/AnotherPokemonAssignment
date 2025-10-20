# Quickstart — SQLite Local Favorites Persistence

## Prerequisites
- Flutter SDK 3.19+ with Dart 3.9.2.
- Xcode 15+ and iOS Simulator for parity checks.
- Android Studio or Android Emulator (API 33+) for Android validation.
- Access to analytics/logging configuration used by the app (optional but
  recommended for telemetry verification).

## Setup Steps
1. **Install Dependencies**
   ```bash
   cd flutter_another_pokemon_assignment
   flutter pub add sqflite path path_provider synchronized
   flutter pub get
   ```
   For tests, also add:
   ```bash
   flutter pub add --dev sqflite_common_ffi
   ```
2. **Regenerate Code Artifacts**
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```
3. **Configure Local Database**
   - Ensure the new SQLite service initializes in `local_pokemon_service.dart`.
   - Verify the database path resolves using `path_provider`.
4. **Run Service Smoke Tests**
   ```bash
   flutter test test/services/local_pokemon_service_test.dart
   ```
   Or run the full test suite:
   ```bash
   flutter test
   ```
5. **Manual Validation**
   - Build and run on an emulator/device.
   - Favorite a set of Pokémon, force quit, relaunch, and confirm favorites
     persist and load quickly.
6. **Parity Verification (Swift)**
   ```bash
   cd ../AnotherPokemonAssignment
   xcodebuild test -scheme AnotherPokemonAssignment -destination 'platform=iOS Simulator,name=iPhone 15'
   ```
7. **Telemetry Check**
   - Inspect logs to confirm persistence events (upsert/delete/clear) emit status,
     count, and timestamps.

## Troubleshooting
- If persistence operations fail, clear the app (or delete the db file) and
  re-run with verbose logging enabled (`sqfliteFfiInit` for desktop debugging if needed).
- For concurrency-related issues, ensure all service entry points use the shared
  synchronized database instance.
