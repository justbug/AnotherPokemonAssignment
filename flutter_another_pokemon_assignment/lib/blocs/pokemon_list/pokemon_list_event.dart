import 'package:equatable/equatable.dart';

/// Pokemon 列表事件
/// 定義用戶行為和系統觸發的事件
abstract class PokemonListEvent extends Equatable {
  const PokemonListEvent();

  @override
  List<Object> get props => [];
}

/// 初始載入事件
/// 對應首次進入頁面時的載入行為
class PokemonListLoadRequested extends PokemonListEvent {
  const PokemonListLoadRequested();
}

/// 下拉刷新事件
/// 對應用戶下拉刷新列表的行為
class PokemonListRefreshRequested extends PokemonListEvent {
  const PokemonListRefreshRequested();
}

/// 載入更多事件
/// 對應用戶滾動到底部載入更多資料的行為
class PokemonListLoadMoreRequested extends PokemonListEvent {
  const PokemonListLoadMoreRequested();
}
