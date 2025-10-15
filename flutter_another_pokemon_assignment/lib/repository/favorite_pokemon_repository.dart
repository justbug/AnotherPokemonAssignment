import '../models/local_pokemon.dart';
import '../services/local_pokemon_service.dart';
import '../services/local_pokemon_service_spec.dart';

/// Pokemon favorite repository
/// Handles business logic for Pokemon favorite status
/// 
/// Uses LocalPokemonServiceSpec interface with dependency injection support
/// Easy to replace with different storage implementations (e.g., SQLite)
class FavoritePokemonRepository {
  final LocalPokemonServiceSpec _localPokemonService;

  FavoritePokemonRepository({
    LocalPokemonServiceSpec? localPokemonService,
  }) : _localPokemonService = localPokemonService ?? LocalPokemonService();

  /// Check if Pokemon is favorite
  Future<bool> isFavorite(String pokemonId) async {
    try {
      final localPokemon = await _localPokemonService.getById(pokemonId);
      return localPokemon?.isFavorite ?? false;
    } catch (e) {
      return false;
    }
  }

  /// Toggle Pokemon favorite status
  Future<void> toggleFavorite(String pokemonId, String pokemonName, String imageURL) async {
    try {
      final currentPokemon = await _localPokemonService.getById(pokemonId);
      final isCurrentlyFavorite = currentPokemon?.isFavorite ?? false;
      
      if (isCurrentlyFavorite) {
        // If currently favorite, remove it
        await _localPokemonService.delete(pokemonId);
      } else {
        // If not currently favorite, add it
        final newPokemon = LocalPokemon(
          id: pokemonId,
          name: pokemonName,
          imageURL: imageURL,
          isFavorite: true,
          created: DateTime.now().millisecondsSinceEpoch,
        );
        await _localPokemonService.insertOrUpdate(newPokemon);
      }
    } catch (e) {
      rethrow;
    }
  }

  /// Get favorite status map for all Pokemon
  Future<Map<String, bool>> getAllFavoriteStatus() async {
    try {
      final allPokemon = await _localPokemonService.getAll();
      final Map<String, bool> favoriteStatus = {};
      
      for (final pokemon in allPokemon) {
        favoriteStatus[pokemon.id] = pokemon.isFavorite;
      }
      
      return favoriteStatus;
    } catch (e) {
      return {};
    }
  }
}
