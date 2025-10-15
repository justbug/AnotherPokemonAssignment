import '../models/local_pokemon.dart';

/// LocalPokemon service interface
/// Defines the contract for local Pokemon data storage operations
/// 
/// Currently implemented with SharedPreferences, but designed as a replaceable interface
/// Can be easily replaced with SQLite or other storage solutions in the future
abstract class LocalPokemonServiceInterface {
  /// Insert or update Pokemon data
  /// 
  /// [pokemon] The Pokemon data to store
  /// Updates if Pokemon exists, otherwise inserts new data
  Future<void> insertOrUpdate(LocalPokemon pokemon);

  /// Delete Pokemon data
  /// 
  /// [id] The Pokemon ID to delete
  Future<void> delete(String id);

  /// Get Pokemon data by ID
  /// 
  /// [id] Pokemon ID
  /// Returns Pokemon data, or null if not found
  Future<LocalPokemon?> getById(String id);

  /// Get all Pokemon data
  /// 
  /// Returns a list of all stored Pokemon data
  Future<List<LocalPokemon>> getAll();

  /// Clear all data
  /// 
  /// Deletes all stored Pokemon data
  Future<void> clear();
}
