# Diff Report — 001-sqflite-local-storage vs main

Date: 2025-10-20

## Summary
- Migrated Flutter favorites persistence from SharedPreferences to SQLite.
- Added `LocalPokemonDatabase` and `LocalPokemonTelemetry` services.
- Updated repository ordering by `updatedAt` for parity with Swift.
- Expanded tests: service CRUD, repository logic, FavoriteBloc scenarios.
- Updated docs and specs under `specs/001-sqflite-local-storage/`.

## Key File Changes
- Added: `flutter_another_pokemon_assignment/lib/services/local_pokemon_database.dart`
- Added: `flutter_another_pokemon_assignment/lib/services/local_pokemon_telemetry.dart`
- Modified: `flutter_another_pokemon_assignment/lib/services/local_pokemon_service.dart`
- Modified: `flutter_another_pokemon_assignment/lib/repository/favorite_pokemon_repository.dart`
- Modified tests under `flutter_another_pokemon_assignment/test/`
- Updated docs: `CHANGELOG.md`, `AGENTS.md`, `README.md`, `README_POKEMON_FAVORITE.md`

## Dependencies
- `pubspec.yaml` now includes:
  - runtime: `sqflite`, `path`, `path_provider`, `synchronized`
  - dev (tests): `sqflite_common_ffi`

## Notes
- No migration from legacy SharedPreferences; fresh SQLite store only.
- Telemetry added to support diagnostics for persistence operations.


