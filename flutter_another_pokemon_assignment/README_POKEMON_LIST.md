# Pokemon List Feature

## Feature Overview

This Flutter application delivers the Pokemon list feature with the BLoC pattern and supports:

- 📱 **Pagination**: Loads 30 Pokemon records per page
- 🔄 **Pull-to-Refresh**: Reloads the latest Pokemon list
- ⬆️ **Infinite Scroll**: Automatically fetches more data when scrolled to the bottom
- 🎯 **Error Handling**: Displays error messages through a SnackBar
- 🔄 **Loading States**: Shows loading indicators

## Architecture

### 1. Model Layer
- `Pokemon`: Pokemon data model that includes name and id
- `ListEntity`: Structure returned from the list API
- `ResultEntity`: Structure for a single Pokemon entry

### 2. Service Layer
- `PokemonService`: Core network service
- `DetailService`: Handles the Pokemon detail API
- `ListRepository`: Bridges API communication and domain logic, converting API data to domain models

### 3. BLoC Layer
- `PokemonListEvent`: Defines user-driven events
- `PokemonListState`: Defines UI states
- `PokemonListBloc`: Orchestrates state management and business logic

### 5. UI Layer
- `PokemonListPage`: Main list page
- Uses `BlocConsumer` to listen for state updates
- Uses `RefreshIndicator` to support pull-to-refresh
- Uses `ScrollController` to observe scroll events

## Key Behaviors

### Pagination
- Loads 30 items per request
- Uses the offset parameter to control pages
- Determines whether more data is available based on the number of items returned

### Pull-to-Refresh
- Resets offset to 0
- Reloads the first page
- Keeps the current list until the new data arrives

### Load More on Scroll
- Observes the scroll position and triggers when 200px from the bottom
- Appends new data to the existing list
- Updates the offset for the next page

### Error Handling
- Shows a SnackBar on network errors
- Keeps the current data so the user can continue browsing
- Provides a retry mechanism via pull-to-refresh

## How to Use

1. **Launch the App**: Automatically loads the first page of Pokemon
2. **Pull-to-Refresh**: Pull down at the top of the list to refresh
3. **Load More**: Scroll to the bottom to load additional Pokemon
4. **Retry on Error**: Pull to refresh again if an error occurs

## Technical Highlights

- ✅ **BLoC Pattern**: Clear state management
- ✅ **Separation of Concerns**: Layered Model-Service-BLoC-UI architecture
- ✅ **Resilient Error Handling**: Graceful recovery strategy
- ✅ **Loading State Coverage**: Comprehensive indicator management
- ✅ **Pagination Support**: Efficient incremental loading
- ✅ **User Experience**: Smooth scrolling and refresh interactions

## iOS Counterpart

This Flutter implementation mirrors the iOS architecture:
- `Pokemon` model aligns with the iOS `Pokemon` struct
- `ListRepository` corresponds to the iOS `ListUseCase` (which now incorporates the original `ListService`)
- The BLoC pattern parallels the MVVM + Combine approach on iOS
