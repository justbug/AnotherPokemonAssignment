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
       super(const FavoriteSuccess()) {
    on<FavoriteToggled>(_onFavoriteToggled);
    on<FavoriteLoadAllRequested>(_onLoadAllRequested);
  }

  /// Load all favorite states
  Future<void> _onLoadAllRequested(
    FavoriteLoadAllRequested event,
    Emitter<FavoriteState> emit,
  ) async {
    try {
      final favoriteStatus = await _favoriteRepository.getAllFavoriteStatus();
      emit(FavoriteSuccess(favoriteStatus: favoriteStatus));
    } catch (e) {
      emit(FavoriteError(
        message: 'Failed to load favorite states: $e',
        favoriteStatus: const {},
      ));
    }
  }


  /// Handle toggle favorite state event
  Future<void> _onFavoriteToggled(
    FavoriteToggled event,
    Emitter<FavoriteState> emit,
  ) async {
    final currentStatus = Map<String, bool>.from(state.favoriteStatus);
    final currentFavorite = currentStatus[event.pokemonId] ?? false;
    
    try {
      // Use Repository to toggle favorite state
      await _favoriteRepository.toggleFavorite(event.pokemonId, event.pokemonName, event.imageURL);
      
      // Update state
      currentStatus[event.pokemonId] = !currentFavorite;
      emit(FavoriteSuccess(favoriteStatus: currentStatus));
    } catch (e) {
      emit(FavoriteError(
        message: 'Failed to update favorite state: $e',
        favoriteStatus: currentStatus,
      ));
    }
  }
}
