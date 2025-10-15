import 'package:equatable/equatable.dart';

/// Favorite 事件
abstract class FavoriteEvent extends Equatable {
  const FavoriteEvent();

  @override
  List<Object> get props => [];
}

/// 載入初始狀態事件
class FavoriteLoadRequested extends FavoriteEvent {
  const FavoriteLoadRequested();
}

/// 切換最愛狀態事件
class FavoriteToggled extends FavoriteEvent {
  const FavoriteToggled();
}
