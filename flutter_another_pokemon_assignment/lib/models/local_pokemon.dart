import 'package:freezed_annotation/freezed_annotation.dart';

part 'local_pokemon.freezed.dart';
part 'local_pokemon.g.dart';

/// Local Pokemon model
/// Used for storing Pokemon data in local database
@freezed
class LocalPokemon with _$LocalPokemon {
  const factory LocalPokemon({
    required String id,
    required String name,
    required String imageURL,
    required bool isFavorite,
    @Default(0) int created,
    @Default(0) int updatedAt,
  }) = _LocalPokemon;

  /// Create object from JSON Map
  factory LocalPokemon.fromJson(Map<String, dynamic> json) =>
      _$LocalPokemonFromJson(json);
}
