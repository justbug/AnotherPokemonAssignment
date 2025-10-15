import 'package:equatable/equatable.dart';
import '../../models/local_pokemon.dart';

/// Favorites List 狀態
/// 定義收藏列表頁面的各種狀態
abstract class FavoritesListState extends Equatable {
  const FavoritesListState();

  @override
  List<Object> get props => [];
}

/// 初始狀態
/// 頁面剛載入時的狀態
class FavoritesListInitial extends FavoritesListState {
  const FavoritesListInitial();
}

/// 載入中狀態
/// 載入收藏列表資料時的狀態
class FavoritesListLoading extends FavoritesListState {
  const FavoritesListLoading();
}

/// 成功狀態
/// 收藏列表載入成功時的狀態
class FavoritesListSuccess extends FavoritesListState {
  final List<LocalPokemon> favoritePokemons;

  const FavoritesListSuccess({
    required this.favoritePokemons,
  });

  @override
  List<Object> get props => [favoritePokemons];

  /// 複製並更新狀態
  FavoritesListSuccess copyWith({
    List<LocalPokemon>? favoritePokemons,
  }) {
    return FavoritesListSuccess(
      favoritePokemons: favoritePokemons ?? this.favoritePokemons,
    );
  }
}

/// 錯誤狀態
/// 載入收藏列表失敗時的狀態
class FavoritesListError extends FavoritesListState {
  final String message;
  final List<LocalPokemon>? previousFavoritePokemons;

  const FavoritesListError({
    required this.message,
    this.previousFavoritePokemons,
  });

  @override
  List<Object> get props => [message, previousFavoritePokemons ?? []];
}
