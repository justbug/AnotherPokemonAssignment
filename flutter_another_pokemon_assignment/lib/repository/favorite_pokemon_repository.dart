import '../models/local_pokemon.dart';
import '../services/local_pokemon_service.dart';
import '../services/local_pokemon_service_interface.dart';

/// Pokemon favorite repository specification interface
/// Defines the business logic interface for favorite Pokemon operations
abstract class FavoritePokemonRepositorySpec {
  /// Check if Pokemon is favorite
  Future<bool> isFavorite(String pokemonId);
  
  /// Toggle Pokemon favorite status
  Future<void> toggleFavorite(String pokemonId, String pokemonName, String imageURL);
  
  /// Get all favorite Pokemon
  Future<List<LocalPokemon>> getAllFavorites();
  
  /// Get favorite status map for all Pokemon
  Future<Map<String, bool>> getAllFavoriteStatus();
}

/// Pokemon favorite repository
/// Handles business logic for Pokemon favorite status
/// 
/// Uses LocalPokemonServiceInterface interface with dependency injection support
/// Easy to replace with different storage implementations (e.g., SQLite)
class FavoritePokemonRepository implements FavoritePokemonRepositorySpec {
  final LocalPokemonServiceInterface _localPokemonService;

  FavoritePokemonRepository({
    LocalPokemonServiceInterface? localPokemonService,
  }) : _localPokemonService = localPokemonService ?? LocalPokemonService();

  /// Check if Pokemon is favorite
  @override
  Future<bool> isFavorite(String pokemonId) async {
    try {
      final localPokemon = await _localPokemonService.getById(pokemonId);
      return localPokemon?.isFavorite ?? false;
    } catch (e) {
      return false;
    }
  }

  /// Toggle Pokemon favorite status
  @override
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
        );
        await _localPokemonService.insertOrUpdate(newPokemon);
      }
    } catch (e) {
      rethrow;
    }
  }

  /// Get all favorite Pokemon
  @override
  Future<List<LocalPokemon>> getAllFavorites() async {
    try {
      final allPokemon = await _localPokemonService.getAll();
      return allPokemon.where((pokemon) => pokemon.isFavorite).toList();
    } catch (e) {
      return [];
    }
  }

  /// Get favorite status map for all Pokemon
  @override
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
