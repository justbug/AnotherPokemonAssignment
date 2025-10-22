# Another Pokemon Assignment

This repository contains both an iOS app written in Swift and a Flutter app that display Pokémon data. The project includes networking, data storage, and user interfaces with list and detail screens. This README provides a brief overview of the folder structure and key components.

## Project Structure

### iOS App (Swift)

The main Xcode project is stored under `AnotherPokemonAssignment`.
Important subfolders include:

- **AppDelegate.swift** and **SceneDelegate.swift** – standard iOS entry points for application lifecycle management and UI setup.
- **List** – implementation of the Pokémon list screen with view model and table view controller.
- **Detail** – components for displaying Pokémon details.
- **Favorite** – view model and view for managing favorite Pokémon.
- **Networking** – `APIClient`, `Request`, and `Response` classes for making HTTP requests.
- **Service** – wrappers around the networking layer to fetch data from the PokeAPI.
- **UseCase** – business logic that combines services and storage to supply data to view models.
- **Store** – `UserDefaultsStore` for persisting favorite Pokémon locally.
- **Extension** – small helper utilities used throughout the project.
- **Tests** – unit tests for services, use cases, and view models.

### Flutter App (Dart)

The Flutter client lives in `flutter_another_pokemon_assignment/` and now implements a comprehensive Pokémon list with complete favorite functionality and navigation.

- **Complete Features**: Implements the Pokémon list experience with pull-to-refresh, infinite scroll (30 items per page), error surfacing, per-row favorite toggles, and a dedicated favorites list page with navigation.
- **Enhanced State Management**: Uses `flutter_bloc` with `PokemonListBloc`, global `FavoriteBloc`, and `FavoritesListBloc` to manage all states centrally, keeping UI concerns isolated from data fetching and persistence.
- **Navigation Architecture**: Features `MainNavigationPage` with bottom navigation between Pokemon list and favorites list, using `IndexedStack` for state preservation.
- **Supabase Quiz Experience**: Adds a "Who's That Pokémon" silhouette quiz tab backed by Supabase edge functions, countdown reveal flow, and cached option sampling via `QuizBloc`.
- **Data layer**: `ListRepository` consolidates pagination, JSON decoding, and mapping into the `Pokemon` domain model, while `FavoritePokemonRepository` persists favorite selections through `LocalPokemonService` (now backed by SQLite via `sqflite`).
- **Networking**: `APIClient` and `RequestBuilder` wrap `http` to provide typed errors and shared request assembly that matches the iOS stack.
- **Tooling**: Introduces `freezed`, `json_serializable`, `equatable`, `mockito`, and `bloc_test` for model generation and testability.
- **Enhanced Data Model**: `LocalPokemon` model includes `id`, `name`, `imageURL`, `isFavorite`, `created`, and `updatedAt` timestamps for comprehensive favorite management and deterministic ordering.
- **Documentation**: See the dedicated walkthroughs in [`flutter_another_pokemon_assignment/README_POKEMON_LIST.md`](flutter_another_pokemon_assignment/README_POKEMON_LIST.md) and [`flutter_another_pokemon_assignment/README_POKEMON_FAVORITE.md`](flutter_another_pokemon_assignment/README_POKEMON_FAVORITE.md) for deeper dives into the features.

## Development Guidelines

This project includes comprehensive Cursor Rules for consistent development practices:

### Cursor Rules System
- **Project Structure**: Overall architecture and file organization guidelines
- **Flutter BLoC Pattern**: State management and BLoC implementation best practices
- **iOS MVVM Pattern**: Swift MVVM architecture and coding standards
- **Testing Guidelines**: Unit testing strategies for both platforms
- **Networking & API**: HTTP client patterns and error handling
- **Error Handling**: User experience and error recovery strategies
- **Flutter Dependencies**: Package management and code generation

These rules are automatically applied by Cursor to assist with:
- Code generation and refactoring
- Architecture pattern enforcement
- Testing strategy guidance
- Error handling implementation
- Dependency management

## Getting Started

### iOS App

1. Open `AnotherPokemonAssignment.xcodeproj` in Xcode.
2. Build and run the app to explore the list and detail screens.
3. Review the use cases and services to understand how network responses are decoded and passed to the UI.
4. Run the unit tests to verify core functionality.

### Flutter App

1. Navigate to `flutter_another_pokemon_assignment/` directory.
2. Run `flutter pub get` to install dependencies.
3. Run `flutter run` to start the app. The list screen dispatches `PokemonListLoadRequested` on launch and supports pull-to-refresh and load-more interactions.
4. Execute `flutter test` to run the bloc, repository, and service specifications that cover pagination, favorite toggling, and error handling paths.

## License

This project is licensed under the MIT License. See [LICENSE](LICENSE) for details.
