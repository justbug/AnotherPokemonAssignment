# Flutter Architecture Overview

This document describes the comprehensive architecture of the Flutter Pokemon app, including the enhanced BLoC pattern implementation, navigation system, and data management layers.

## Architecture Layers

### Presentation Layer
- **Pages**: `MainNavigationPage`, `PokemonListPage`, `FavoritesPage`, `PokemonDetailPage`
- **Widgets**: `PokemonListWidget`, `FavoriteIconButton`
- **Navigation**: Bottom navigation with `IndexedStack` for state preservation, detail page navigation

### State Management Layer (BLoC Pattern)
- **PokemonListBloc**: Manages Pokemon list loading, pagination, and refresh
- **PokemonDetailBloc**: Handles Pokemon detail loading and state management
- **FavoriteBloc**: Global bloc managing favorite states across all pages
- **FavoritesListBloc**: Handles favorites list display and management

### Domain Layer
- **Repositories**: `ListRepository`, `FavoritePokemonRepository`, `DetailRepository`
- **Models**: `Pokemon`, `ListEntity`, `DetailEntity`, `LocalPokemon`, `PokemonDetail`

### Data Layer
- **Services**: `PokemonService`, `DetailService`, `LocalPokemonService`
- **Networking**: `APIClient`, `RequestBuilder`
- **Storage**: `SharedPreferences` via `LocalPokemonService`

## BLoC Architecture Details

### PokemonListBloc
**Purpose**: Manages Pokemon list data loading and pagination with favorite integration
**Events**:
- `PokemonListLoadRequested`: Initial load or refresh
- `PokemonListLoadMoreRequested`: Load next page for infinite scroll
- `PokemonListFavoriteToggled`: Update favorite status for a specific Pokemon

**States**:
- `PokemonListInitial`: Initial state
- `PokemonListLoading`: Loading state with optional previous data
- `PokemonListSuccess`: Success state with Pokemon list (includes `isFavorite` property for each Pokemon)
- `PokemonListError`: Error state with message and previous data

### FavoriteBloc (Global)
**Purpose**: Manages favorite toggle operations and emits events for other BLoCs to react
**Events**:
- `FavoriteToggled`: Toggle favorite status for a specific Pokemon

**States**:
- `FavoriteInitial`: Initial state when the bloc is created
- `FavoriteSuccess`: Contains favorite status map, plus `toggledPokemonFavoriteStatus` for tracking changes
- `FavoriteError`: Error state with previous favorite status map

### FavoritesListBloc
**Purpose**: Manages favorites list page display and refresh
**Events**:
- `FavoritesListLoadRequested`: Load favorites list on page initialization
- `FavoritesListRefreshRequested`: Refresh favorites list on pull-to-refresh

**States**:
- `FavoritesListInitial`: Initial state
- `FavoritesListLoading`: Loading state
- `FavoritesListSuccess`: Success state with favorite Pokemon list
- `FavoritesListError`: Error state with message and previous data

### PokemonDetailBloc
**Purpose**: Manages Pokemon detail loading and state management with favorite integration
**Events**:
- `PokemonDetailLoadRequested`: Load Pokemon detail by ID
- `PokemonDetailFavoriteToggled`: Update favorite status for the current Pokemon

**States**:
- `PokemonDetailInitial`: Initial state
- `PokemonDetailLoading`: Loading state while fetching detail
- `PokemonDetailSuccess`: Success state with Pokemon detail data (includes `isFavorite` property)
- `PokemonDetailError`: Error state with error message

## Data Flow Architecture

### Pokemon List Flow
```mermaid
graph LR
    A[User Action] -->|Event| B[PokemonListBloc]
    B -->|Request| C[ListRepository]
    C -->|API Call| D[PokemonService]
    D -->|HTTP Request| E[APIClient]
    E -->|Request| F[API]
    
    F -->|Response| E
    E -->|Data| D
    D -->|Pokemon List| C
    C -->|Domain Models| B
    B -->|Load Favorites| G[FavoritePokemonRepository]
    G -->|Favorite Status| B
    B -->|PokemonListState| H[PokemonListWidget]
    H -->|UI Update| I[User Interface]
```

### Favorite Toggle Flow
```mermaid
graph LR
    A[User Tap] -->|Toggle Event| B[FavoriteIconButton]
    B -->|Event| C[FavoriteBloc]
    C -->|Toggle Request| D[FavoritePokemonRepository]
    D -->|Save/Load| E[LocalPokemonService]
    E -->|Persist| F[SharedPreferences]
    
    F -->|Saved Data| E
    E -->|LocalPokemon| D
    D -->|Favorite Status| C
    C -->|FavoriteState| G[BlocListener]
    G -->|Propagate Event| H[PokemonListBloc/PokemonDetailBloc]
    H -->|Update State| I[UI Components]
    I -->|Optimistic Update| J[User Interface]
```

### Favorites List Flow
```mermaid
graph LR
    A[Page Load] -->|Load Event| B[FavoritesListBloc]
    B -->|Get Favorites| C[FavoritePokemonRepository]
    C -->|Load Data| D[LocalPokemonService]
    D -->|Read| E[SharedPreferences]
    
    E -->|Favorites Data| D
    D -->|LocalPokemon List| C
    C -->|Filtered List| B
    B -->|FavoritesListState| F[FavoritesPage]
    F -->|UI Update| G[User Interface]
```

### Pokemon Detail Flow
```mermaid
graph LR
    A[List Tile Tap] -->|Navigation| B[PokemonDetailPage]
    B -->|Load Event| C[PokemonDetailBloc]
    C -->|Detail Request| D[DetailRepository]
    D -->|API Call| E[DetailService]
    E -->|HTTP Request| F[APIClient]
    F -->|Request| G[API]
    
    G -->|Detail Response| F
    F -->|Pokemon Detail| E
    E -->|Detail Data| D
    D -->|PokemonDetail Model| C
    C -->|Load Favorite| H[FavoritePokemonRepository]
    H -->|Favorite Status| C
    C -->|PokemonDetailState| I[PokemonDetailPage]
    I -->|UI Update| J[User Interface]
```

## Enhanced Data Model

### Pokemon Model
```dart
class Pokemon extends Equatable {
  final String name;
  final String id;
  final String imageURL;
  final bool isFavorite;      // NEW: Favorite status
}
```

### PokemonDetail Model
```dart
class PokemonDetail extends Equatable {
  final int id;
  final int weight;
  final int height;
  final List<String> types;
  final String? imageUrl;
  final bool isFavorite;      // NEW: Favorite status
}
```

### LocalPokemon Model
```dart
class LocalPokemon {
  final String id;
  final String name;
  final String imageURL;      // Image URL for display
  final bool isFavorite;
  final int created;          // Creation timestamp
}
```

**Enhancements**:
- Added `isFavorite` property to `Pokemon` and `PokemonDetail` models
- Added `copyWith` methods for immutable updates
- Models carry their own favorite status instead of querying global state
- Added `imageURL` for Pokemon image display
- Added `created` timestamp for sorting favorites by creation time
- Maintains backward compatibility with existing data

## Repository Pattern

### ListRepository
- Handles Pokemon list pagination and JSON parsing
- Maps API responses to domain models
- Manages error handling and data transformation

### DetailRepository
- Handles Pokemon detail fetching and data transformation
- Maps API responses to PokemonDetail domain model
- Manages error handling and data validation
- Provides abstraction for testing

### FavoritePokemonRepository
- Manages favorite Pokemon persistence
- Provides operations: `isFavorite`, `toggleFavorite`, `getFavoritePokemonList`, `getAllFavoriteStatus`
- Handles data filtering and sorting
- Implements conservative error handling

## Service Layer

### LocalPokemonService
- Wraps `SharedPreferences` for local storage
- Provides CRUD operations for `LocalPokemon` objects
- Handles JSON serialization/deserialization
- Implements service specification pattern for testing

### PokemonService & DetailService
- Share singleton `APIClient` for consistent request handling
- Use `RequestBuilder` for typed request assembly
- Implement error handling and response parsing

## Navigation Architecture

### MainNavigationPage
- Provides bottom navigation between Pokemon list and favorites
- Uses `IndexedStack` for state preservation
- Integrates with global BLoC providers

### PokemonDetailPage
- Displays comprehensive Pokemon information
- Integrates with global `FavoriteBloc` for favorite functionality
- Provides navigation back to list with state preservation
- Handles loading states and error scenarios

### State Preservation
- `IndexedStack` maintains page state during navigation
- BLoC states are preserved across page switches
- User interactions maintain context

## Testing Architecture

### BLoC Testing
- Uses `bloc_test` package for comprehensive BLoC testing
- Tests success/error branches for all BLoCs including PokemonDetailBloc
- Mocks dependencies using `mockito`
- Tests detail loading, error handling, and state transitions

### Repository Testing
- Tests data transformation and error handling
- Validates persistence operations
- Tests data filtering and sorting logic
- Tests DetailRepository API integration and data mapping

### Integration Testing
- Tests navigation between pages including detail page navigation
- Verifies state consistency across BLoCs
- Tests user interaction flows including detail page interactions
- Tests favorite functionality integration in detail page

## Event-Driven State Synchronization

### BlocListener Pattern
The app uses `BlocListener<FavoriteBloc>` at the page level to listen for favorite changes and propagate updates to other BLoCs:

```dart
BlocListener<FavoriteBloc, FavoriteState>(
  listener: (context, state) {
    if (state is FavoriteSuccess) {
      context.read<PokemonListBloc>().add(
        PokemonListFavoriteToggled(
          pokemonId: state.currentPokemonId!,
          isFavorite: state.toggledPokemonFavoriteStatus,
        ),
      );
    }
  },
  child: // UI Components
)
```

### Benefits
- **Precise Updates**: Only affected BLoCs receive updates
- **Performance**: Avoids unnecessary state synchronization
- **Maintainability**: Clear event flow and dependencies
- **Testability**: Easy to mock and test individual components

## Dependency Injection

### BLoC Providers
```dart
MultiBlocProvider(
  providers: [
    BlocProvider(create: (context) => FavoriteBloc()),
    BlocProvider(create: (context) => FavoritesListBloc()),
  ],
  child: MaterialApp(home: MainNavigationPage()),
)
```

### Repository Injection
- Repositories are injected into BLoCs via constructor
- Services are injected into repositories
- Enables easy testing with mock dependencies

## Error Handling Strategy

### BLoC Level
- Preserve previous state during errors
- Provide user-friendly error messages
- Implement retry mechanisms

### Repository Level
- Conservative error handling for read operations
- Rethrow errors for write operations
- Provide safe defaults for failed operations

### UI Level
- Show loading states during operations
- Display error messages via SnackBar
- Maintain UI consistency during errors

## Performance Considerations

### State Management
- Use `buildWhen` to optimize widget rebuilds
- Implement efficient state comparison
- Minimize unnecessary BLoC emissions

### Data Loading
- Implement pagination for large datasets
- Use optimistic updates for favorites
- Cache frequently accessed data

### Navigation
- Use `IndexedStack` for state preservation
- Avoid rebuilding pages during navigation
- Implement efficient page switching

## Future Architecture Considerations

### Scalability
- Consider implementing a more complex navigation stack
- Add support for deep linking
- Implement advanced state management patterns

### Testing
- Add integration tests for complete user flows
- Implement UI testing for critical paths
- Add performance testing for large datasets

### Features
- Add search functionality across pages
- Implement offline support for Pokemon details
- Add push notifications for favorites
- Enhance detail page with additional Pokemon information
- Add Pokemon comparison functionality

This architecture provides a solid foundation for the Pokemon app while maintaining clean separation of concerns, excellent testability, and great user experience.
