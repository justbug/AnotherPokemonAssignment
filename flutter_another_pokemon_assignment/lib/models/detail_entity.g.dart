// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detail_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DetailEntityImpl _$$DetailEntityImplFromJson(Map<String, dynamic> json) =>
    _$DetailEntityImpl(
      id: (json['id'] as num).toInt(),
      weight: (json['weight'] as num).toInt(),
      height: (json['height'] as num).toInt(),
      types: (json['types'] as List<dynamic>)
          .map((e) => TypesEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
      sprites: json['sprites'] == null
          ? null
          : SpriteEntity.fromJson(json['sprites'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$DetailEntityImplToJson(_$DetailEntityImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'weight': instance.weight,
      'height': instance.height,
      'types': instance.types,
      'sprites': instance.sprites,
    };

_$TypesEntityImpl _$$TypesEntityImplFromJson(Map<String, dynamic> json) =>
    _$TypesEntityImpl(
      type: TypeEntity.fromJson(json['type'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$TypesEntityImplToJson(_$TypesEntityImpl instance) =>
    <String, dynamic>{'type': instance.type};

_$TypeEntityImpl _$$TypeEntityImplFromJson(Map<String, dynamic> json) =>
    _$TypeEntityImpl(name: json['name'] as String);

Map<String, dynamic> _$$TypeEntityImplToJson(_$TypeEntityImpl instance) =>
    <String, dynamic>{'name': instance.name};

_$SpriteEntityImpl _$$SpriteEntityImplFromJson(Map<String, dynamic> json) =>
    _$SpriteEntityImpl(frontDefault: json['frontDefault'] as String?);

Map<String, dynamic> _$$SpriteEntityImplToJson(_$SpriteEntityImpl instance) =>
    <String, dynamic>{'frontDefault': instance.frontDefault};
