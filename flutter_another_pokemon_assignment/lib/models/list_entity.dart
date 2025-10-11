import 'package:freezed_annotation/freezed_annotation.dart';

part 'list_entity.freezed.dart';
part 'list_entity.g.dart';

/// Pokemon 列表實體
/// 對應 iOS 的 ListEntity struct
@freezed
class ListEntity with _$ListEntity {
  const factory ListEntity({
    String? next,
    required List<ResultEntity> results,
  }) = _ListEntity;
  
  factory ListEntity.fromJson(Map<String, dynamic> json) => 
      _$ListEntityFromJson(json);
}

/// Pokemon 結果實體
/// 對應 iOS 的 ListEntity.ResultEntity struct
@freezed
class ResultEntity with _$ResultEntity {
  const factory ResultEntity({
    required String name,
    required String url,
  }) = _ResultEntity;
  
  factory ResultEntity.fromJson(Map<String, dynamic> json) => 
      _$ResultEntityFromJson(json);
}
