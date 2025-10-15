import 'package:freezed_annotation/freezed_annotation.dart';

part 'list_entity.freezed.dart';
part 'list_entity.g.dart';

/// Pokemon list entity
/// Corresponds to iOS ListEntity struct
@freezed
class ListEntity with _$ListEntity {
  const factory ListEntity({
    String? next,
    required List<ResultEntity> results,
  }) = _ListEntity;
  
  factory ListEntity.fromJson(Map<String, dynamic> json) => 
      _$ListEntityFromJson(json);
}

/// Pokemon result entity
/// Corresponds to iOS ListEntity.ResultEntity struct
@freezed
class ResultEntity with _$ResultEntity {
  const factory ResultEntity({
    required String name,
    required String url,
  }) = _ResultEntity;
  
  factory ResultEntity.fromJson(Map<String, dynamic> json) => 
      _$ResultEntityFromJson(json);
}
