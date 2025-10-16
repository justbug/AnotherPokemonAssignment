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
    final currentStatus = Map<String, bool>.from(state.favoriteStatus);
    final currentFavorite = currentStatus[event.pokemonId] ?? false;
    final newFavoriteStatus = !currentFavorite;
    
    try {
      // Use Repository to toggle favorite state
      await _favoriteRepository.toggleFavorite(event.pokemonId, event.pokemonName, event.imageURL);
      
      // Update state
      currentStatus[event.pokemonId] = newFavoriteStatus;
      emit(FavoriteSuccess(
        favoriteStatus: currentStatus,
        toggledPokemonId: event.pokemonId,
        toggledPokemonFavoriteStatus: newFavoriteStatus,
        currentPokemonId: event.pokemonId,
      ));
      
      // Emit a custom event to notify other BLoCs
      // This will be handled by the UI layer to update PokemonListBloc and PokemonDetailBloc
    } catch (e) {
      emit(FavoriteError(
        message: 'Failed to update favorite state: $e',
        favoriteStatus: currentStatus,
        currentPokemonId: event.pokemonId,
      ));
    }
  }
}
