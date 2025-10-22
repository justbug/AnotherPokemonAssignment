# AnotherPokemonAssignment Development Guidelines

Auto-generated from all feature plans. Last updated: 2025-10-20

## Active Technologies
- Dart 3.9 (Flutter 3.x), Swift 5.9 (parity verification)
- Flutter local storage: `sqflite` for SQLite DB, `path`/`path_provider` for file paths, `synchronized` for concurrency
  - Tests: `sqflite_common_ffi`
- Dart 3.9.2, Flutter 3.x + `flutter_bloc`, `supabase_flutter`, `cached_network_image`, `freezed`, `http` (existing) (002-pokemon-silhouette-quiz)
- In-memory cache within quiz repository/BLoC (no persistent storage) (002-pokemon-silhouette-quiz)

## Project Structure
```
src/
tests/
```

## Commands
# Add commands for Dart 3.9 (Flutter 3.x), Swift 5.9 (parity verification)

## Code Style
Dart 3.9 (Flutter 3.x), Swift 5.9 (parity verification): Follow standard conventions

## Recent Changes
- 002-pokemon-silhouette-quiz: Added Dart 3.9.2, Flutter 3.x + `flutter_bloc`, `supabase_flutter`, `cached_network_image`, `freezed`, `http` (existing)
- 002-pokemon-silhouette-quiz: Added [if applicable, e.g., PostgreSQL, CoreData, files or N/A]
- 001-sqflite-local-storage: Migrated Flutter favorites to SQLite with telemetry and ordering by `updatedAt`. Added `LocalPokemonDatabase`, `LocalPokemonTelemetry`, tests, and specs.

<!-- MANUAL ADDITIONS START -->
<!-- MANUAL ADDITIONS END -->
