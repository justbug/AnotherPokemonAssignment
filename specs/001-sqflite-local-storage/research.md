# Phase 0 Research — SQLite Local Favorites Persistence

## Decision: SQLite schema & file management
- **Chosen Approach**: Store favorites in a single-table SQLite database
  `pokemon_favorites.db` located via `path_provider` in the application documents
  directory. Table columns mirror `LocalPokemon` fields (`id` PRIMARY KEY,
  `name`, `image_url`, `is_favorite`, `created`, `updated_at`).
- **Rationale**: Using a dedicated database file provides durability, atomic
  transactions, and straightforward upgrades via version numbers. The documents
  directory is backed up and accessible on both iOS and Android.
- **Alternatives Considered**:
  - *Keep SharedPreferences JSON blob*: Fast but brittle; cannot handle partial
    writes or complex queries. Rejected due to persistence principle.
  - *Use `hive`*: Offers simple key-value storage but adds an additional
    dependency and binary format; lacks native SQL migrations.

## Decision: Concurrency & thread safety
- **Chosen Approach**: Reuse a shared instance of `sqflite` database obtained via
  `openDatabase` with `singleInstance: true`, and wrap mutations in mutex-style
  `synchronized` blocks (using `synchronized` package) to avoid concurrent write
  conflicts.
- **Rationale**: sqflite executes on a background isolate but still requires
  sequential writes. Explicit synchronization guarantees consistent state even
  with rapid toggle actions.
- **Alternatives Considered**:
  - *Rely on sqflite internal queue*: Acceptable for many apps; rejected to keep
    deterministic ordering given heavy toggle usage from list scrolling.
  - *Custom isolate*: Overkill for the current dataset size.

## Decision: Diagnostics & telemetry
- **Chosen Approach**: Emit structured logs via existing analytics layer (or
  fallback to debug logger) indicating persistence success/failure, database
  version, and record counts. Capture errors in Sentry-equivalent if available.
- **Rationale**: Support analysts need traceability per requirement FR-006.
- **Alternatives Considered**:
  - *No logging beyond debug console*: Insufficient for support triage.
  - *Custom analytics schema*: Deferred until product analytics review; reuse
    existing logging infrastructure for now.
