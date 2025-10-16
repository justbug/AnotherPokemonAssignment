import 'package:equatable/equatable.dart';

/// Pokemon model
/// Corresponds to iOS Pokemon struct
class Pokemon extends Equatable {
  final String name;
  final String id;
  final String imageURL;
  final bool isFavorite;

  const Pokemon({
    required this.name,
    required this.id,
    required this.imageURL,
    this.isFavorite = false,
  });

  @override
  List<Object> get props => [name, id, imageURL, isFavorite];

  @override
  String toString() => 'Pokemon(name: $name, id: $id, imageURL: $imageURL, isFavorite: $isFavorite)';

  /// Create a copy with updated fields
  Pokemon copyWith({
    String? name,
    String? id,
    String? imageURL,
    bool? isFavorite,
  }) {
    return Pokemon(
      name: name ?? this.name,
      id: id ?? this.id,
      imageURL: imageURL ?? this.imageURL,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
