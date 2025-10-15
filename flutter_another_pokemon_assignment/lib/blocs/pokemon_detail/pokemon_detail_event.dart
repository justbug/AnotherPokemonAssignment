import 'package:equatable/equatable.dart';

/// Pokemon 詳細資訊事件
/// 定義用戶行為和系統觸發的事件
abstract class PokemonDetailEvent extends Equatable {
  const PokemonDetailEvent();

  @override
  List<Object> get props => [];
}

/// 載入 Pokemon 詳細資訊事件
/// 對應進入 Pokemon 詳細頁面時的載入行為
class PokemonDetailLoadRequested extends PokemonDetailEvent {
  final String pokemonId;

  const PokemonDetailLoadRequested({required this.pokemonId});

  @override
  List<Object> get props => [pokemonId];
}
