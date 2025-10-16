import 'dart:convert';

import '../models/detail_entity.dart';
import 'core/pokemon_service.dart';
import 'core/service_helper.dart';

/// Pokemon detail service specification interface
/// Corresponds to iOS DetailServiceSpec protocol
abstract class DetailServiceSpec {
  Future<DetailEntity> fetchDetail(String id);
}

/// Pokemon detail service
/// Corresponds to iOS DetailService struct
class DetailService implements DetailServiceSpec {
  final PokemonService _pokemonService;
  
  DetailService({PokemonService? pokemonService}) 
      : _pokemonService = pokemonService ?? PokemonService.instance;
  
  /// Get Pokemon detail
  /// Corresponds to iOS fetchDetail(id: String) method
  /// 
  /// [id] Pokemon ID
  @override
  Future<DetailEntity> fetchDetail(String id) async {
    try {
      final path = 'pokemon/$id';
      
      final response = await _pokemonService.fetch(
        path,
        query: null,
      );
      
      try {
        final dynamic json = jsonDecode(response.body);
        if (json is! Map<String, dynamic>) {
          throw JsonParseException('Expected JSON object when parsing DetailEntity');
        }
        return DetailEntity.fromJson(json);
      } on FormatException catch (e) {
        throw JsonParseException('JSON parse error: ${e.message}');
      } on TypeError catch (e) {
        throw JsonParseException('JSON structure error: $e');
      }
    } catch (e) {
      // Re-throw error to preserve error type
      rethrow;
    }
  }
}
