import 'package:freezed_annotation/freezed_annotation.dart';

part 'local_pokemon.freezed.dart';
part 'local_pokemon.g.dart';

/// 本地 Pokemon 模型
/// 用於儲存在本地資料庫中的 Pokemon 資料
@freezed
class LocalPokemon with _$LocalPokemon {
  const factory LocalPokemon({
    required String id,
    required String name,
    required String imageURL,
    required bool isFavorite,
    @Default(0) int created,
  }) = _LocalPokemon;

  /// 從 JSON Map 建立物件
  factory LocalPokemon.fromJson(Map<String, dynamic> json) =>
      _$LocalPokemonFromJson(json);
}
