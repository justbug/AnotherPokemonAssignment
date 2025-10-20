# Tasks: SQLite Local Favorites Persistence

**Input**: Design documents from `/specs/001-sqflite-local-storage/`  
**Prerequisites**: plan.md (required), spec.md (required for user stories), research.md, data-model.md, contracts/

**Tests**: Include regression coverage for service CRUD, persistence telemetry, and BLoC clear-flow handling per specification.

**Organization**: Tasks are grouped by user story to enable independent implementation and testing of each story.

## Format: `[ID] [P?] [Story] Description`
- **[P]**: Can run in parallel (different files, no dependencies)
- **[Story]**: Which user story this task belongs to (e.g., US1, US2)
- Include exact file paths in descriptions

## Phase 1: Setup (Shared Infrastructure)

- [X] T001 Update sqflite-related dependencies in `flutter_another_pokemon_assignment/pubspec.yaml` (add `sqflite`, `path`, `path_provider`, `synchronized`, lock compatible versions)

---

## Phase 2: Foundational (Blocking Prerequisites)

- [X] T002 Create SQLite database utility `LocalPokemonDatabase` with table creation and version constants in `flutter_another_pokemon_assignment/lib/services/local_pokemon_database.dart`
- [X] T003 Add telemetry constants and helper for persistence events in `flutter_another_pokemon_assignment/lib/services/local_pokemon_telemetry.dart`

**Checkpoint**: Database scaffolding and telemetry hooks ready—user story work can now begin.

---

## Phase 3: User Story 1 - Favorites Persist Reliably (Priority: P1) 🎯 MVP

**Goal**: Ensure favorites survive app restarts with SQLite-backed storage.  
**Independent Test**: Favorite several Pokémon, force-quit, relaunch, and confirm favorites plus ordering restored within 3 seconds while telemetry logs success.

### Tests for User Story 1 ⚠️

- [X] T009 [P] [US1] Add CRUD and concurrency regression tests for SQLite service in `flutter_another_pokemon_assignment/test/services/local_pokemon_service_test.dart`
- [ ] T010 [P] [US1] **Removed** – migration from SharedPreferences is no longer supported.

### Implementation for User Story 1

- [X] T004 [US1] Extend `LocalPokemon` data class with `updatedAt` and defaults in `flutter_another_pokemon_assignment/lib/models/local_pokemon.dart` (regenerate Freezed/JSON outputs)
- [X] T005 [US1] Replace SharedPreferences logic with SQLite operations using `LocalPokemonDatabase` in `flutter_another_pokemon_assignment/lib/services/local_pokemon_service.dart`
- [ ] T006 [US1] **Removed** – migration and audit persistence dropped (fresh SQLite store on install).
- [X] T007 [US1] Emit persistence telemetry using new helper in `flutter_another_pokemon_assignment/lib/services/local_pokemon_service.dart`
- [X] T008 [US1] Update favorites repository sorting and timestamp handling in `flutter_another_pokemon_assignment/lib/repository/favorite_pokemon_repository.dart`
- [X] T011 [P] [US1] Refresh repository unit tests for updated timestamps and ordering in `flutter_another_pokemon_assignment/test/repository/favorite_pokemon_repository_test.dart`

**Checkpoint**: Favorites persist via SQLite and automated tests cover CRUD plus telemetry.

---

## Phase 4: User Story 2 - Operations Maintain Favorite Data (Priority: P2)

**Goal**: Provide support tooling to inspect and clear favorites with telemetry so analysts can triage inconsistencies quickly.  
**Independent Test**: Trigger the clear action via debug tooling and verify favorites list empties, telemetry logs the operation, and QA can repopulate without residual data.

### Tests for User Story 2 ⚠️

- [X] T015 [P] [US2] Extend repository tests for clear/diagnostic flow in `flutter_another_pokemon_assignment/test/repository/favorite_pokemon_repository_test.dart`
- [X] T016 [P] [US2] Add FavoriteBloc clear-event tests covering success and failure in `flutter_another_pokemon_assignment/test/favorite_bloc_test.dart`

### Implementation for User Story 2

- [ ] T012 [US2] **Removed** – repository diagnostics for clearing favorites no longer in scope.
- [ ] T013 [US2] **Removed** – clear events/states eliminated from FavoriteBloc implementation.
- [ ] T014 [US2] **Removed** – debug-only clear control removed from `flutter_another_pokemon_assignment/lib/pages/favorites_page.dart`.
- [ ] T017 [US2] **Removed** – clear-operation telemetry dropped from `flutter_another_pokemon_assignment/lib/services/local_pokemon_service.dart`.

**Checkpoint**: Support analysts can clear and audit favorites with full telemetry visibility.

---

## Phase N: Polish & Cross-Cutting Concerns

- [X] T018 Document SQLite storage behavior and support workflow in `flutter_another_pokemon_assignment/README_POKEMON_FAVORITE.md`
- [X] T019 Update release notes describing the SQLite transition in `CHANGELOG.md`
- [X] T020 Validate parity by rerunning Swift favorites tests in `AnotherPokemonAssignment/Tests/FavoriteTests` and document outcomes

---

## Dependencies & Execution Order

### Phase Dependencies

- Setup (Phase 1) → Foundational (Phase 2)
- User Story 1 depends on Foundational completion
- User Story 2 depends on User Story 1 completion
- Polish depends on all user stories completed

### User Story Dependencies

- **US1 (P1)**: Requires DB scaffolding; delivers MVP parity.
- **US2 (P2)**: Extends repository/BLoC after US1 storage is live.

### Within Each User Story

- Update models/service before repository/UI layers.
- Write/refresh tests after implementing logic (parallelizable where marked [P]).

### Parallel Opportunities

- [P] tasks in tests can run once corresponding implementation files are ready.
- Repository and BLoC test updates (T011, T015, T016) can proceed concurrently after implementations land.

---

## Implementation Strategy

### MVP First (User Story 1 Only)
1. Complete Setup and Foundational phases.
2. Deliver US1 implementation tasks (T004–T008) before enabling telemetry or QA tooling.
3. Run regression tests (T009–T011) to confirm persistence guarantees.

### Incremental Delivery
1. Deploy SQLite persistence (US1) to beta for validation.
2. Layer on support diagnostics (US2) once stability confirmed.
3. Finish with documentation and parity verification.

### Parallel Team Strategy
- Developer A: Handle database utility and service implementation (T002, T005–T007).
- Developer B: Focus on repository/UI updates and tests (T008, T011, T012–T016).
- Developer C: Own telemetry helpers, documentation, and parity verification (T003, T017–T020).
