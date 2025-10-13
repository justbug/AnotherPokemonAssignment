import 'package:equatable/equatable.dart';
import '../../models/models.dart';

/// Pokemon 列表狀態
/// 定義 UI 的各種狀態
abstract class PokemonListState extends Equatable {
  const PokemonListState();

  @override
  List<Object> get props => [];
}

/// 初始狀態
/// 頁面剛載入時的狀態
class PokemonListInitial extends PokemonListState {
  const PokemonListInitial();
}

/// 載入中狀態
/// 首次載入資料時的狀態
class PokemonListLoading extends PokemonListState {
  const PokemonListLoading();
}

/// 成功狀態
/// 資料載入成功時的狀態
class PokemonListSuccess extends PokemonListState {
  final List<Pokemon> pokemons;
  final bool hasMore;
  final int currentOffset;

  const PokemonListSuccess({
    required this.pokemons,
    required this.hasMore,
    required this.currentOffset,
  });

  @override
  List<Object> get props => [pokemons, hasMore, currentOffset];

  /// 複製並更新狀態
  PokemonListSuccess copyWith({
    List<Pokemon>? pokemons,
    bool? hasMore,
    int? currentOffset,
  }) {
    return PokemonListSuccess(
      pokemons: pokemons ?? this.pokemons,
      hasMore: hasMore ?? this.hasMore,
      currentOffset: currentOffset ?? this.currentOffset,
    );
  }
}

/// 載入更多中狀態
/// 載入更多資料時的狀態
class PokemonListLoadingMore extends PokemonListState {
  final List<Pokemon> pokemons;
  final bool hasMore;
  final int currentOffset;

  const PokemonListLoadingMore({
    required this.pokemons,
    required this.hasMore,
    required this.currentOffset,
  });

  @override
  List<Object> get props => [pokemons, hasMore, currentOffset];
}

/// 錯誤狀態
/// 載入失敗時的狀態
class PokemonListError extends PokemonListState {
  final String message;
  final List<Pokemon>? previousPokemons;

  const PokemonListError({
    required this.message,
    this.previousPokemons,
  });

  @override
  List<Object> get props => [message, previousPokemons ?? []];
}
