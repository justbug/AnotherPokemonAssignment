# flutter_another_pokemon_assignment

A Flutter port of the Another Pokémon assignment that implements a simplified Pokemon list with favorite functionality.

## Feature Highlights
- Pokemon list screen driven by `PokemonListBloc` with initial load, pull-to-refresh, and incremental paging (30 items per request).
- Global `FavoriteBloc` manages all Pokemon favorite states with `FavoriteIconButton` providing per-item interactions and optimistic updates.
- **Favorites List Page**: Complete favorites management with `FavoritesListBloc`, pull-to-refresh, and error handling.
- **Bottom Navigation**: Seamless switching between Pokemon list and favorites list using `MainNavigationPage`.
- Persistent storage of favorites through `LocalPokemonService` (`SharedPreferences`) using the enhanced `LocalPokemon` model with `imageURL` and `created` timestamp.
- Reusable `PokemonListWidget` that exposes hooks for custom list tiles while bundling loading/error states.
- SnackBar-based error surfacing that retains existing items so the user can retry without losing context.
- **Enhanced Architecture**: Full favorites list management with navigation, focusing on complete Pokemon list functionality with comprehensive favorite features.

## Architecture Overview
- **Presentation**: `MainNavigationPage` provides bottom navigation between `PokemonListPage` and `FavoritesPage` with `IndexedStack` for state preservation.
- **State Management**: Global `FavoriteBloc` manages all Pokemon favorite states centrally, with `FavoritesListBloc` handling favorites list display and `FavoriteIconButton` providing per-item UI interactions.
- **Domain**: `ListRepository` consolidates pagination, JSON parsing, and mapping into the `Pokemon` domain model; `FavoritePokemonRepository` delegates persistence to `LocalPokemonService`.
- **Services**: `PokemonService` and `DetailService` share the singleton `APIClient` via `RequestBuilder` helpers for consistent request/response handling.
- **Models**: `Pokemon`, `ListEntity`, `DetailEntity`, and enhanced `LocalPokemon` are generated through `freezed`/`json_serializable` for equality and serialization guarantees.
- **Testing**: Bloc tests cover success/error branches for list and favorite flows, while repository/service specs validate pagination logic and error propagation.
- **Enhanced Data Model**: `LocalPokemon` model includes `id`, `name`, `imageURL`, `isFavorite`, and `created` timestamp for comprehensive favorite management.

## Running the App
1. `flutter pub get`
2. `flutter run`

Launch flows: the app starts with `MainNavigationPage` providing bottom navigation between Pokemon list and favorites. The Pokemon list dispatches `PokemonListLoadRequested` on start-up, then reacts to pull-to-refresh and infinite scroll gestures. The favorites page uses `FavoritesListBloc` to display saved favorites with pull-to-refresh support. Favorite hearts immediately reflect taps while persistence finishes in the background.

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
- `lib/blocs/` – `PokemonListBloc`, global `FavoriteBloc`, `FavoritesListBloc`, and related events/states.
- `lib/pages/` – `MainNavigationPage`, `PokemonListPage`, and `FavoritesPage` with bottom navigation.
- `lib/repository/` – `ListRepository` and `FavoritePokemonRepository`.
- `lib/services/` – Networking helpers plus `LocalPokemonService` with service specifications.
- `lib/widgets/` – `PokemonListWidget` and `FavoriteIconButton` reusable components.
- `test/` – Bloc and repository specs with `bloc_test`/`mockito`.

## Recent Changes
- **Added Favorites List Feature**: Implemented `FavoritesListBloc`, `FavoritesPage`, and complete navigation system.
- **Enhanced Data Model**: `LocalPokemon` now includes `imageURL` and `created` timestamp for comprehensive favorite management.
- **Navigation Architecture**: Added `MainNavigationPage` with bottom navigation between Pokemon list and favorites.
- **Service Layer**: Introduced service specifications and improved dependency injection patterns.

Additional deep dives: [`README_POKEMON_LIST.md`](README_POKEMON_LIST.md) and [`README_POKEMON_FAVORITE.md`](README_POKEMON_FAVORITE.md).
