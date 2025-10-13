import 'package:equatable/equatable.dart';

/// Favorite 狀態
abstract class FavoriteState extends Equatable {
  const FavoriteState();

  @override
  List<Object> get props => [];
}

/// 初始狀態
class FavoriteInitial extends FavoriteState {
  final bool isFavorite;

  const FavoriteInitial({required this.isFavorite});

  @override
  List<Object> get props => [isFavorite];
}


/// 成功狀態
class FavoriteSuccess extends FavoriteState {
  final bool isFavorite;

  const FavoriteSuccess({required this.isFavorite});

  @override
  List<Object> get props => [isFavorite];
}

/// 錯誤狀態
class FavoriteError extends FavoriteState {
  final String message;
  final bool isFavorite;

  const FavoriteError({
    required this.message,
    required this.isFavorite,
  });

  @override
  List<Object> get props => [message, isFavorite];
}
