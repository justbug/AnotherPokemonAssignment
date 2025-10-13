import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/local_pokemon.dart';

/// LocalPokemon 服務
/// 使用 SharedPreferences 來儲存 Pokemon 本地資料
class LocalPokemonService {
  static const String _pokemonKey = 'pokemon_data';
  static SharedPreferences? _prefs;

  /// 取得 SharedPreferences 實例
  Future<SharedPreferences> get prefs async {
    _prefs ??= await SharedPreferences.getInstance();
    return _prefs!;
  }

  /// 插入或更新 Pokemon 資料
  Future<void> insertOrUpdate(LocalPokemon pokemon) async {
    final prefs = await this.prefs;
    final pokemonData = await _getPokemonMap();
    
    pokemonData[pokemon.id] = pokemon.toJson();
    await prefs.setString(_pokemonKey, _mapToString(pokemonData));
  }

  /// 刪除 Pokemon 資料
  Future<void> delete(String id) async {
    final prefs = await this.prefs;
    final pokemonData = await _getPokemonMap();
    
    pokemonData.remove(id);
    await prefs.setString(_pokemonKey, _mapToString(pokemonData));
  }

  /// 根據 ID 取得 Pokemon 資料
  Future<LocalPokemon?> getById(String id) async {
    final pokemonData = await _getPokemonMap();
    final data = pokemonData[id];
    
    if (data != null) {
      return LocalPokemon.fromJson(data);
    }
    return null;
  }

  /// 取得所有 Pokemon 資料
  Future<List<LocalPokemon>> getAll() async {
    final pokemonData = await _getPokemonMap();
    final pokemonList = <LocalPokemon>[];
    
    for (final entry in pokemonData.entries) {
      final data = entry.value;
      pokemonList.add(LocalPokemon.fromJson(data));
    }
    
    return pokemonList;
  }

  /// 取得 Pokemon 資料的 Map
  Future<Map<String, Map<String, dynamic>>> _getPokemonMap() async {
    final prefs = await this.prefs;
    final pokemonString = prefs.getString(_pokemonKey);
    
    if (pokemonString == null || pokemonString.isEmpty) {
      return <String, Map<String, dynamic>>{};
    }
    
    return _stringToMap(pokemonString);
  }

  /// 將 Map 轉換為 JSON 字串
  String _mapToString(Map<String, Map<String, dynamic>> map) {
    return jsonEncode(map);
  }

  /// 將 JSON 字串轉換為 Map
  Map<String, Map<String, dynamic>> _stringToMap(String jsonString) {
    try {
      final Map<String, dynamic> jsonMap = jsonDecode(jsonString);
      return jsonMap.cast<String, Map<String, dynamic>>();
    } catch (e) {
      return <String, Map<String, dynamic>>{};
    }
  }

  /// 清除所有資料
  Future<void> clear() async {
    final prefs = await this.prefs;
    await prefs.remove(_pokemonKey);
  }
}
