import 'package:equatable/equatable.dart';

/// Favorite 狀態
abstract class FavoriteState extends Equatable {
  const FavoriteState();

  /// 取得所有 Pokemon 的最愛狀態
  Map<String, bool> get favoriteStatus;

  /// 檢查特定 Pokemon 是否為最愛
  bool isFavorite(String pokemonId) {
    return favoriteStatus[pokemonId] ?? false;
  }

  @override
  List<Object> get props => [favoriteStatus];
}



/// 成功狀態（包含初始狀態）
class FavoriteSuccess extends FavoriteState {
  @override
  final Map<String, bool> favoriteStatus;

  const FavoriteSuccess({this.favoriteStatus = const {}});

  @override
  List<Object> get props => [favoriteStatus];
}

/// 錯誤狀態
class FavoriteError extends FavoriteState {
  final String message;
  @override
  final Map<String, bool> favoriteStatus;

  const FavoriteError({
    required this.message,
    required this.favoriteStatus,
  });

  @override
  List<Object> get props => [message, favoriteStatus];
}
