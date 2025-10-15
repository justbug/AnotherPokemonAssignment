import 'package:flutter_bloc/flutter_bloc.dart';
import '../../repository/favorite_pokemon_repository.dart';
import '../../models/local_pokemon.dart';
import 'favorites_list_event.dart';
import 'favorites_list_state.dart';

/// Favorites List BLoC
/// 處理收藏列表的業務邏輯
class FavoritesListBloc extends Bloc<FavoritesListEvent, FavoritesListState> {
  final FavoritePokemonRepository _favoriteRepository;

  FavoritesListBloc({
    FavoritePokemonRepository? favoriteRepository,
  }) : _favoriteRepository = favoriteRepository ?? FavoritePokemonRepository(),
       super(const FavoritesListInitial()) {
    on<FavoritesListLoadRequested>(_onLoadRequested);
    on<FavoritesListRefreshRequested>(_onRefreshRequested);
  }

  /// 處理載入收藏列表事件
  Future<void> _onLoadRequested(
    FavoritesListLoadRequested event,
    Emitter<FavoritesListState> emit,
  ) async {
    await _loadFavoritePokemons(emit, showLoading: true);
  }

  /// 處理下拉刷新事件
  Future<void> _onRefreshRequested(
    FavoritesListRefreshRequested event,
    Emitter<FavoritesListState> emit,
  ) async {
    await _loadFavoritePokemons(emit, showLoading: false);
  }

  /// 載入收藏 Pokemon 列表的共用方法
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
        message: showLoading ? '載入收藏列表失敗: $e' : '刷新收藏列表失敗: $e',
        previousFavoritePokemons: _getCurrentFavoritePokemons(),
      ));
    }
  }

  /// 取得當前收藏 Pokemon 列表
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
