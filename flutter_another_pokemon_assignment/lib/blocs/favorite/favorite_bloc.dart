import 'package:flutter_bloc/flutter_bloc.dart';
import '../../repository/favorite_pokemon_repository.dart';
import 'favorite_event.dart';
import 'favorite_state.dart';

/// Favorite BLoC
/// 管理 Pokemon 最愛狀態的業務邏輯
class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final String pokemonId;
  final String pokemonName;
  final FavoritePokemonRepository _favoriteRepository;

  FavoriteBloc({
    required this.pokemonId,
    required this.pokemonName,
    FavoritePokemonRepository? favoriteRepository,
  }) : _favoriteRepository = favoriteRepository ?? FavoritePokemonRepository(),
       super(const FavoriteInitial(isFavorite: false)) {
    on<FavoriteToggled>(_onFavoriteToggled);
    on<FavoriteLoadRequested>(_onLoadRequested);
    add(const FavoriteLoadRequested());
  }

  /// 載入初始狀態
  Future<void> _onLoadRequested(
    FavoriteLoadRequested event,
    Emitter<FavoriteState> emit,
  ) async {
    try {
      final isFavorite = await _favoriteRepository.isFavorite(pokemonId);
      emit(FavoriteInitial(isFavorite: isFavorite));
    } catch (e) {
      emit(const FavoriteInitial(isFavorite: false));
    }
  }

  /// 處理切換最愛狀態事件
  Future<void> _onFavoriteToggled(
    FavoriteToggled event,
    Emitter<FavoriteState> emit,
  ) async {
    bool currentFavorite = state.isFavorite;
    try {
      final newFavorite = !state.isFavorite;
      
      // 使用 Repository 切換最愛狀態
      await _favoriteRepository.toggleFavorite(pokemonId, pokemonName);

      emit(FavoriteSuccess(isFavorite: newFavorite));
    } catch (e) {
      emit(FavoriteError(
        message: '更新最愛狀態失敗: $e',
        isFavorite: currentFavorite,
      ));
    }
  }
}
