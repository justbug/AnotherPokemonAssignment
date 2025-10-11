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

### Flutter App (Dart) - TODO

The Flutter implementation is located under `flutter_another_pokemon_assignment/`.
Key components include:

- **lib/models/** – data models for Pokémon entities with Freezed code generation
- **lib/networking/** – API client for HTTP requests
- **lib/services/** – service layer for data fetching and business logic
- **lib/main.dart** – main application entry point
- **lib/example_usage.dart** – example usage of the Pokémon service
- **test/** – unit tests for services and widgets
- **pubspec.yaml** – Flutter dependencies and configuration

**Status: TODO** - The Flutter implementation is currently under development and not yet complete.

## Getting Started

### iOS App

1. Open `AnotherPokemonAssignment.xcodeproj` in Xcode.
2. Build and run the app to explore the list and detail screens.
3. Review the use cases and services to understand how network responses are decoded and passed to the UI.
4. Run the unit tests to verify core functionality.

### Flutter App - TODO

1. Navigate to `flutter_another_pokemon_assignment/` directory.
2. Run `flutter pub get` to install dependencies.
3. Run `flutter run` to start the app.
4. Review the service implementations and example usage.

**Note: Flutter implementation is currently incomplete and marked as TODO.**

## License

This project is licensed under the MIT License. See [LICENSE](LICENSE) for details.
