# flutter_another_pokemon_assignment

A Flutter take-home that reproduces the Pokemon list experience from the iOS reference app.  
The feature branch introduces a full BLoC-driven presentation layer, a repository that mirrors the iOS `ListUseCase`, and a lightweight networking stack on top of `http`.

## Feature Highlights
- Pokemon list page backed by `PokemonListBloc` with initial load, pull-to-refresh, and infinite scroll (30 items per page).
- SnackBar-based error surfacing while preserving the previously fetched list so the user can retry.
- `ListRepository` that consolidates the former list service logic and maps API entities to the new `Pokemon` domain model.
- Shared networking layer (`APIClient`, `RequestBuilder`, and custom exceptions) that encapsulates PokeAPI access and status validation.
- Expanded test coverage to guarantee singleton wiring and service construction.

## Architecture Overview
- **Presentation**: `PokemonListPage` renders list states emitted by `PokemonListBloc`, leveraging `BlocConsumer` for UI updates and side-effects.
- **Domain / Repository**: `ListRepository` orchestrates pagination (`limit = 30`, `offset` increments) and converts `ListEntity` results into `Pokemon` models.
- **Services**: `PokemonService` (singleton) and `DetailService` sit on top of `APIClient`, with reusable helpers for query building, status-code validation, and error typing.
- **Models**: `ListEntity`, `ResultEntity`, and the new `Pokemon` value object (via `equatable`) are exported from `lib/models/models.dart` for ergonomic imports.
- **Tooling**: Added `flutter_bloc`, `http`, `equatable`, `freezed`/`json_serializable`, and build tooling in `pubspec.yaml`.

For a deeper dive into the list behaviour, see [`README_POKEMON_LIST.md`](README_POKEMON_LIST.md).

## Running the App
1. Install dependencies: `flutter pub get`
2. Launch the simulator/device you prefer.
3. Start the app: `flutter run`

The initial launch triggers `PokemonListLoadRequested`, fetching the first page from the PokeAPI.

## Tests
- Execute the suite with `flutter test` to validate singleton wiring and repository/service construction.

## Project Layout
- `lib/blocs/` – Feature BLoC, events, and states.
- `lib/repository/` – `ListRepository` implementation.
- `lib/networking/` – `APIClient` and `RequestBuilder`.
- `lib/services/` – Core Pokemon services and helpers.
- `lib/models/` – Domain models and generated entities.
