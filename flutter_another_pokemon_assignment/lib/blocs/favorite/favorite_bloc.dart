import 'package:flutter_bloc/flutter_bloc.dart';
import '../../repository/favorite_pokemon_repository.dart';
import 'favorite_event.dart';
import 'favorite_state.dart';

/// Favorite BLoC
/// Manages business logic for all Pokemon favorite states
class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final FavoritePokemonRepository _favoriteRepository;

  FavoriteBloc({
    FavoritePokemonRepository? favoriteRepository,
  }) : _favoriteRepository = favoriteRepository ?? FavoritePokemonRepository(),
       super(const FavoriteInitial()) {
    on<FavoriteToggled>(_onFavoriteToggled);
  }

  /// Handle toggle favorite state event
  Future<void> _onFavoriteToggled(
    FavoriteToggled event,
    Emitter<FavoriteState> emit,
  ) async {
    // Always read from persistence to ensure we toggle against the latest data.
    final currentFavorites = await _favoriteRepository.getFavoritePokemonIds();
    final updatedFavorites = Set<String>.from(currentFavorites);
    final currentFavorite = currentFavorites.contains(event.pokemonId);
    final newFavoriteStatus = !currentFavorite;
    
    try {
      // Persist requested favorite state via repository
      await _favoriteRepository.updateFavorite(
        event.pokemonId,
        newFavoriteStatus,
        event.pokemonName,
        event.imageURL,
      );
      
      // Update state
      if (newFavoriteStatus) {
        updatedFavorites.add(event.pokemonId);
      } else {
        updatedFavorites.remove(event.pokemonId);
      }
      emit(FavoriteSuccess(
        favoritePokemonIds: updatedFavorites,
        toggledPokemonFavoriteStatus: newFavoriteStatus,
        currentPokemonId: event.pokemonId,
      ));
      
      // Emit a custom event to notify other BLoCs
      // This will be handled by the UI layer to update PokemonListBloc and PokemonDetailBloc
    } catch (e) {
      emit(FavoriteError(
        message: 'Failed to update favorite state: $e',
        favoritePokemonIds: currentFavorites,
        currentPokemonId: event.pokemonId,
      ));
    }
  }
}
