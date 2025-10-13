// 使用範例：展示如何使用 PokemonService
import 'package:flutter/foundation.dart';
import 'services/services.dart';

/// 使用範例
class PokemonServiceExample {
  final ListRepository _listRepository = ListRepository();
  final DetailService _detailService = DetailService();
  
  /// 取得 Pokemon 列表範例
  Future<void> fetchPokemonList() async {
    try {
      // 取得前 20 個 Pokemon
      final pokemons = await _listRepository.fetchList(offset: 0);
      
      debugPrint('取得 ${pokemons.length} 個 Pokemon:');
      for (final pokemon in pokemons) {
        debugPrint('- ${pokemon.name}: ID ${pokemon.id}');
      }
    } on InvalidStatusCodeException catch (e) {
      debugPrint('HTTP 錯誤: ${e.statusCode}');
    } on NetworkException catch (e) {
      debugPrint('網路錯誤: ${e.message}');
    } on JsonParseException catch (e) {
      debugPrint('JSON 解析錯誤: ${e.message}');
    } catch (e) {
      debugPrint('未知錯誤: $e');
    }
  }
  
  /// 取得 Pokemon 詳細資訊範例
  Future<void> fetchPokemonDetail(String id) async {
    try {
      final detailEntity = await _detailService.fetchDetail(id);
      
      debugPrint('Pokemon #${detailEntity.id}:');
      debugPrint('- 重量: ${detailEntity.weight}');
      debugPrint('- 高度: ${detailEntity.height}');
      debugPrint('- 類型: ${detailEntity.types.map((t) => t.type.name).join(', ')}');
      
      if (detailEntity.sprites?.frontDefault != null) {
        debugPrint('- 圖片: ${detailEntity.sprites!.frontDefault}');
      }
    } on InvalidStatusCodeException catch (e) {
      debugPrint('HTTP 錯誤: ${e.statusCode}');
    } on NetworkException catch (e) {
      debugPrint('網路錯誤: ${e.message}');
    } on JsonParseException catch (e) {
      debugPrint('JSON 解析錯誤: ${e.message}');
    } catch (e) {
      debugPrint('未知錯誤: $e');
    }
  }
}
