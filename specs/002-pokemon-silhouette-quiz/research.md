# Research Summary – Pokemon Silhouette Quiz

## Decision: Use `supabase_flutter` for Function-bound HTTP calls
- **Rationale**: Aligns with request to leverage the Supabase package and keeps authentication headers, retries, and base URL management centralized. The `SupabaseClient.functions.invoke` API can target the existing edge function (`pokemon`) with minimal boilerplate.
- **Alternatives considered**: 
  - *Raw `http` calls*: already used in project but would duplicate Supabase auth/k headers management and contradict the explicit requirement.
  - *Custom service wrapper using `dio`*: heavier dependency footprint with little added value for two GET calls.

## Decision: Cache Pokemon list in memory after first fetch
- **Rationale**: Requirement states the list API should be called only once per page load. Storing the list in the quiz bloc/repository satisfies this while maintaining fast round resets.
- **Alternatives considered**:
  - *Persist to local database*: unnecessary for short-lived quiz session, adds migration/test scope.
  - *Refetch each round*: violates requirement and wastes network calls.

## Decision: Derive round content via deterministic shuffling
- **Rationale**: Using a secure random shuffle of the cached list ensures three unique Pokemon per round and guarantees the correct option is always present.
- **Alternatives considered**:
  - *Index-based math on sorted list*: more error-prone when total count changes.
  - *Server-side round generation*: requires backend work outside current scope.

## Decision: Continue using `cached_network_image` for silhouettes and official art
- **Rationale**: Package already included; handles caching, placeholders, and error widgets needed for graceful degradation (per spec edge cases).
- **Alternatives considered**:
  - *Raw `Image.network`*: lacks caching/error controls.
  - *Custom asset bundling*: contradicts dynamic API-driven content.

## Decision: Initialize Supabase client during Flutter app bootstrap
- **Rationale**: Ensures the quiz page (and any future Supabase consumers) share a single configured instance and avoid repeated initialization.
- **Alternatives considered**:
  - *Lazy init inside quiz bloc*: risks race conditions if multiple callers need Supabase simultaneously.
  - *Platform channel for credentials*: unnecessary since Flutter side can load keys from Dart `const` or env.
