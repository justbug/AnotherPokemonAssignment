import 'dart:convert';

import '../models/list_entity.dart';
import 'core/pokemon_service.dart';
import 'core/service_helper.dart';

/// 取得 Pokemon 列表的規格介面
/// 對應 iOS 的 GetListSpec protocol
abstract class GetListSpec {
  Future<ListEntity> fetchList({int? limit, int? offset});
}

/// Pokemon 列表服務
/// 對應 iOS 的 ListService struct
class ListService implements GetListSpec {
  static const String _path = 'pokemon';
  final PokemonService _pokemonService;
  
  ListService({PokemonService? pokemonService}) 
      : _pokemonService = pokemonService ?? PokemonService.instance;
  
  /// 取得 Pokemon 列表
  /// 對應 iOS 的 fetchList(limit: Int?, offset: Int?) 方法
  /// 
  /// [limit] 限制回傳數量
  /// [offset] 偏移量
  @override
  Future<ListEntity> fetchList({int? limit, int? offset}) async {
    try {
      // 建構查詢參數，對應 iOS 的 query 建構邏輯
      final query = <String, String?>{
        if (limit != null) 'limit': limit.toStringOrNull,
        if (offset != null) 'offset': offset.toStringOrNull,
      };
      
      final response = await _pokemonService.fetch(
        _path,
        query: query,
      );
      
      try {
        final dynamic json = jsonDecode(response.body);
        if (json is! Map<String, dynamic>) {
          throw JsonParseException('Expected JSON object when parsing ListEntity');
        }
        return ListEntity.fromJson(json);
      } on FormatException catch (e) {
        throw JsonParseException('JSON parse error: ${e.message}');
      } on TypeError catch (e) {
        throw JsonParseException('JSON structure error: $e');
      }
    } catch (e) {
      // 重新拋出錯誤，保持錯誤類型
      rethrow;
    }
  }
}
