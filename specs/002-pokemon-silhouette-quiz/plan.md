# Implementation Plan: Pokemon Silhouette Quiz

**Branch**: `002-pokemon-silhouette-quiz` | **Date**: 2025-10-23 | **Spec**: [spec.md](spec.md)  
**Input**: Feature specification from `/specs/002-pokemon-silhouette-quiz/spec.md`

## Summary
- Add a new “Who’s That Pokémon” quiz tab to the Flutter app’s bottom navigation.
- Use Supabase (per provided API) to fetch the Pokemon list once, cache it, and build quiz rounds with a single detail request per round.
- Drive gameplay with a dedicated BLoC handling option selection, reveal state, countdown, and automatic reset.

## Technical Context

**Language/Version**: Dart 3.9.2, Flutter 3.x  
**Primary Dependencies**: `flutter_bloc`, `supabase_flutter`, `cached_network_image`, `freezed`, `http` (existing)  
**Storage**: In-memory cache within quiz repository/BLoC (no persistent storage)  
**Testing**: `flutter_test`, `bloc_test`, `mockito` for Supabase client stubbing  
**Target Platform**: Flutter mobile clients (Android/iOS runtime)  
**Project Type**: Mobile application (Flutter module)  
**Performance Goals**: Maintain 60 FPS UI; keep quiz round generation < 300 ms after initial fetch  
**Constraints**: Pokemon list API called only once per session; countdown accuracy ±0.5s; degrade gracefully on network/image errors  
**Scale/Scope**: Single new tab, one page flow, reused across entire Pokemon catalog (151+ entries)

## Constitution Check

- **I. Cross-Platform Feature Parity (NON-NEGOTIABLE)** – ⚠ *Temporary exception*: Product direction limits scope to Flutter for this release. Mitigation: document follow-up ticket to scope iOS parity, ensure shared domain models remain compatible, and avoid breaking current Swift clients. Owner: Flutter lead (Mark) with parity review scheduled next planning cycle.
- **II. Typed API Contracts & Shared Domain Models** – ✅ New DTOs mirror Supabase responses and are documented in `contracts/pokemon-silhouette-api.md`. No breaking changes to shared models.
- **III. State Management Discipline** – ✅ Plan introduces dedicated quiz BLoC with explicit events/states; UI remains passive.
- **IV. Test-Centric Delivery** – ✅ Unit tests planned for repositories, BLoC transitions, and countdown timing; mocks generated via `build_runner`.
- **V. Resilient Favorites Persistence** – ✅ Feature does not touch favorites; no regression risk but integration tests will ensure favorites tab unaffected.

## Project Structure

### Documentation (this feature)

```
specs/002-pokemon-silhouette-quiz/
├── plan.md
├── research.md
├── data-model.md
├── quickstart.md
├── contracts/
│   └── pokemon-silhouette-api.md
└── checklists/
    └── requirements.md
```

### Source Code (repository root)

```
flutter_another_pokemon_assignment/
├── lib/
│   ├── blocs/
│   │   └── quiz/                # new bloc, events, states
│   ├── models/
│   │   └── quiz/                # new DTOs (freezed)
│   ├── pages/
│   │   └── quiz_page.dart       # new quiz screen
│   ├── repository/
│   │   └── quiz_repository.dart # new repository interface + impl
│   ├── services/
│   │   └── supabase_quiz_service.dart
│   └── widgets/
│       └── quiz/                # shared quiz widgets (option buttons/countdown)
├── test/
│   ├── blocs/quiz/
│   ├── repository/quiz/
│   └── widgets/quiz/
└── lib/main.dart                # Supabase init + nav tab addition
```

**Structure Decision**: Extend existing Flutter module with feature-specific subfolders under `lib/` and mirrored test directories; no changes planned for Swift project per scoped exception.

## Complexity Tracking

| Violation | Why Needed | Simpler Alternative Rejected Because |
|-----------|------------|-------------------------------------|
| Flutter-only delivery (violates Parity principle) | Product mandates Flutter-first release; iOS bandwidth unavailable in current sprint | Building Swift counterpart now would double scope; mitigation is to log parity follow-up and keep shared contracts stable |
