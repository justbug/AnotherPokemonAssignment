import 'package:equatable/equatable.dart';

/// Pokemon detail data model
/// Contains detailed information about a Pokemon
class PokemonDetailData extends Equatable {
  final int id;
  final int weight;
  final int height;
  final List<String> types;

  const PokemonDetailData({
    required this.id,
    required this.weight,
    required this.height,
    required this.types,
  });

  @override
  List<Object> get props => [id, weight, height, types];

  @override
  String toString() => 'PokemonDetailData(id: $id, weight: $weight, height: $height, types: $types)';

  /// Create a copy with updated fields
  PokemonDetailData copyWith({
    int? id,
    int? weight,
    int? height,
    List<String>? types,
  }) {
    return PokemonDetailData(
      id: id ?? this.id,
      weight: weight ?? this.weight,
      height: height ?? this.height,
      types: types ?? this.types,
    );
  }
}

/// Pokemon model
/// Corresponds to iOS Pokemon struct
class Pokemon extends Equatable {
  final String name;
  final String id;
  final String imageURL;
  final bool isFavorite;
  final PokemonDetailData? detail;

  const Pokemon({
    required this.name,
    required this.id,
    required this.imageURL,
    this.isFavorite = false,
    this.detail,
  });

  @override
  List<Object?> get props => [name, id, imageURL, isFavorite, detail];

  @override
  String toString() => 'Pokemon(name: $name, id: $id, imageURL: $imageURL, isFavorite: $isFavorite, detail: $detail)';

  /// Create a copy with updated fields
  Pokemon copyWith({
    String? name,
    String? id,
    String? imageURL,
    bool? isFavorite,
    PokemonDetailData? detail,
  }) {
    return Pokemon(
      name: name ?? this.name,
      id: id ?? this.id,
      imageURL: imageURL ?? this.imageURL,
      isFavorite: isFavorite ?? this.isFavorite,
      detail: detail ?? this.detail,
    );
  }
}
