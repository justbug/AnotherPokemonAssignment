import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/models.dart';
import '../../services/services.dart';
import 'pokemon_list_event.dart';
import 'pokemon_list_state.dart';

/// Pokemon list BLoC
/// Handles Pokemon list business logic
class PokemonListBloc extends Bloc<PokemonListEvent, PokemonListState> {
  final ListRepositorySpec _listRepository;
  final FavoritePokemonRepository _favoriteRepository;
  static const int _limit = 30;

  PokemonListBloc({
    ListRepositorySpec? listRepository,
    FavoritePokemonRepository? favoriteRepository,
  }) : _listRepository = listRepository ?? ListRepository(),
       _favoriteRepository = favoriteRepository ?? FavoritePokemonRepository(),
        super(const PokemonListInitial()) {
    on<PokemonListLoadRequested>(_onLoadRequested);
    on<PokemonListRefreshRequested>(_onRefreshRequested);
    on<PokemonListLoadMoreRequested>(_onLoadMoreRequested);
    on<PokemonListFavoriteToggled>(_onFavoriteToggled);
  }

  /// Handle initial load event
  Future<void> _onLoadRequested(
    PokemonListLoadRequested event,
    Emitter<PokemonListState> emit,
  ) async {
    emit(const PokemonListLoading());
    
    try {
      final pokemons = await _listRepository.fetchList(offset: 0);
      final pokemonsWithFavorite = await _loadPokemonsWithFavoriteStatus(pokemons);
      
      emit(PokemonListSuccess(
        pokemons: pokemonsWithFavorite,
        hasMore: pokemonsWithFavorite.length == _limit,
        currentOffset: pokemonsWithFavorite.length,
      ));
    } catch (e) {
      emit(PokemonListError(
        message: 'Failed to load Pokemon list: $e',
      ));
    }
  }

  /// Handle pull-to-refresh event
  Future<void> _onRefreshRequested(
    PokemonListRefreshRequested event,
    Emitter<PokemonListState> emit,
  ) async {
    try {
      final pokemons = await _listRepository.fetchList(offset: 0);
      final pokemonsWithFavorite = await _loadPokemonsWithFavoriteStatus(pokemons);
      
      emit(PokemonListSuccess(
        pokemons: pokemonsWithFavorite,
        hasMore: pokemonsWithFavorite.length == _limit,
        currentOffset: _limit,
      ));
    } catch (e) {
      emit(PokemonListError(
        message: 'Failed to refresh Pokemon list: $e',
        previousPokemons: _getCurrentPokemons(),
      ));
    }
  }

  /// Handle load more event
  Future<void> _onLoadMoreRequested(
    PokemonListLoadMoreRequested event,
    Emitter<PokemonListState> emit,
  ) async {
    final currentState = state;
    if (currentState is! PokemonListSuccess || !currentState.hasMore) {
      return;
    }

    emit(PokemonListLoadingMore(
      pokemons: currentState.pokemons,
      hasMore: currentState.hasMore,
      currentOffset: currentState.currentOffset,
    ));

    try {
      final newPokemons = await _listRepository.fetchList(
        offset: currentState.currentOffset,
      );
      
      final newPokemonsWithFavorite = await _loadPokemonsWithFavoriteStatus(newPokemons);
      
      final updatedPokemons = [
        ...currentState.pokemons,
        ...newPokemonsWithFavorite,
      ];
      
      emit(PokemonListSuccess(
        pokemons: updatedPokemons,
        hasMore: newPokemonsWithFavorite.length == _limit,
        currentOffset: currentState.currentOffset + _limit,
      ));
    } catch (e) {
      emit(PokemonListError(
        message: 'Failed to load more Pokemon: $e',
        previousPokemons: currentState.pokemons,
      ));
    }
  }

  /// Handle favorite toggle event
  Future<void> _onFavoriteToggled(
    PokemonListFavoriteToggled event,
    Emitter<PokemonListState> emit,
  ) async {
    final currentState = state;
    if (currentState is! PokemonListSuccess) {
      return;
    }

    final updatedPokemons = currentState.pokemons.map((pokemon) {
      if (pokemon.id == event.pokemonId) {
        return pokemon.copyWith(isFavorite: event.isFavorite);
      }
      return pokemon;
    }).toList();

    emit(PokemonListSuccess(
      pokemons: updatedPokemons,
      hasMore: currentState.hasMore,
      currentOffset: currentState.currentOffset,
    ));
  }

  /// Load favorite status and set isFavorite for Pokemon list
  Future<List<Pokemon>> _loadPokemonsWithFavoriteStatus(List<Pokemon> pokemons) async {
    final favoriteIds = await _favoriteRepository.getFavoritePokemonIds();
    return pokemons.map((pokemon) {
      return pokemon.copyWith(
        isFavorite: favoriteIds.contains(pokemon.id),
      );
    }).toList();
  }

  /// Get current Pokemon list
  List<Pokemon> _getCurrentPokemons() {
    final currentState = state;
    if (currentState is PokemonListSuccess) {
      return currentState.pokemons;
    } else if (currentState is PokemonListLoadingMore) {
      return currentState.pokemons;
    } else if (currentState is PokemonListError) {
      return currentState.previousPokemons ?? [];
    }
    return [];
  }
}
