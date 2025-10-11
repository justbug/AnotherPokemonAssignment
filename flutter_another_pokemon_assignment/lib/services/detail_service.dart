import 'dart:convert';

import '../models/detail_entity.dart';
import 'core/pokemon_service.dart';
import 'core/service_helper.dart';

/// 取得 Pokemon 詳細資訊的規格介面
/// 對應 iOS 的 DetailServiceSpec protocol
abstract class DetailServiceSpec {
  Future<DetailEntity> fetchDetail(String id);
}

/// Pokemon 詳細資訊服務
/// 對應 iOS 的 DetailService struct
class DetailService implements DetailServiceSpec {
  final PokemonService _pokemonService;
  
  DetailService({PokemonService? pokemonService}) 
      : _pokemonService = pokemonService ?? PokemonService.instance;
  
  /// 取得 Pokemon 詳細資訊
  /// 對應 iOS 的 fetchDetail(id: String) 方法
  /// 
  /// [id] Pokemon ID
  @override
  Future<DetailEntity> fetchDetail(String id) async {
    try {
      final path = 'pokemon/$id';
      
      final response = await _pokemonService.fetch(
        path,
        query: null,
      );
      
      try {
        final dynamic json = jsonDecode(response.body);
        if (json is! Map<String, dynamic>) {
          throw JsonParseException('Expected JSON object when parsing DetailEntity');
        }
        return DetailEntity.fromJson(json);
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
