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
      
      return await _pokemonService.fetch<ListEntity>(
        _path,
        query: query,
      );
    } catch (e) {
      // 重新拋出錯誤，保持錯誤類型
      rethrow;
    }
  }
}
