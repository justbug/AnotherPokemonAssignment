# Favorite Feature Overview

This document describes the comprehensive favorite functionality implemented by the global `FavoriteBloc`, `FavoritesListBloc`, the `FavoritePokemonRepository`, and the local persistence stack.

## Architecture

- `FavoriteBloc` is a global bloc that manages favorite status for all Pokémon in a centralized map.
- `FavoritesListBloc` handles the favorites list page display, loading, and refresh functionality.
- `FavoriteIconButton` widget provides per-item UI interactions that connect to the global bloc.
- `FavoritePokemonRepository` provides the persistence operations that the bloc depends on. It delegates storage to `LocalPokemonService`, which wraps `SharedPreferences`.
- `LocalPokemon` (generated via `freezed`/`json_serializable`) defines the enhanced persisted schema: `id`, `name`, `imageURL`, `isFavorite`, and `created` timestamp.
- Data flow is unidirectional: UI ➜ bloc event ➜ repository ➜ local service ➜ bloc state ➜ UI.
- **Enhanced Design**: Complete favorites list management with navigation, focusing on comprehensive favorite functionality.

## Events

### FavoriteBloc Events
| Event | Purpose |
| --- | --- |
| `FavoriteToggled` | Flip the favorite flag for a specific Pokémon (includes pokemonId, pokemonName, and imageURL). |

### FavoritesListBloc Events
| Event | Purpose |
| --- | --- |
| `FavoritesListLoadRequested` | Load favorites list on initial page load. |
| `FavoritesListRefreshRequested` | Refresh favorites list on pull-to-refresh. |

The global bloc is initialized in `main.dart` and favorite states are automatically loaded when PokemonListBloc or PokemonDetailBloc loads data.

**Enhanced Event Structure**: `FavoriteToggled` event now includes `imageURL` parameter for comprehensive favorite management with image support.

## States

### FavoriteBloc States
Every bloc state carries a `favoriteStatus` map (String -> bool) so the UI can remain consistent even while loading or when an error occurs.

| State | Description |
| --- | --- |
| `FavoriteSuccess` | Contains the complete favorite status map for all Pokémon. |
| `FavoriteError` | Reports failures with a message, while preserving the last known favorite status map. |

### FavoritesListBloc States
| State | Description |
| --- | --- |
| `FavoritesListInitial` | Initial state when the page loads. |
| `FavoritesListLoading` | Loading state while fetching favorites. |
| `FavoritesListSuccess` | Success state with list of favorite Pokémon. |
| `FavoritesListError` | Error state with message and optional previous data. |

The `favoriteStatus` map allows the `FavoriteIconButton` to efficiently check individual Pokémon favorite status using `state.isFavorite(pokemonId)`.

## Repository Responsibilities

`FavoritePokemonRepository` implements comprehensive operations:

- `isFavorite(pokemonId)`: Queries `LocalPokemonService.getById` and returns the stored `isFavorite` flag (falls back to `false` on errors).
- `toggleFavorite(pokemonId, pokemonName, imageURL)`: Reads the current state and either removes the Pokémon (if it was favorite) or inserts/updates it with `isFavorite = true`, `imageURL`, and `created` timestamp.
- `getFavoritePokemonList()`: Fetches all locally stored Pokémon, filters those marked as favorite, and sorts by creation time.
- `getAllFavoriteStatus()`: Returns a map of all Pokémon favorite statuses for efficient UI updates.

**Enhanced Data Model**: The repository now works with an enhanced `LocalPokemon` model that includes `id`, `name`, `imageURL`, `isFavorite`, and `created` timestamp for comprehensive favorite management.

Exception handling is conservative: read operations swallow errors and return safe defaults, while toggle operations rethrow to let the bloc decide how to surface the problem.

## Integration with the Navigation System

- The global `FavoriteBloc` and `FavoritesListBloc` are provided at the app level in `main.dart` using `BlocProvider`.
- `MainNavigationPage` provides bottom navigation between `PokemonListPage` and `FavoritesPage`.
- Favorite states are automatically loaded when PokemonListBloc or PokemonDetailBloc loads data.
- `PokemonDetailPage` integrates with global `FavoriteBloc` for favorite functionality in the detail view.
- `FavoritesPage` uses `FavoritesListBloc` to display and manage the favorites list with pull-to-refresh support.
- `FavoriteIconButton` widgets in each list tile and detail page connect to the global bloc and use `buildWhen` to optimize rebuilds.
- Tapping the heart emits `FavoriteToggled` with the specific Pokemon ID, name, and imageURL, which updates the global state map.
- When an error occurs, the bloc emits `FavoriteError` with the previous favorite status map so the UI keeps the last known state.

**Enhanced Integration**: Complete favorites list page with navigation and detail page integration, focusing on comprehensive favorite management with full UI support across all pages.

## Typical Usage

1. Provide the global `FavoriteBloc` and `FavoritesListBloc` at the app level using `BlocProvider`.
2. Use `MainNavigationPage` as the main entry point with bottom navigation.
3. Use `FavoriteIconButton` in list tiles and detail pages, passing the Pokemon ID, name, and imageURL.
4. The button automatically connects to the global bloc and handles state updates.
5. Favorite states are automatically loaded when PokemonListBloc or PokemonDetailBloc loads data.
6. Navigate to `PokemonDetailPage` to view comprehensive Pokemon information with favorite functionality.

```dart
// In main.dart
BlocProvider(
  create: (context) => FavoriteBloc(),
  child: BlocProvider(
    create: (context) => FavoritesListBloc(),
    child: MaterialApp(
      home: const MainNavigationPage(),
    ),
  ),
)

// In PokemonListPage
WidgetsBinding.instance.addPostFrameCallback((_) {
  // Favorite states are automatically loaded when PokemonListBloc or PokemonDetailBloc loads data
});

// In list tiles and detail pages
FavoriteIconButton(
  pokemonId: pokemon.id,
  pokemonName: pokemon.name,
  imageURL: pokemon.imageURL,
)
```

The global bloc loads all favorite states on startup, so all buttons immediately reflect the correct favorite status. The favorites page provides a dedicated view of all saved favorites with pull-to-refresh support. The detail page provides comprehensive Pokemon information with integrated favorite functionality.

**Enhanced Usage**: Complete navigation system with dedicated favorites page and detail page integration, focusing on comprehensive favorite management with full UI support across all pages.

## Testing Notes

- `test/favorite_bloc_test.dart` covers global state management, toggle success, toggle removal, and repository error propagation using Mockito to drive each branch.
- Mock or stub the repository when unit-testing the bloc to simulate favorite toggles and failure scenarios.
- Test the `FavoriteIconButton` widget with a global bloc provider to verify UI interactions in both list and detail pages.
- Test the `FavoritesPage` with `FavoritesListBloc` to verify favorites list display and refresh functionality.
- Test the `PokemonDetailPage` with `FavoriteIconButton` integration to verify favorite functionality in detail view.
- For integration-style testing, provide a fake `LocalPokemonService` that writes to an in-memory map to avoid disk access from `SharedPreferences`.
- Test navigation between Pokemon list, favorites list, and detail page to ensure proper state management.
