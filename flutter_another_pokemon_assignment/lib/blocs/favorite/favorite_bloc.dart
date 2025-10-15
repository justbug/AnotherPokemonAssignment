import 'package:flutter_bloc/flutter_bloc.dart';
import '../../repository/favorite_pokemon_repository.dart';
import 'favorite_event.dart';
import 'favorite_state.dart';

/// Favorite BLoC
/// 管理所有 Pokemon 最愛狀態的業務邏輯
class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final FavoritePokemonRepository _favoriteRepository;

  FavoriteBloc({
    FavoritePokemonRepository? favoriteRepository,
  }) : _favoriteRepository = favoriteRepository ?? FavoritePokemonRepository(),
       super(const FavoriteSuccess()) {
    on<FavoriteToggled>(_onFavoriteToggled);
    on<FavoriteLoadAllRequested>(_onLoadAllRequested);
  }

  /// 載入所有最愛狀態
  Future<void> _onLoadAllRequested(
    FavoriteLoadAllRequested event,
    Emitter<FavoriteState> emit,
  ) async {
    try {
      final favoriteStatus = await _favoriteRepository.getAllFavoriteStatus();
      emit(FavoriteSuccess(favoriteStatus: favoriteStatus));
    } catch (e) {
      emit(FavoriteError(
        message: '載入最愛狀態失敗: $e',
        favoriteStatus: const {},
      ));
    }
  }


  /// 處理切換最愛狀態事件
  Future<void> _onFavoriteToggled(
    FavoriteToggled event,
    Emitter<FavoriteState> emit,
  ) async {
    final currentStatus = Map<String, bool>.from(state.favoriteStatus);
    final currentFavorite = currentStatus[event.pokemonId] ?? false;
    
    try {
      // 使用 Repository 切換最愛狀態
      await _favoriteRepository.toggleFavorite(event.pokemonId, event.pokemonName, event.imageURL);
      
      // 更新狀態
      currentStatus[event.pokemonId] = !currentFavorite;
      emit(FavoriteSuccess(favoriteStatus: currentStatus));
    } catch (e) {
      emit(FavoriteError(
        message: '更新最愛狀態失敗: $e',
        favoriteStatus: currentStatus,
      ));
    }
  }
}
