import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/models.dart';
import '../../services/services.dart';
import '../../repository/list_repository.dart';
import 'pokemon_list_event.dart';
import 'pokemon_list_state.dart';

/// Pokemon list BLoC
/// Handles Pokemon list business logic
class PokemonListBloc extends Bloc<PokemonListEvent, PokemonListState> {
  final ListRepositorySpec _listRepository;
  static const int _limit = 30;

  PokemonListBloc({ListRepositorySpec? listRepository}) 
      : _listRepository = listRepository ?? ListRepository(),
        super(const PokemonListInitial()) {
    on<PokemonListLoadRequested>(_onLoadRequested);
    on<PokemonListRefreshRequested>(_onRefreshRequested);
    on<PokemonListLoadMoreRequested>(_onLoadMoreRequested);
  }

  /// Handle initial load event
  Future<void> _onLoadRequested(
    PokemonListLoadRequested event,
    Emitter<PokemonListState> emit,
  ) async {
    emit(const PokemonListLoading());
    
    try {
      final pokemons = await _listRepository.fetchList(offset: 0);
      emit(PokemonListSuccess(
        pokemons: pokemons,
        hasMore: pokemons.length == _limit,
        currentOffset: pokemons.length,
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
      emit(PokemonListSuccess(
        pokemons: pokemons,
        hasMore: pokemons.length == _limit,
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
      
      final updatedPokemons = [
        ...currentState.pokemons,
        ...newPokemons,
      ];
      
      emit(PokemonListSuccess(
        pokemons: updatedPokemons,
        hasMore: newPokemons.length == _limit,
        currentOffset: currentState.currentOffset + _limit,
      ));
    } catch (e) {
      emit(PokemonListError(
        message: 'Failed to load more Pokemon: $e',
        previousPokemons: currentState.pokemons,
      ));
    }
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
