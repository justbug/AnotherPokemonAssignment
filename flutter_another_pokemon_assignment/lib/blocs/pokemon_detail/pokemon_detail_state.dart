import 'package:equatable/equatable.dart';
import '../../models/models.dart';

/// Pokemon 詳細資訊狀態
/// 定義 UI 的各種狀態
abstract class PokemonDetailState extends Equatable {
  const PokemonDetailState();

  @override
  List<Object> get props => [];
}

/// 初始狀態
/// 頁面剛載入時的狀態
class PokemonDetailInitial extends PokemonDetailState {
  const PokemonDetailInitial();
}

/// 載入中狀態
/// 載入 Pokemon 詳細資訊時的狀態
class PokemonDetailLoading extends PokemonDetailState {
  const PokemonDetailLoading();
}

/// 成功狀態
/// Pokemon 詳細資訊載入成功時的狀態
class PokemonDetailSuccess extends PokemonDetailState {
  final PokemonDetail detail;

  const PokemonDetailSuccess({required this.detail});

  @override
  List<Object> get props => [detail];
}

/// 錯誤狀態
/// 載入 Pokemon 詳細資訊失敗時的狀態
class PokemonDetailError extends PokemonDetailState {
  final String message;

  const PokemonDetailError({required this.message});

  @override
  List<Object> get props => [message];
}
