# Favorite Feature Overview

This document describes the favorite functionality implemented by `FavoriteBloc`, the `FavoritePokemonRepository`, and the new local persistence stack.

## Architecture

- `FavoriteBloc` exposes an event-driven interface for toggling and loading the favorite status of a single Pokémon.
- `FavoritePokemonRepository` provides the persistence operations that the bloc depends on. It delegates storage to `LocalPokemonService`, which wraps `SharedPreferences`.
- `LocalPokemon` (generated via `freezed`/`json_serializable`) defines the persisted schema: `id`, `name`, and `isFavorite`.
- Data flow is unidirectional: UI ➜ bloc event ➜ repository ➜ local service ➜ bloc state ➜ UI.

## Events

| Event | Purpose |
| --- | --- |
| `FavoriteLoadRequested` | Load the current favorite status from persistence during bloc initialization. |
| `FavoriteToggled` | Flip the favorite flag for the current Pokémon. |

Both events are registered in the bloc constructor and `FavoriteLoadRequested` is dispatched immediately to bootstrap the state.

## States

Every bloc state carries the latest `isFavorite` flag so the UI can remain consistent even while loading or when an error occurs.

| State | Description |
| --- | --- |
| `FavoriteInitial` | Initial or reloaded status after a successful read. |
| `FavoriteLoading` | Emitted while the repository operation is pending. Keeps the previous favorite value. |
| `FavoriteSuccess` | Indicates the toggle completed successfully and exposes the updated flag. |
| `FavoriteError` | Reports failures with a message, while preserving the last known favorite value. |

## Repository Responsibilities

`FavoritePokemonRepository` implements three operations:

- `isFavorite(pokemonId)`: Queries `LocalPokemonService.getById` and returns the stored `isFavorite` flag (falls back to `false` on errors).
- `toggleFavorite(pokemonId, pokemonName)`: Reads the current state and either removes the Pokémon (if it was favorite) or inserts/updates it with `isFavorite = true`.
- `getAllFavorites()`: Fetches all locally stored Pokémon and filters those marked as favorite.

Exception handling is conservative: read operations swallow errors and return safe defaults, while toggle operations rethrow to let the bloc decide how to surface the problem.

## Integration with the List Screen

- `PokemonListWidget` wraps each list tile in its own `BlocProvider<FavoriteBloc>` instance.
- Favorite status is loaded during bloc construction so rows immediately reflect persisted hearts when scrolled back into view.
- Tapping the heart emits `FavoriteToggled`, which persists the inverse state through `FavoritePokemonRepository` and drives the icon update.
- When an error occurs, the bloc emits `FavoriteError` with the previous `isFavorite` so the UI keeps the last known state while showing a SnackBar elsewhere in the list flow.

## Typical Usage

1. Instantiate the bloc with the Pokémon identifier and display name.
2. Provide the bloc to the widget tree so the UI can listen to `FavoriteState`.
3. Trigger `FavoriteToggled` from UI interactions (e.g., tapping a heart icon).
4. React to `FavoriteLoading` to show progress indicators and to `FavoriteError` to notify the user.

```dart
final bloc = FavoriteBloc(
  pokemonId: '001',
  pokemonName: 'Bulbasaur',
);

IconButton(
  onPressed: () => bloc.add(const FavoriteToggled()),
  icon: BlocBuilder<FavoriteBloc, FavoriteState>(
    builder: (context, state) {
      final isFavorite = state is FavoriteInitial ||
              state is FavoriteSuccess ||
              state is FavoriteLoading ||
              state is FavoriteError
          ? state.isFavorite
          : false;

      return Icon(isFavorite ? Icons.favorite : Icons.favorite_border);
    },
  ),
);
```

The bloc schedules `FavoriteLoadRequested` during construction, so the first state update reflects the persisted flag without additional UI code.

## Testing Notes

- `test/favorite_bloc_test.dart` covers initialization, toggle success, toggle removal, and repository error propagation using Mockito to drive each branch.
- Mock or stub the repository when unit-testing the bloc to simulate favorite toggles and failure scenarios.
- For integration-style testing, provide a fake `LocalPokemonService` that writes to an in-memory map to avoid disk access from `SharedPreferences`.
