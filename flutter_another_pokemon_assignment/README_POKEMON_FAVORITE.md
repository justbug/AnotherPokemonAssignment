# Favorite Feature Overview

This document describes the comprehensive favorite functionality implemented by the global `FavoriteBloc`, `FavoritesListBloc`, the `FavoritePokemonRepository`, and the local persistence stack.

## Architecture

- `FavoriteBloc` is a global bloc that manages favorite toggle operations and emits events for other BLoCs to react.
- `FavoritesListBloc` handles the favorites list page display, loading, and refresh functionality.
- `FavoriteIconButton` widget provides per-item UI interactions that connect to the global bloc.
- `FavoritePokemonRepository` provides the persistence operations that the bloc depends on. It delegates storage to `LocalPokemonService`, which now writes to a SQLite-backed `LocalPokemonDatabase`.
- `LocalPokemon` (generated via `freezed`/`json_serializable`) defines the enhanced persisted schema: `id`, `name`, `imageURL`, `isFavorite`, `created`, and `updatedAt` timestamps (the latter drives ordering and diagnostics).
- **Model Integration**: Works seamlessly with unified `Pokemon` model that includes `isFavorite` property and optional `detail` information.
- **Event-Driven Architecture**: Data flow is unidirectional with event propagation: UI ➜ FavoriteBloc event ➜ repository ➜ local service ➜ FavoriteBloc state ➜ BlocListener ➜ other BLoCs ➜ UI.
- **Enhanced Design**: Complete favorites list management with navigation, focusing on comprehensive favorite functionality with event-driven state synchronization.

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

The global bloc is initialized in `main.dart` and favorite states are loaded when PokemonListBloc or PokemonDetailBloc loads data through their respective repositories.

**Enhanced Event Structure**: `FavoriteToggled` event now includes `imageURL` parameter for comprehensive favorite management with image support.

## States

### FavoriteBloc States
Every bloc state carries a `favoritePokemonIds` set (`Set<String>`) so the UI can remain consistent even while loading or when an error occurs.

| State | Description |
| --- | --- |
| `FavoriteInitial` | Initial state when the bloc is created. |
| `FavoriteSuccess` | Contains the complete favorite id set for all Pokémon, plus `toggledPokemonFavoriteStatus` for tracking changes. |
| `FavoriteError` | Reports failures with a message, while preserving the last known favorite id set. |

### FavoritesListBloc States
| State | Description |
| --- | --- |
| `FavoritesListInitial` | Initial state when the page loads. |
| `FavoritesListLoading` | Loading state while fetching favorites. |
| `FavoritesListSuccess` | Success state with list of favorite Pokémon. |
| `FavoritesListError` | Error state with message and optional previous data. |

The `favoritePokemonIds` set allows the `FavoriteIconButton` to efficiently check individual Pokémon favorite status using `state.isFavorite(pokemonId)`.

## Repository Responsibilities

`FavoritePokemonRepository` implements comprehensive operations:

- `isFavorite(pokemonId)`: Queries `LocalPokemonService.getById` and returns the stored `isFavorite` flag (falls back to `false` on errors).
- `updateFavorite(pokemonId, isFavorite, pokemonName, imageURL)`: Directly persists the provided favorite state, inserting/updating when `isFavorite` is `true` and removing the Pokémon when `false`, while preserving the original `created` timestamp (and refreshing `updatedAt`).
- `getFavoritePokemonList()`: Fetches all locally stored Pokémon, filters those marked as favorite, and sorts by the most recent `updatedAt` timestamp.
- `getFavoritePokemonIds()`: Returns a set of favorite Pokémon IDs for efficient UI updates.

**Enhanced Data Model**: The repository now works with an enhanced `LocalPokemon` model that includes `id`, `name`, `imageURL`, `isFavorite`, `created`, and `updatedAt` timestamps for comprehensive favorite management.

**Data Consistency Enhancement**: The `FavoriteBloc` now always reads from persistence before toggling favorites to ensure data consistency. This prevents race conditions and ensures the UI always reflects the latest stored state.

Exception handling is conservative: read operations swallow errors and return safe defaults, while toggle operations rethrow to let the bloc decide how to surface the problem.

## Diagnostics & Support Workflow

- `LocalPokemonService` emits structured telemetry for persistence operations via `LocalPokemonTelemetry`. Each event captures status, record counts, duration, and any surfaced errors for support triage.

## Integration with the Navigation System

- The global `FavoriteBloc` and `FavoritesListBloc` are provided at the app level in `main.dart` using `BlocProvider`.
- `MainNavigationPage` provides bottom navigation between `PokemonListPage` and `FavoritesPage`.
- Favorite states are loaded when PokemonListBloc or PokemonDetailBloc loads data through their respective repositories.
- `PokemonDetailPage` integrates with global `FavoriteBloc` for favorite functionality in the detail view.
- Detail listener only reacts when `FavoriteSuccess.currentPokemonId` matches the displayed Pokémon, forwarding `state.toggledPokemonFavoriteStatus` to `PokemonDetailBloc`.
- `FavoritesPage` uses `FavoritesListBloc` to display and manage the favorites list with pull-to-refresh support.
- `FavoriteIconButton` widgets in each list tile and detail page connect to the global bloc and receive `isFavorite` as a prop.
- **Event-Driven Updates**: Page-level `BlocListener<FavoriteBloc>` components listen for favorite changes and propagate updates to other BLoCs.
- Tapping the heart emits `FavoriteToggled` with the specific Pokemon ID, name, and imageURL, which triggers the event-driven update flow.
- When an error occurs, the bloc emits `FavoriteError` with the previous favorite id set so the UI keeps the last known state.

**Enhanced Integration**: Complete favorites list page with navigation and detail page integration, focusing on comprehensive favorite management with event-driven state synchronization across all pages.

## Typical Usage

1. Provide the global `FavoriteBloc` and `FavoritesListBloc` at the app level using `BlocProvider`.
2. Use `MainNavigationPage` as the main entry point with bottom navigation.
3. Use `FavoriteIconButton` in list tiles and detail pages, passing the Pokemon ID, name, imageURL, and current `isFavorite` status.
4. The button automatically connects to the global bloc and handles state updates.
5. Use `BlocListener<FavoriteBloc>` at the page level to listen for favorite changes and propagate updates to other BLoCs, guarding detail updates by matching `state.currentPokemonId`.
6. Favorite states are loaded when PokemonListBloc or PokemonDetailBloc loads data through their respective repositories.
7. Navigate to `PokemonDetailPage` to view comprehensive Pokemon information with favorite functionality.

```dart
// In main.dart
BlocProvider(
  create: (context) => FavoriteBloc(),
  child: BlocProvider(
    create: (context) => FavoritesListBloc()
      ..add(const FavoritesListLoadRequested()),
    child: MaterialApp(
      home: const MainNavigationPage(),
    ),
  ),
)

// In PokemonListPage - Event-driven updates
BlocListener<FavoriteBloc, FavoriteState>(
  listener: (context, state) {
    if (state is FavoriteSuccess) {
      context.read<PokemonListBloc>().add(
        PokemonListFavoriteToggled(
          pokemonId: state.currentPokemonId!,
          isFavorite: state.toggledPokemonFavoriteStatus,
        ),
      );
    }
  },
  child: // PokemonListWidget
)

// In list tiles and detail pages
FavoriteIconButton(
  pokemonId: pokemon.id,
  pokemonName: pokemon.name,
  imageURL: pokemon.imageURL,
  isFavorite: pokemon.isFavorite,
)
```

The global bloc manages favorite toggle operations and emits events for other BLoCs to react. The favorites page provides a dedicated view of all saved favorites with pull-to-refresh support. The detail page provides comprehensive Pokemon information with integrated favorite functionality.

**Enhanced Usage**: Complete navigation system with dedicated favorites page and detail page integration, now backed by SQLite persistence.

## Testing Notes

- `test/favorite_bloc_test.dart` covers global state management, toggle success, toggle removal, and repository error propagation using Mockito to drive each branch.
- `test/services/local_pokemon_service_test.dart` exercises SQLite CRUD operations, timestamp normalization, and concurrency safety using the sqflite FFI driver.
- Mock or stub the repository when unit-testing the bloc to simulate favorite toggles and failure scenarios.
- Test the `FavoriteIconButton` widget with a global bloc provider to verify UI interactions in both list and detail pages.
- Test the `FavoritesPage` with `FavoritesListBloc` to verify favorites list display and refresh functionality.
- Test the `PokemonDetailPage` with `FavoriteIconButton` integration to verify favorite functionality in detail view.
- Add a listener test to ensure mismatched `currentPokemonId` values do not trigger `PokemonDetailFavoriteToggled`.
- For integration-style testing, provide a fake `LocalPokemonServiceSpec` implementation or configure `LocalPokemonDatabase.test` with `sqflite_common_ffi` so tests operate against an isolated SQLite file without touching on-device storage.
- Test navigation between Pokemon list, favorites list, and detail page to ensure proper state management.
