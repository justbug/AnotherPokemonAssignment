import 'package:equatable/equatable.dart';

/// Pokemon model
/// Corresponds to iOS Pokemon struct
class Pokemon extends Equatable {
  final String name;
  final String id;
  final String imageURL;

  const Pokemon({
    required this.name,
    required this.id,
    required this.imageURL,
  });

  @override
  List<Object> get props => [name, id, imageURL];

  @override
  String toString() => 'Pokemon(name: $name, id: $id, imageURL: $imageURL)';
}
