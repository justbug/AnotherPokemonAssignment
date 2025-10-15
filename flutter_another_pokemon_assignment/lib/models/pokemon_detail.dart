import 'package:equatable/equatable.dart';

/// Pokemon 詳細資訊模型
/// 對應 iOS 的 PokemonDetail struct
class PokemonDetail extends Equatable {
  final int id;
  final int weight;
  final int height;
  final List<String> types;
  final String? imageUrl;

  const PokemonDetail({
    required this.id,
    required this.weight,
    required this.height,
    required this.types,
    this.imageUrl,
  });

  @override
  List<Object?> get props => [id, weight, height, types, imageUrl];

  @override
  String toString() => 'PokemonDetail(id: $id, weight: $weight, height: $height, types: $types, imageUrl: $imageUrl)';
}
