// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PokemonQuizEntryImpl _$$PokemonQuizEntryImplFromJson(
  Map<String, dynamic> json,
) => _$PokemonQuizEntryImpl(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
);

Map<String, dynamic> _$$PokemonQuizEntryImplToJson(
  _$PokemonQuizEntryImpl instance,
) => <String, dynamic>{'id': instance.id, 'name': instance.name};

_$PokemonQuizDetailImpl _$$PokemonQuizDetailImplFromJson(
  Map<String, dynamic> json,
) => _$PokemonQuizDetailImpl(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  silhouetteUrl: Uri.parse(json['silhouette_url'] as String),
  officialUrl: Uri.parse(json['official_url'] as String),
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
);

Map<String, dynamic> _$$PokemonQuizDetailImplToJson(
  _$PokemonQuizDetailImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'silhouette_url': instance.silhouetteUrl.toString(),
  'official_url': instance.officialUrl.toString(),
  'created_at': instance.createdAt?.toIso8601String(),
};
