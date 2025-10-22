# Tasks: Pokemon Silhouette Quiz

**Input**: Design documents from `/specs/002-pokemon-silhouette-quiz/`
**Prerequisites**: plan.md, spec.md, research.md, data-model.md, contracts/

## Phase 1: Setup (Shared Infrastructure)

**Purpose**: Prepare dependencies and configuration needed across all stories.

- [ ] T001 Update Supabase dependency block in `flutter_another_pokemon_assignment/pubspec.yaml` to include `supabase_flutter` and run `flutter pub get`
- [ ] T002 Create Supabase config stubs in `flutter_another_pokemon_assignment/lib/config/supabase_keys.dart` using compile-time `dart-define` lookups

---

## Phase 2: Foundational (Blocking Prerequisites)

**Purpose**: Core infrastructure all stories rely on. Complete before any user story work.

- [ ] T003 Initialize Supabase before `runApp` in `flutter_another_pokemon_assignment/lib/main.dart` and ensure failure surfaces user-friendly error
- [ ] T004 Author failing repository specs covering list caching and detail fetch in `flutter_another_pokemon_assignment/test/repository/quiz/quiz_repository_test.dart`
- [ ] T005 Implement Supabase quiz service wrapper in `flutter_another_pokemon_assignment/lib/services/supabase_quiz_service.dart` using edge function endpoints
- [ ] T006 Implement quiz repository with in-memory list cache in `flutter_another_pokemon_assignment/lib/repository/quiz_repository.dart` to satisfy T004 tests

**Checkpoint**: Supabase integration and repository ready.

---

## Phase 3: User Story 1 – Identify Pokemon From Silhouette (Priority: P1) 🎯 MVP

**Goal**: Display silhouette image with three unique name options sourced from cached list.
**Independent Test**: Load quiz tab and confirm silhouette plus three distinct options render; correct answer present; only first tap processed.

### Tests (write first)
- [ ] T007 [US1] Add quiz bloc load tests ensuring list fetch + option sampling in `flutter_another_pokemon_assignment/test/blocs/quiz/quiz_bloc_load_test.dart`
- [ ] T008 [P] [US1] Add widget smoke test for silhouette screen layout in `flutter_another_pokemon_assignment/test/widgets/quiz/quiz_page_initial_test.dart`

### Implementation
- [ ] T009 [P] [US1] Define quiz Freezed models (`PokemonQuizEntry`, `PokemonQuizOption`, `QuizRound`) in `flutter_another_pokemon_assignment/lib/models/quiz/quiz_models.dart`
- [ ] T010 [US1] Implement quiz bloc initial states/events for round generation in `flutter_another_pokemon_assignment/lib/blocs/quiz/quiz_bloc.dart`
- [ ] T011 [US1] Build quiz page scaffold with silhouette image and three option buttons in `flutter_another_pokemon_assignment/lib/pages/quiz_page.dart`
- [ ] T012 [US1] Export quiz page and integrate new tab labeled “Quiz” in `flutter_another_pokemon_assignment/lib/pages/main_navigation_page.dart`

**Checkpoint**: Quiz tab loads silhouette with selectable options; repository tests green.

---

## Phase 4: User Story 2 – Reveal Answer Feedback (Priority: P2)

**Goal**: After selection, reveal official artwork, show “It’s {Name}”, and mark correct/incorrect icons.
**Independent Test**: Select any option and verify reveal state shows correct art, message, and icon feedback while locking inputs.

### Tests (write first)
- [ ] T013 [US2] Extend bloc tests for selection event producing reveal state in `flutter_another_pokemon_assignment/test/blocs/quiz/quiz_bloc_reveal_test.dart`
- [ ] T014 [P] [US2] Add widget golden/assertion test verifying icons and message in reveal state in `flutter_another_pokemon_assignment/test/widgets/quiz/quiz_page_reveal_test.dart`

### Implementation
- [ ] T015 [US2] Implement selection handling and reveal state transitions in `flutter_another_pokemon_assignment/lib/blocs/quiz/quiz_bloc.dart`
- [ ] T016 [US2] Update quiz page to swap silhouette for official art, render “It’s {Name}”, and display Material icons in `flutter_another_pokemon_assignment/lib/pages/quiz_page.dart`
- [ ] T017 [US2] Add reusable option widget with correct/incorrect icon logic in `flutter_another_pokemon_assignment/lib/widgets/quiz/quiz_option_button.dart`

**Checkpoint**: Reveal flow works end-to-end with visual feedback.

---

## Phase 5: User Story 3 – Automatic Round Reset (Priority: P3)

**Goal**: Start three-second countdown post-reveal and auto-reset to fresh round when timer ends.
**Independent Test**: Observe countdown text decreasing to zero and UI returning to new silhouette without manual input.

### Tests (write first)
- [ ] T018 [US3] Add bloc timer tests validating countdown ticks and round reset in `flutter_another_pokemon_assignment/test/blocs/quiz/quiz_bloc_countdown_test.dart`
- [ ] T019 [P] [US3] Add widget test verifying countdown text and state reset in `flutter_another_pokemon_assignment/test/widgets/quiz/quiz_page_countdown_test.dart`

### Implementation
- [ ] T020 [US3] Introduce countdown events/state management with timer cancellation safeguards in `flutter_another_pokemon_assignment/lib/blocs/quiz/quiz_bloc.dart`
- [ ] T021 [US3] Render countdown text and reset visuals in `flutter_another_pokemon_assignment/lib/pages/quiz_page.dart`
- [ ] T022 [US3] Ensure repository/option reset logic refreshes selections and icons before next round in `flutter_another_pokemon_assignment/lib/repository/quiz_repository.dart`

**Checkpoint**: Quiz auto-resets seamlessly after countdown.

---

## Phase 6: Polish & Cross-Cutting Concerns

**Purpose**: Final resilience, documentation, and manual verification.

- [ ] T023 [P] Add error fallback and retry UI states for list/detail failures in `flutter_another_pokemon_assignment/lib/pages/quiz_page.dart`
- [ ] T024 Document Supabase setup and quiz controls in `flutter_another_pokemon_assignment/README.md`
- [ ] T025 Run full Flutter test suite and update coverage notes in `flutter_another_pokemon_assignment/test/README.md`

---

## Dependencies & Execution Order

1. **Phase 1** → prerequisite for Supabase usage.
2. **Phase 2** → must complete before any user story work.
3. **Phase 3 (US1)** → builds MVP; required before reveal and countdown features.
4. **Phase 4 (US2)** → depends on US1 bloc/page scaffolding.
5. **Phase 5 (US3)** → depends on US2 reveal state.
6. **Phase 6** → final polish after core flows stable.

---

## Parallel Opportunities

- Tasks marked `[P]` can execute concurrently (e.g., T008 with T007, T014 with T013, T019 with T018) if different files.
- After Phase 2, teams can split: one developer on US1 implementation while another prepares US2 tests (pending US1 outputs).
- Widget tests for different states (T008, T014, T019) can run in parallel once respective UI hooks exist.

---

## Independent Test Criteria by User Story

- **US1**: Load quiz tab → silhouette + three unique options; tapping option disables buttons without reveal yet.
- **US2**: From ready state → tap option → official art, “It’s {Name}”, correct option checkmark, wrong selection X.
- **US3**: From reveal state → countdown displays 3→0 and UI resets to new silhouette automatically.

---

## Suggested MVP Scope

- Complete Phases 1–3 (through User Story 1). This delivers playable quiz with silhouette guessing and sets stage for enhancements.

---

## Format Validation

- All tasks follow `- [ ] T### [P?] [US?] Description with file path`.
