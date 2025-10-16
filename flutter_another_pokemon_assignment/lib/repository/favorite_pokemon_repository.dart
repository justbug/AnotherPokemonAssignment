import '../models/local_pokemon.dart';
import '../models/pokemon.dart';
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

  /// Update Pokemon favorite status directly
  Future<void> updateFavorite(
    String pokemonId,
    bool isFavorite,
    String pokemonName,
    String imageURL,
  ) async {
    try {
      if (!isFavorite) {
        // Remove Pokemon when marking as not favorite
        await _localPokemonService.delete(pokemonId);
        return;
      }

      final existingPokemon = await _localPokemonService.getById(pokemonId);

      // Preserve original created timestamp when available
      final createdTimestamp = existingPokemon?.created ?? DateTime.now().millisecondsSinceEpoch;

      final newPokemon = LocalPokemon(
        id: pokemonId,
        name: pokemonName,
        imageURL: imageURL,
        isFavorite: true,
        created: createdTimestamp,
      );

      await _localPokemonService.insertOrUpdate(newPokemon);
    } catch (e) {
      rethrow;
    }
  }

  /// Get favorite id set for all favorite Pokemon
  Future<Set<String>> getFavoritePokemonIds() async {
    try {
      final allPokemon = await _localPokemonService.getAll();
      final favoriteIds = <String>{};
      for (final pokemon in allPokemon) {
        if (pokemon.isFavorite) {
          favoriteIds.add(pokemon.id);
        }
      }
      return favoriteIds;
    } catch (e) {
      return <String>{};
    }
  }

  /// Get favorite Pokemon list sorted by creation time (earliest first)
  Future<List<Pokemon>> getFavoritePokemonList() async {
    try {
      final allPokemon = await _localPokemonService.getAll();
      final favorites = allPokemon.where((p) => p.isFavorite).toList();
      // Sort by created time in descending order (latest first)
      favorites.sort((a, b) => b.created.compareTo(a.created));
      return favorites.map((localPokemon) => _mapToModel(localPokemon)).toList();
    } catch (e) {
      return [];
    }
  }

  /// Convert LocalPokemon to Pokemon model
  Pokemon _mapToModel(LocalPokemon localPokemon) {
    return Pokemon(
      name: localPokemon.name,
      id: localPokemon.id,
      imageURL: localPokemon.imageURL,
      isFavorite: localPokemon.isFavorite,
    );
  }
}
