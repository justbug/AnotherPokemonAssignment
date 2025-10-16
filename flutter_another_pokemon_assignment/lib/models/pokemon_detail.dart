import 'package:equatable/equatable.dart';

/// Pokemon detail model
/// Corresponds to iOS PokemonDetail struct
class PokemonDetail extends Equatable {
  final int id;
  final int weight;
  final int height;
  final List<String> types;
  final String? imageUrl;
  final bool isFavorite;

  const PokemonDetail({
    required this.id,
    required this.weight,
    required this.height,
    required this.types,
    this.imageUrl,
    this.isFavorite = false,
  });

  @override
  List<Object?> get props => [id, weight, height, types, imageUrl, isFavorite];

  @override
  String toString() => 'PokemonDetail(id: $id, weight: $weight, height: $height, types: $types, imageUrl: $imageUrl, isFavorite: $isFavorite)';

  /// Create a copy with updated fields
  PokemonDetail copyWith({
    int? id,
    int? weight,
    int? height,
    List<String>? types,
    String? imageUrl,
    bool? isFavorite,
  }) {
    return PokemonDetail(
      id: id ?? this.id,
      weight: weight ?? this.weight,
      height: height ?? this.height,
      types: types ?? this.types,
      imageUrl: imageUrl ?? this.imageUrl,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
