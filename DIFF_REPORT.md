# Diff Report — 002-pokemon-silhouette-quiz vs main

Date: 2025-10-23

## Summary
- Added Supabase-backed "Who's That Pokémon" quiz with new BLoC, models, repository, and services.
- Integrated Supabase initialization into `main.dart` with runtime configuration validation.
- Introduced quiz UI tab, countdown reveal flow, and cached option sampling.
- Expanded automated coverage with bloc, repository, and widget tests for quiz scenarios.
- Authored full specification set under `specs/002-pokemon-silhouette-quiz/`.

## Key File Changes
- Added: `flutter_another_pokemon_assignment/lib/blocs/quiz/` (bloc, events, states)
- Added: `flutter_another_pokemon_assignment/lib/models/quiz/` (`freezed` models and generated files)
- Added: `flutter_another_pokemon_assignment/lib/pages/quiz_page.dart` and `lib/widgets/quiz/quiz_option_button.dart`
- Added: `flutter_another_pokemon_assignment/lib/repository/quiz_repository.dart` and `lib/services/supabase_quiz_service.dart`
- Modified: `flutter_another_pokemon_assignment/lib/main.dart` and `lib/pages/main_navigation_page.dart` for Supabase setup and navigation tab
- Added tests under `flutter_another_pokemon_assignment/test/blocs/quiz/`, `test/repository/quiz/`, and `test/widgets/quiz/`
- Added documentation: `flutter_another_pokemon_assignment/README.md`, `AGENTS.md`, `CHANGELOG.md`, and `specs/002-pokemon-silhouette-quiz/`

## Dependencies
- `pubspec.yaml` now includes runtime Supabase support via `supabase_flutter` and bumps `json_annotation` for generated quiz models.
- Dev dependencies gain `mocktail` to simplify bloc/repository mocking alongside existing `mockito` suites.

## Notes
- Supabase credentials are injected at runtime via `--dart-define`; fallback UI surfaces configuration errors.
- Quiz repository maintains an in-memory list of candidates to avoid redundant Supabase fetches between rounds.
