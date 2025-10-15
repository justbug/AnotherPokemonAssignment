# flutter_another_pokemon_assignment

A Flutter port of the Another Pokémon assignment that now ships the full list and favorite flows from the iOS reference app.

## Feature Highlights
- Pokemon list screen driven by `PokemonListBloc` with initial load, pull-to-refresh, and incremental paging (30 items per request).
- Per-row `FavoriteBloc` lets users toggle favorites with optimistic updates and graceful error recovery.
- Persistent storage of favorites through `LocalPokemonService` (`SharedPreferences`) using the generated `LocalPokemon` model.
- Reusable `PokemonListWidget` that exposes hooks for custom list tiles while bundling loading/error states.
- SnackBar-based error surfacing that retains existing items so the user can retry without losing context.

## Architecture Overview
- **Presentation**: `PokemonListPage` hosts a `BlocConsumer` to react to list states and surface error banners; each tile nests a `FavoriteBloc`.
- **Domain**: `ListRepository` consolidates pagination, JSON parsing, and mapping into the `Pokemon` domain model; `FavoritePokemonRepository` delegates persistence to `LocalPokemonService`.
- **Services**: `PokemonService` and `DetailService` share the singleton `APIClient` via `RequestBuilder` helpers for consistent request/response handling.
- **Models**: `Pokemon`, `ListEntity`, `DetailEntity`, and `LocalPokemon` are generated through `freezed`/`json_serializable` for equality and serialization guarantees.
- **Testing**: Bloc tests cover success/error branches for list and favorite flows, while repository/service specs validate pagination logic and error propagation.

## Running the App
1. `flutter pub get`
2. `flutter run`

Launch flows: the app dispatches `PokemonListLoadRequested` on start-up, then reacts to pull-to-refresh and infinite scroll gestures. Favorite hearts immediately reflect taps while persistence finishes in the background.

## Testing
- `flutter test` exercises bloc behavior (loading, pagination, favorites) and repository/service contracts.

## Development Guidelines

This project includes Cursor Rules for consistent Flutter development:

### Cursor Rules Integration
- **Flutter BLoC Pattern**: Automated guidance for BLoC implementation and state management
- **Testing Guidelines**: Testing strategies for BLoCs, repositories, and services
- **Dependencies Management**: Package management and code generation best practices
- **Error Handling**: User experience and error recovery patterns

These rules are automatically applied by Cursor to assist with:
- BLoC pattern implementation
- State management best practices
- Repository pattern usage
- Model generation with freezed
- Testing strategy guidance
- Error handling implementation

## Project Layout
- `lib/blocs/` – `PokemonListBloc`, `FavoriteBloc`, and related events/states.
- `lib/repository/` – `ListRepository` and `FavoritePokemonRepository`.
- `lib/services/` – Networking helpers plus `LocalPokemonService`.
- `lib/widgets/` – `PokemonListWidget` wrapper that the page reuses.
- `test/` – Bloc and repository specs with `bloc_test`/`mockito`.

Additional deep dives: [`README_POKEMON_LIST.md`](README_POKEMON_LIST.md) and [`README_POKEMON_FAVORITE.md`](README_POKEMON_FAVORITE.md).
