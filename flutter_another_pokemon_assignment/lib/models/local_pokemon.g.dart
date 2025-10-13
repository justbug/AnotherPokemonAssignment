// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_pokemon.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LocalPokemonImpl _$$LocalPokemonImplFromJson(Map<String, dynamic> json) =>
    _$LocalPokemonImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      isFavorite: json['isFavorite'] as bool,
    );

Map<String, dynamic> _$$LocalPokemonImplToJson(_$LocalPokemonImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'isFavorite': instance.isFavorite,
    };
