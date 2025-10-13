import '../models/local_pokemon.dart';
import '../services/local_pokemon_service.dart';

/// Pokemon 最愛倉庫規格介面
/// 定義最愛 Pokemon 相關的業務邏輯介面
abstract class FavoritePokemonRepositorySpec {
  /// 檢查 Pokemon 是否為最愛
  Future<bool> isFavorite(String pokemonId);
  
  /// 切換 Pokemon 最愛狀態
  Future<void> toggleFavorite(String pokemonId, String pokemonName);
  
  /// 取得所有最愛的 Pokemon
  Future<List<LocalPokemon>> getAllFavorites();
}

/// Pokemon 最愛倉庫
/// 處理 Pokemon 最愛狀態的業務邏輯
class FavoritePokemonRepository implements FavoritePokemonRepositorySpec {
  final LocalPokemonService _localPokemonService;

  FavoritePokemonRepository({
    LocalPokemonService? localPokemonService,
  }) : _localPokemonService = localPokemonService ?? LocalPokemonService();

  /// 檢查 Pokemon 是否為最愛
  @override
  Future<bool> isFavorite(String pokemonId) async {
    try {
      final localPokemon = await _localPokemonService.getById(pokemonId);
      return localPokemon?.isFavorite ?? false;
    } catch (e) {
      return false;
    }
  }

  /// 切換 Pokemon 最愛狀態
  @override
  Future<void> toggleFavorite(String pokemonId, String pokemonName) async {
    try {
      final currentPokemon = await _localPokemonService.getById(pokemonId);
      final isCurrentlyFavorite = currentPokemon?.isFavorite ?? false;
      
      if (isCurrentlyFavorite) {
        // 如果目前是最愛，則移除
        await _localPokemonService.delete(pokemonId);
      } else {
        // 如果目前不是最愛，則新增
        final newPokemon = LocalPokemon(
          id: pokemonId,
          name: pokemonName,
          isFavorite: true,
        );
        await _localPokemonService.insertOrUpdate(newPokemon);
      }
    } catch (e) {
      rethrow;
    }
  }

  /// 取得所有最愛的 Pokemon
  @override
  Future<List<LocalPokemon>> getAllFavorites() async {
    try {
      final allPokemon = await _localPokemonService.getAll();
      return allPokemon.where((pokemon) => pokemon.isFavorite).toList();
    } catch (e) {
      return [];
    }
  }
}
