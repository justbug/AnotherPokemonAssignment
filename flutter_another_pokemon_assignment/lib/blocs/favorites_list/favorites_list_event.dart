import 'package:equatable/equatable.dart';

/// Favorites List 事件
/// 定義收藏列表頁面的用戶行為和系統觸發的事件
abstract class FavoritesListEvent extends Equatable {
  const FavoritesListEvent();

  @override
  List<Object> get props => [];
}

/// 初始載入事件
/// 對應首次進入收藏頁面時的載入行為
class FavoritesListLoadRequested extends FavoritesListEvent {
  const FavoritesListLoadRequested();
}

/// 下拉刷新事件
/// 對應用戶下拉刷新收藏列表的行為
class FavoritesListRefreshRequested extends FavoritesListEvent {
  const FavoritesListRefreshRequested();
}
