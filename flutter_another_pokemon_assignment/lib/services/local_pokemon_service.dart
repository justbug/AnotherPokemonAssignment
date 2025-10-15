import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/local_pokemon.dart';
import 'local_pokemon_service_interface.dart';

/// LocalPokemon service implementation
/// 
/// Uses SharedPreferences to store Pokemon local data
/// 
/// **Note**: This implementation uses SharedPreferences for demo purposes.
/// For production environments, it's recommended to use SQLite or other more suitable database solutions.
/// This class implements the LocalPokemonServiceInterface interface for easy future replacement.
class LocalPokemonService implements LocalPokemonServiceInterface {
  static const String _pokemonKey = 'pokemon_data';
  static SharedPreferences? _prefs;

  /// Get SharedPreferences instance
  Future<SharedPreferences> get prefs async {
    _prefs ??= await SharedPreferences.getInstance();
    return _prefs!;
  }

  /// Insert or update Pokemon data
  @override
  Future<void> insertOrUpdate(LocalPokemon pokemon) async {
    final prefs = await this.prefs;
    final pokemonData = await _getPokemonMap();
    
    pokemonData[pokemon.id] = pokemon.toJson();
    await prefs.setString(_pokemonKey, _mapToString(pokemonData));
  }

  /// Delete Pokemon data
  @override
  Future<void> delete(String id) async {
    final prefs = await this.prefs;
    final pokemonData = await _getPokemonMap();
    
    pokemonData.remove(id);
    await prefs.setString(_pokemonKey, _mapToString(pokemonData));
  }

  /// Get Pokemon data by ID
  @override
  Future<LocalPokemon?> getById(String id) async {
    final pokemonData = await _getPokemonMap();
    final data = pokemonData[id];
    
    if (data != null) {
      return LocalPokemon.fromJson(data);
    }
    return null;
  }

  /// Get all Pokemon data
  @override
  Future<List<LocalPokemon>> getAll() async {
    final pokemonData = await _getPokemonMap();
    final pokemonList = <LocalPokemon>[];
    
    for (final entry in pokemonData.entries) {
      final data = entry.value;
      pokemonList.add(LocalPokemon.fromJson(data));
    }
    
    return pokemonList;
  }

  /// Get Pokemon data Map
  Future<Map<String, Map<String, dynamic>>> _getPokemonMap() async {
    final prefs = await this.prefs;
    final pokemonString = prefs.getString(_pokemonKey);
    
    if (pokemonString == null || pokemonString.isEmpty) {
      return <String, Map<String, dynamic>>{};
    }
    
    return _stringToMap(pokemonString);
  }

  /// Convert Map to JSON string
  String _mapToString(Map<String, Map<String, dynamic>> map) {
    return jsonEncode(map);
  }

  /// Convert JSON string to Map
  Map<String, Map<String, dynamic>> _stringToMap(String jsonString) {
    try {
      final Map<String, dynamic> jsonMap = jsonDecode(jsonString);
      return jsonMap.cast<String, Map<String, dynamic>>();
    } catch (e) {
      return <String, Map<String, dynamic>>{};
    }
  }

  /// Clear all data
  @override
  Future<void> clear() async {
    final prefs = await this.prefs;
    await prefs.remove(_pokemonKey);
  }
}
