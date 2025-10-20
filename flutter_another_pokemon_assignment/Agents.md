# Flutter Another Pokémon Assignment – Agent Guide

This guide summarizes the Flutter codebase so automation agents can navigate the project, extend features, and write tests confidently. It consolidates the essential decisions already documented across the repo.

## Project Purpose
- Deliver a full Pokémon catalogue with list, detail, and favorites flows.
- Mirror the Swift implementation shipped in `AnotherPokemonAssignment/` while taking advantage of Flutter tooling.
- Demonstrate robust state management (`flutter_bloc`), persistence (`SharedPreferences`), and modular data access.

## Directory Map
- `lib/main.dart` – entry point; wires global BLoCs (`PokemonListBloc`, `FavoriteBloc`, `FavoritesListBloc`) and routes to `MainNavigationPage`.
- `lib/pages/` – screen widgets (`PokemonListPage`, `FavoritesPage`, `PokemonDetailPage`, `MainNavigationPage`).
- `lib/widgets/` – shared UI (notably `PokemonListWidget`, `FavoriteIconButton`).
- `lib/blocs/` – state machines for list, detail, favorites, and shared events/states.
- `lib/models/` – domain models (`Pokemon`, `PokemonDetailData`, `LocalPokemon`, entities).
- `lib/repository/` – domain-level data access (`ListRepository`, `DetailRepository`, `FavoritePokemonRepository`).
- `lib/services/` – infrastructure (`PokemonService`, `DetailService`, `LocalPokemonService`, networking helpers).
- `test/` – bloc, repository, and helper specs using `bloc_test`, `mockito`, and `flutter_test`.

## State Management Overview
| Bloc | Responsibilities | Key Events | Emitted States |
| --- | --- | --- | --- |
| `PokemonListBloc` | Fetch paginated Pokémon list, refresh, load-more, react to favorite toggles. | `PokemonListLoadRequested`, `PokemonListRefreshRequested`, `PokemonListLoadMoreRequested`, `PokemonListFavoriteToggled` | `PokemonListInitial`, `PokemonListLoading`, `PokemonListLoadingMore`, `PokemonListSuccess`, `PokemonListError` |
| `FavoriteBloc` | Global favorite toggle orchestration; propagates changes to list/detail. | `FavoriteToggled` | `FavoriteInitial`, `FavoriteSuccess`, `FavoriteError` |
| `FavoritesListBloc` | Manage dedicated favorites page (initial load + pull-to-refresh). | `FavoritesListLoadRequested`, `FavoritesListRefreshRequested` | `FavoritesListInitial`, `FavoritesListLoading`, `FavoritesListSuccess`, `FavoritesListError` |
| `PokemonDetailBloc` | Fetch detail payload, integrate favorite status, handle toggles in-detail view. | `PokemonDetailLoadRequested`, `PokemonDetailFavoriteToggled` | `PokemonDetailInitial`, `PokemonDetailLoading`, `PokemonDetailSuccess`, `PokemonDetailError` |

- `FavoriteBloc` is provided at app scope so every page can listen via `BlocListener`. When a toggle succeeds, pages dispatch list/detail events to keep their local state aligned.
- `pokemon_list_widget.dart` and `favorite_icon_button.dart` encapsulate UI wiring so BLoCs stay focused on business rules.

## Data & Networking Stack
- `ListRepository` (implements `ListRepositorySpec`) bridges `PokemonService` with domain `Pokemon` models, handling pagination (`limit=30`, `offset` parameter) and ID extraction from API URLs.
- `DetailRepository` composes the `Pokemon` model with a `PokemonDetailData` payload returned by `DetailService`.
- `FavoritePokemonRepository` fronts the persistence layer by exposing `isFavorite`, `updateFavorite`, `getFavoritePokemonIds`, and `getFavoritePokemonList`. It preserves creation timestamps and returns sorted lists for the favorites page.
- Network clients (`PokemonService`, `DetailService`) share the `APIClient`/`RequestBuilder` infrastructure, providing typed errors and reusable request assembly.

## Local Persistence
- `LocalPokemonService` wraps `SharedPreferences` to store serialized `LocalPokemon` maps under the `pokemon_data` key.
- `LocalPokemon` (from `models/local_pokemon.dart`) is generated via `freezed`/`json_serializable` and includes `id`, `name`, `imageURL`, `isFavorite`, `created`.
- Reads guard against malformed data and return safe defaults; writes rethrow so BLoCs can emit `FavoriteError`.

## UI Composition
- `MainNavigationPage` provides bottom navigation with an `IndexedStack` to preserve tab state.
- `PokemonListPage` wires scroll/pull-to-refresh callbacks to list bloc events and renders rows through `PokemonListWidget`.
- `FavoritesPage` hosts the favorites list supplied by `FavoritesListBloc`, using pull-to-refresh gestures for reloads.
- `PokemonDetailPage` shows the hero image, type chips, and stats. A `BlocListener<FavoriteBloc>` replays favorite transitions into the detail bloc when the IDs match.

## Testing Expectations
- `test/pokemon_list_bloc_test.dart` exercises success, pagination, refresh, and failure states with `bloc_test` and `mockito`.
- `test/favorite_bloc_test.dart` asserts persistence-first toggles, error propagation, and state contents (`favoritePokemonIds`, `toggledPokemonFavoriteStatus`).
- `test/detail_repository_test.dart` verifies detail parsing and error translation.
- `test/helpers/test_helpers.dart` centralizes fixture factories for `LocalPokemon`, API entities, and mock setup.
- Run `flutter test` from `flutter_another_pokemon_assignment/` to execute the full suite (`README_TESTING.md` details additional scenarios).

## Development Notes for Agents
- Generated files: respect `freezed`/`build_runner` output conventions; regenerate via `flutter pub run build_runner build --delete-conflicting-outputs` when model changes are introduced.
- Keep state updates immutable; rely on each model’s `copyWith` for selective field updates (e.g., toggling favorites).
- Emit descriptive error strings so SnackBars and error widgets surface actionable information.
- Prefer repository injection in BLoC constructors to simplify testing (see optional parameters across BLoCs).
- Align new features with the documented flows in `README_ARCHITECTURE.md`, `README_POKEMON_LIST.md`, `README_POKEMON_DETAIL.md`, and `README_POKEMON_FAVORITE.md`.

## Cross-Platform Alignment
- Swift and Flutter share conceptually identical layers (UseCase/Repository, Service, Store). When adjusting domain contracts, reflect the change in both implementations to maintain parity.
- Naming mirrors the Swift target (e.g., `ListRepository` ↔︎ iOS `ListUseCase`, `FavoritePokemonRepository` ↔︎ `PokemonStoreUseCase` + persistence).

## Useful Commands
```bash
flutter pub get                      # Install dependencies
flutter test                         # Run automated test suite
flutter run                          # Launch the app on connected device/emulator
flutter pub run build_runner build   # Regenerate freezed/json_serializable outputs
```

Use this guide as the quick-start reference when building new automations, writing features, or performing refactors within the Flutter app.
