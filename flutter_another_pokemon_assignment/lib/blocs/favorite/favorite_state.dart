import 'package:equatable/equatable.dart';

/// Favorite 狀態
abstract class FavoriteState extends Equatable {
  const FavoriteState();
  
  /// 是否為收藏狀態
  bool get isFavorite;
  
  @override
  List<Object> get props => [isFavorite];
}

/// 初始狀態
class FavoriteInitial extends FavoriteState {
  final bool _isFavorite;

  const FavoriteInitial({required bool isFavorite}) : _isFavorite = isFavorite;

  @override
  bool get isFavorite => _isFavorite;
}


/// 成功狀態
class FavoriteSuccess extends FavoriteState {
  final bool _isFavorite;

  const FavoriteSuccess({required bool isFavorite}) : _isFavorite = isFavorite;

  @override
  bool get isFavorite => _isFavorite;
}

/// 錯誤狀態
class FavoriteError extends FavoriteState {
  final String message;
  final bool _isFavorite;

  const FavoriteError({
    required this.message,
    required bool isFavorite,
  }) : _isFavorite = isFavorite;

  @override
  bool get isFavorite => _isFavorite;

  @override
  List<Object> get props => [message, isFavorite];
}
