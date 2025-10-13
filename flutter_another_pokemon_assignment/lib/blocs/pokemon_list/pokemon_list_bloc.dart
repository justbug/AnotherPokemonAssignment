import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/models.dart';
import '../../services/services.dart';
import '../../repository/list_repository.dart';
import 'pokemon_list_event.dart';
import 'pokemon_list_state.dart';

/// Pokemon 列表 BLoC
/// 處理 Pokemon 列表的業務邏輯
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

  /// 處理初始載入事件
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
        message: '載入 Pokemon 列表失敗: $e',
      ));
    }
  }

  /// 處理下拉刷新事件
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
        message: '刷新 Pokemon 列表失敗: $e',
        previousPokemons: _getCurrentPokemons(),
      ));
    }
  }

  /// 處理載入更多事件
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
        message: '載入更多 Pokemon 失敗: $e',
        previousPokemons: currentState.pokemons,
      ));
    }
  }

  /// 取得當前 Pokemon 列表
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
