import 'dart:convert';
import '../models/models.dart';
import '../services/core/pokemon_service.dart';
import '../services/core/service_helper.dart';
import 'package:flutter/foundation.dart';

/// Pokemon list repository specification interface
/// Corresponds to iOS ListUseCaseSpec protocol
abstract class ListRepositorySpec {
  Future<List<Pokemon>> fetchList({int offset = 0});
}

/// Pokemon list repository
/// Corresponds to iOS ListUseCase struct
class ListRepository implements ListRepositorySpec {
  static const int _limit = 30;
  static const String _path = 'pokemon';
  final PokemonService _pokemonService;

  ListRepository({PokemonService? pokemonService}) 
      : _pokemonService = pokemonService ?? PokemonService.instance;

  /// Get Pokemon list
  /// Corresponds to iOS fetchList(offset: Int) method
  /// 
  /// [offset] Offset, defaults to 0
  @override
  Future<List<Pokemon>> fetchList({int offset = 0}) async {
    try {
      final entity = await _fetchListEntity(limit: _limit, offset: offset);
      final models = _mapToModel(entity);
      return models;
    } catch (e) {
      // Re-throw error to preserve error type
      rethrow;
    }
  }

  /// Get Pokemon list entity
  /// Integrates original ListService logic
  /// 
  /// [limit] Limit return count
  /// [offset] Offset
  Future<ListEntity> _fetchListEntity({int? limit, int? offset}) async {
    try {
      // Build query parameters, corresponds to iOS query construction logic
      final query = <String, String?>{
        if (limit != null) 'limit': limit.toStringOrNull,
        if (offset != null) 'offset': offset.toStringOrNull,
      };
      
      final response = await _pokemonService.fetch(
        _path,
        query: query,
      );
      
      try {
        final dynamic json = jsonDecode(response.body);
        if (json is! Map<String, dynamic>) {
          throw JsonParseException('Expected JSON object when parsing ListEntity');
        }
        return ListEntity.fromJson(json);
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

  /// Convert ListEntity to Pokemon model list
  /// Corresponds to iOS mapToModel(_ entity: ListEntity) method
  List<Pokemon> _mapToModel(ListEntity entity) {
    return entity.results
        .map((result) => _createPokemonFromResult(result))
        .where((pokemon) => pokemon != null)
        .cast<Pokemon>()
        .toList();
  }

  /// Create Pokemon model from ResultEntity
  /// Corresponds to iOS getID(urlString: String) method
  Pokemon? _createPokemonFromResult(ResultEntity result) {
    final id = _extractIdFromUrl(result.url);
    if (id == null) return null;
    
    return Pokemon(
      name: result.name,
      id: id,
      imageURL: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$id.png',
    );
  }

  /// Extract Pokemon ID from URL
  /// Corresponds to iOS getID(urlString: String) method
  String? _extractIdFromUrl(String urlString) {
    try {
      final uri = Uri.parse(urlString);
      final pathSegments = uri.pathSegments;
      
      if (pathSegments.isEmpty) {
        return null;
      }
      
      // Pokemon API URL format: /api/v2/pokemon/1/ or /api/v2/pokemon/1
      // We need to find the segment containing numbers
      for (int i = pathSegments.length - 1; i >= 0; i--) {
        final segment = pathSegments[i];
        
        // Remove trailing slash
        final cleanSegment = segment.endsWith('/') ? segment.substring(0, segment.length - 1) : segment;
        
        if (cleanSegment.isNotEmpty) {
          final id = int.tryParse(cleanSegment);
          if (id != null) {
            return id.toString();
          }
        }
      }
      
      return null;
    } catch (e) {
      debugPrint('Error extracting ID from URL: $e');
      return null;
    }
  }
}
