import 'package:freezed_annotation/freezed_annotation.dart';

part 'detail_entity.freezed.dart';
part 'detail_entity.g.dart';

/// Pokemon 詳細資訊實體
/// 對應 iOS 的 DetailEntity struct
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

/// Pokemon 類型實體
/// 對應 iOS 的 TypesEntity struct
@freezed
class TypesEntity with _$TypesEntity {
  const factory TypesEntity({
    required TypeEntity type,
  }) = _TypesEntity;
  
  factory TypesEntity.fromJson(Map<String, dynamic> json) => 
      _$TypesEntityFromJson(json);
}

/// 類型實體
/// 對應 iOS 的 TypesEntity.TypeEntity struct
@freezed
class TypeEntity with _$TypeEntity {
  const factory TypeEntity({
    required String name,
  }) = _TypeEntity;
  
  factory TypeEntity.fromJson(Map<String, dynamic> json) => 
      _$TypeEntityFromJson(json);
}

/// Pokemon 精靈圖實體
/// 對應 iOS 的 SpriteEntity struct
@freezed
class SpriteEntity with _$SpriteEntity {
  const factory SpriteEntity({
    String? frontDefault,
  }) = _SpriteEntity;
  
  factory SpriteEntity.fromJson(Map<String, dynamic> json) => 
      _$SpriteEntityFromJson(json);
}
