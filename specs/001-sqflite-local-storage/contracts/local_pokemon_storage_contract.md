# Local Pokemon Storage Contract

## Purpose
Defines the storage-layer operations that both Flutter and Swift clients must
support to maintain feature parity for local favorites persistence.

## Operations

### Upsert Favorite
- **Description**: Insert a new favorite or update existing record metadata.
- **Input**:
  ```json
  {
    "id": "0001",
    "name": "Bulbasaur",
    "imageURL": "https://img.pokemondb.net/artwork/bulbasaur.jpg",
    "isFavorite": true,
    "created": 1729468800000,
    "updatedAt": 1729468800000
  }
  ```
- **Behavior**:
  - Creates record when `id` not present.
  - Updates `updatedAt` while preserving `created` when record exists.
  - Returns success/failure with error payload on failure.

### Get Favorite By ID
- **Input**: Pokémon `id` string.
- **Output**: `LocalPokemon` JSON or `null` when not found.
- **Error Handling**: Raises persistence error with actionable message on IO
  failure.

### Get All Favorites
- **Output**: Array of `LocalPokemon` JSON ordered by `updatedAt` DESC.
- **Performance**: Must resolve in <100ms for ≤1000 records.

### Delete Favorite
- **Input**: Pokémon `id`.
- **Behavior**: Removes record; operation idempotent.

### Clear Favorites
- **Behavior**: Removes all records in a transaction; returns count cleared.
- **Usage**: QA/support tooling and automated recovery flows.

## Telemetry Fields
- `event`: `"favorites_persistence_result"` | `"favorites_clear_result"`
- `operation`: `"upsert"` | `"delete"` (for persistence event only)
- `status`: `"success"` | `"failure"`
- `pokemonId`: string (optional; persistence failures only)
- `clearedCount`: integer (optional; clear event only)
- `errorCode` / `errorMessage`: optional strings on failure
