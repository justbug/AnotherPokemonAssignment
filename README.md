# Another Pokemon Assignment

This repository contains an iOS app written in Swift that displays Pokémon data. The project includes networking, data storage, and a simple user interface with list and detail screens. This README provides a brief overview of the folder structure and key components.

## Project Structure

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

## Getting Started

1. Open `AnotherPokemonAssignment.xcodeproj` in Xcode.
2. Build and run the app to explore the list and detail screens.
3. Review the use cases and services to understand how network responses are decoded and passed to the UI.
4. Run the unit tests to verify core functionality.

## License

This project is licensed under the MIT License. See [LICENSE](LICENSE) for details.
