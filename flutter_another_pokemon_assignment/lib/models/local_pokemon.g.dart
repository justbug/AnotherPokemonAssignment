// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_pokemon.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LocalPokemonImpl _$$LocalPokemonImplFromJson(Map<String, dynamic> json) =>
    _$LocalPokemonImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      imageURL: json['imageURL'] as String,
      isFavorite: json['isFavorite'] as bool,
      created: (json['created'] as num?)?.toInt() ?? 0,
      updatedAt: (json['updatedAt'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$LocalPokemonImplToJson(_$LocalPokemonImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'imageURL': instance.imageURL,
      'isFavorite': instance.isFavorite,
      'created': instance.created,
      'updatedAt': instance.updatedAt,
    };
