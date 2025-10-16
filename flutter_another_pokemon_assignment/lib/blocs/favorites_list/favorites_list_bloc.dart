import 'package:flutter_bloc/flutter_bloc.dart';
import '../../repository/favorite_pokemon_repository.dart';
import '../../models/local_pokemon.dart';
import 'favorites_list_event.dart';
import 'favorites_list_state.dart';

/// Favorites List BLoC
/// Handles favorites list business logic
class FavoritesListBloc extends Bloc<FavoritesListEvent, FavoritesListState> {
  final FavoritePokemonRepository _favoriteRepository;

  FavoritesListBloc({
    FavoritePokemonRepository? favoriteRepository,
  }) : _favoriteRepository = favoriteRepository ?? FavoritePokemonRepository(),
       super(const FavoritesListInitial()) {
    on<FavoritesListLoadRequested>(_onLoadRequested);
    on<FavoritesListRefreshRequested>(_onRefreshRequested);
  }

  /// Handle load favorites list event
  Future<void> _onLoadRequested(
    FavoritesListLoadRequested event,
    Emitter<FavoritesListState> emit,
  ) async {
    await _loadFavoritePokemons(emit, showLoading: true);
  }

  /// Handle pull-to-refresh event
  Future<void> _onRefreshRequested(
    FavoritesListRefreshRequested event,
    Emitter<FavoritesListState> emit,
  ) async {
    await _loadFavoritePokemons(emit, showLoading: false);
  }

  /// Common method to load favorite Pokemon list
  Future<void> _loadFavoritePokemons(
    Emitter<FavoritesListState> emit, {
    required bool showLoading,
  }) async {
    if (showLoading) {
      emit(const FavoritesListLoading());
    }
    
    try {
      final favoritePokemons = await _favoriteRepository.getFavoritePokemonList();
      emit(FavoritesListSuccess(favoritePokemons: favoritePokemons));
    } catch (e) {
      emit(FavoritesListError(
        message: showLoading ? 'Failed to load favorites list: $e' : 'Failed to refresh favorites list: $e',
        previousFavoritePokemons: _getCurrentFavoritePokemons(),
      ));
    }
  }

  /// Get current favorite Pokemon list
  List<LocalPokemon> _getCurrentFavoritePokemons() {
    final currentState = state;
    if (currentState is FavoritesListSuccess) {
      return currentState.favoritePokemons;
    } else if (currentState is FavoritesListError) {
      return currentState.previousFavoritePokemons ?? [];
    }
    return [];
  }
}
