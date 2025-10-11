// 使用範例：展示如何使用 PokemonService
import 'services/services.dart';

/// 使用範例
class PokemonServiceExample {
  final ListService _listService = ListService();
  final DetailService _detailService = DetailService();
  
  /// 取得 Pokemon 列表範例
  Future<void> fetchPokemonList() async {
    try {
      // 取得前 20 個 Pokemon
      final listEntity = await _listService.fetchList(limit: 20, offset: 0);
      
      print('取得 ${listEntity.results.length} 個 Pokemon:');
      for (final result in listEntity.results) {
        print('- ${result.name}: ${result.url}');
      }
      
      if (listEntity.next != null) {
        print('還有更多資料: ${listEntity.next}');
      }
    } on InvalidStatusCodeException catch (e) {
      print('HTTP 錯誤: ${e.statusCode}');
    } on NetworkException catch (e) {
      print('網路錯誤: ${e.message}');
    } on JsonParseException catch (e) {
      print('JSON 解析錯誤: ${e.message}');
    } catch (e) {
      print('未知錯誤: $e');
    }
  }
  
  /// 取得 Pokemon 詳細資訊範例
  Future<void> fetchPokemonDetail(String id) async {
    try {
      final detailEntity = await _detailService.fetchDetail(id);
      
      print('Pokemon #${detailEntity.id}:');
      print('- 重量: ${detailEntity.weight}');
      print('- 高度: ${detailEntity.height}');
      print('- 類型: ${detailEntity.types.map((t) => t.type.name).join(', ')}');
      
      if (detailEntity.sprites?.frontDefault != null) {
        print('- 圖片: ${detailEntity.sprites!.frontDefault}');
      }
    } on InvalidStatusCodeException catch (e) {
      print('HTTP 錯誤: ${e.statusCode}');
    } on NetworkException catch (e) {
      print('網路錯誤: ${e.message}');
    } on JsonParseException catch (e) {
      print('JSON 解析錯誤: ${e.message}');
    } catch (e) {
      print('未知錯誤: $e');
    }
  }
}
