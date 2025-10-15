# Favorite Feature Overview

This document describes the favorite functionality implemented by the global `FavoriteBloc`, the `FavoritePokemonRepository`, and the new local persistence stack.

## Architecture

- `FavoriteBloc` is now a global bloc that manages favorite status for all Pokémon in a centralized map.
- `FavoriteIconButton` widget provides per-item UI interactions that connect to the global bloc.
- `FavoritePokemonRepository` provides the persistence operations that the bloc depends on. It delegates storage to `LocalPokemonService`, which wraps `SharedPreferences`.
- `LocalPokemon` (generated via `freezed`/`json_serializable`) defines the persisted schema: `id`, `name`, and `isFavorite`.
- Data flow is unidirectional: UI ➜ bloc event ➜ repository ➜ local service ➜ bloc state ➜ UI.

## Events

| Event | Purpose |
| --- | --- |
| `FavoriteLoadAllRequested` | Load all favorite statuses from persistence during app initialization. |
| `FavoriteToggled` | Flip the favorite flag for a specific Pokémon (includes pokemonId and pokemonName). |

The global bloc is initialized in `main.dart` and `FavoriteLoadAllRequested` is dispatched from `PokemonListPage` to load all favorite states at startup.

## States

Every bloc state carries a `favoriteStatus` map (String -> bool) so the UI can remain consistent even while loading or when an error occurs.

| State | Description |
| --- | --- |
| `FavoriteSuccess` | Contains the complete favorite status map for all Pokémon. |
| `FavoriteError` | Reports failures with a message, while preserving the last known favorite status map. |

The `favoriteStatus` map allows the `FavoriteIconButton` to efficiently check individual Pokémon favorite status using `state.isFavorite(pokemonId)`.

## Repository Responsibilities

`FavoritePokemonRepository` implements three operations:

- `isFavorite(pokemonId)`: Queries `LocalPokemonService.getById` and returns the stored `isFavorite` flag (falls back to `false` on errors).
- `toggleFavorite(pokemonId, pokemonName)`: Reads the current state and either removes the Pokémon (if it was favorite) or inserts/updates it with `isFavorite = true`.
- `getAllFavorites()`: Fetches all locally stored Pokémon and filters those marked as favorite.

Exception handling is conservative: read operations swallow errors and return safe defaults, while toggle operations rethrow to let the bloc decide how to surface the problem.

## Integration with the List Screen

- The global `FavoriteBloc` is provided at the app level in `main.dart` using `MultiBlocProvider`.
- `PokemonListPage` dispatches `FavoriteLoadAllRequested` on initialization to load all favorite states.
- `FavoriteIconButton` widgets in each list tile connect to the global bloc and use `buildWhen` to optimize rebuilds.
- Tapping the heart emits `FavoriteToggled` with the specific Pokemon ID and name, which updates the global state map.
- When an error occurs, the bloc emits `FavoriteError` with the previous favorite status map so the UI keeps the last known state.

## Typical Usage

1. Provide the global `FavoriteBloc` at the app level using `MultiBlocProvider`.
2. Use `FavoriteIconButton` in list tiles, passing the Pokemon ID and name.
3. The button automatically connects to the global bloc and handles state updates.
4. Dispatch `FavoriteLoadAllRequested` on app startup to load all favorite states.

```dart
// In main.dart
MultiBlocProvider(
  providers: [
    BlocProvider(create: (context) => PokemonListBloc()..add(const PokemonListLoadRequested())),
    BlocProvider(create: (context) => FavoriteBloc()),
  ],
  child: MaterialApp(...),
)

// In PokemonListPage
WidgetsBinding.instance.addPostFrameCallback((_) {
  context.read<FavoriteBloc>().add(const FavoriteLoadAllRequested());
});

// In list tiles
FavoriteIconButton(
  pokemonId: pokemon.id,
  pokemonName: pokemon.name,
)
```

The global bloc loads all favorite states on startup, so all buttons immediately reflect the correct favorite status.

## Testing Notes

- `test/favorite_bloc_test.dart` covers global state management, toggle success, toggle removal, and repository error propagation using Mockito to drive each branch.
- Mock or stub the repository when unit-testing the bloc to simulate favorite toggles and failure scenarios.
- Test the `FavoriteIconButton` widget with a global bloc provider to verify UI interactions.
- For integration-style testing, provide a fake `LocalPokemonService` that writes to an in-memory map to avoid disk access from `SharedPreferences`.
