import 'dart:convert';
import '../models/models.dart';
import '../services/core/pokemon_service.dart';
import '../services/core/service_helper.dart';
import 'package:flutter/foundation.dart';

/// Pokemon 列表倉庫規格介面
/// 對應 iOS 的 ListUseCaseSpec protocol
abstract class ListRepositorySpec {
  Future<List<Pokemon>> fetchList({int offset = 0});
}

/// Pokemon 列表倉庫
/// 對應 iOS 的 ListUseCase struct
class ListRepository implements ListRepositorySpec {
  static const int _limit = 30;
  static const String _path = 'pokemon';
  final PokemonService _pokemonService;

  ListRepository({PokemonService? pokemonService}) 
      : _pokemonService = pokemonService ?? PokemonService.instance;

  /// 取得 Pokemon 列表
  /// 對應 iOS 的 fetchList(offset: Int) 方法
  /// 
  /// [offset] 偏移量，預設為 0
  @override
  Future<List<Pokemon>> fetchList({int offset = 0}) async {
    try {
      final entity = await _fetchListEntity(limit: _limit, offset: offset);
      final models = _mapToModel(entity);
      return models;
    } catch (e) {
      // 重新拋出錯誤，保持錯誤類型
      rethrow;
    }
  }

  /// 取得 Pokemon 列表實體
  /// 整合原 ListService 的邏輯
  /// 
  /// [limit] 限制回傳數量
  /// [offset] 偏移量
  Future<ListEntity> _fetchListEntity({int? limit, int? offset}) async {
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

  /// 將 ListEntity 轉換為 Pokemon 模型列表
  /// 對應 iOS 的 mapToModel(_ entity: ListEntity) 方法
  List<Pokemon> _mapToModel(ListEntity entity) {
    return entity.results
        .map((result) => _createPokemonFromResult(result))
        .where((pokemon) => pokemon != null)
        .cast<Pokemon>()
        .toList();
  }

  /// 從 ResultEntity 創建 Pokemon 模型
  /// 對應 iOS 的 getID(urlString: String) 方法
  Pokemon? _createPokemonFromResult(ResultEntity result) {
    final id = _extractIdFromUrl(result.url);
    if (id == null) return null;
    
    return Pokemon(
      name: result.name,
      id: id,
    );
  }

  /// 從 URL 中提取 Pokemon ID
  /// 對應 iOS 的 getID(urlString: String) 方法
  String? _extractIdFromUrl(String urlString) {
    try {
      final uri = Uri.parse(urlString);
      final pathSegments = uri.pathSegments;
      
      if (pathSegments.isEmpty) {
        return null;
      }
      
      // Pokemon API URL 格式: /api/v2/pokemon/1/ 或 /api/v2/pokemon/1
      // 我們需要找到包含數字的 segment
      for (int i = pathSegments.length - 1; i >= 0; i--) {
        final segment = pathSegments[i];
        
        // 移除尾部斜線
        final cleanSegment = segment.endsWith('/') ? segment.substring(0, segment.length - 1) : segment;
        
        if (cleanSegment.isNotEmpty) {
          final id = int.tryParse(cleanSegment);
          if (id != null) {
            return id.toString();
          }
        }
      }
      
      return null;
    } catch (e) {
      debugPrint('Error extracting ID from URL: $e');
      return null;
    }
  }
}
