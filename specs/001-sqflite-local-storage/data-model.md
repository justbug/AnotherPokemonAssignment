# Data Model — SQLite Local Favorites Persistence

## LocalPokemon
- **Description**: Represents one Pokémon favorited locally by the user.
- **Fields**:
  - `id` (String, primary key): Pokémon identifier derived from API list.
  - `name` (String): Display name used across list/detail UIs.
  - `imageURL` (String): Remote image source; cached elsewhere.
  - `isFavorite` (bool): Flag indicating favorite status (MUST remain true for
    persisted entries; toggling off deletes or updates record).
  - `created` (int): Unix epoch (milliseconds) when favorite was first stored.
  - `updatedAt` (int): Unix epoch (milliseconds) for last modification — new DB
    column to support auditing (defaults to `created` on insert).
- **Validation Rules**:
  - `id`, `name`, `imageURL` cannot be empty.
  - `created`/`updatedAt` MUST be non-negative.
  - `updatedAt` MUST be ≥ `created`.
- **Relationships**: None (single-table storage); ties to remote Pokémon data via
  shared `id`.
