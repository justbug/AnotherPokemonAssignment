// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ListEntityImpl _$$ListEntityImplFromJson(Map<String, dynamic> json) =>
    _$ListEntityImpl(
      next: json['next'] as String?,
      results: (json['results'] as List<dynamic>)
          .map((e) => ResultEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$ListEntityImplToJson(_$ListEntityImpl instance) =>
    <String, dynamic>{'next': instance.next, 'results': instance.results};

_$ResultEntityImpl _$$ResultEntityImplFromJson(Map<String, dynamic> json) =>
    _$ResultEntityImpl(
      name: json['name'] as String,
      url: json['url'] as String,
    );

Map<String, dynamic> _$$ResultEntityImplToJson(_$ResultEntityImpl instance) =>
    <String, dynamic>{'name': instance.name, 'url': instance.url};
