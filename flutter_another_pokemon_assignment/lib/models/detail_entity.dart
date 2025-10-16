import 'package:freezed_annotation/freezed_annotation.dart';

part 'detail_entity.freezed.dart';
part 'detail_entity.g.dart';

/// Pokemon detail entity
/// Corresponds to iOS DetailEntity struct
@freezed
class DetailEntity with _$DetailEntity {
  const factory DetailEntity({
    required int id,
    required int weight,
    required int height,
    required List<TypesEntity> types,
    SpriteEntity? sprites,
  }) = _DetailEntity;
  
  factory DetailEntity.fromJson(Map<String, dynamic> json) => 
      _$DetailEntityFromJson(json);
}

/// Pokemon type entity
/// Corresponds to iOS TypesEntity struct
@freezed
class TypesEntity with _$TypesEntity {
  const factory TypesEntity({
    required TypeEntity type,
  }) = _TypesEntity;
  
  factory TypesEntity.fromJson(Map<String, dynamic> json) => 
      _$TypesEntityFromJson(json);
}

/// Type entity
/// Corresponds to iOS TypesEntity.TypeEntity struct
@freezed
class TypeEntity with _$TypeEntity {
  const factory TypeEntity({
    required String name,
  }) = _TypeEntity;
  
  factory TypeEntity.fromJson(Map<String, dynamic> json) => 
      _$TypeEntityFromJson(json);
}

/// Pokemon sprite entity
/// Corresponds to iOS SpriteEntity struct
@freezed
class SpriteEntity with _$SpriteEntity {
  const factory SpriteEntity({
    String? frontDefault,
  }) = _SpriteEntity;
  
  factory SpriteEntity.fromJson(Map<String, dynamic> json) => 
      _$SpriteEntityFromJson(json);
}
