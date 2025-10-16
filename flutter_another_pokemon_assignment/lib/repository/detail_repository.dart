import '../models/models.dart';
import '../services/detail_service.dart';

/// Pokemon detail repository specification interface
/// Corresponds to iOS DetailUseCaseSpec protocol
abstract class DetailRepositorySpec {
  Future<Pokemon> fetchDetail(String id, String name);
}

/// Pokemon detail repository
/// Corresponds to iOS DetailUseCase struct
class DetailRepository implements DetailRepositorySpec {
  final DetailService _detailService;

  DetailRepository({DetailService? detailService}) 
      : _detailService = detailService ?? DetailService();

  /// Get Pokemon detail
  /// Corresponds to iOS fetchDetail(id: String) method
  /// 
  /// [id] Pokemon ID
  /// [name] Pokemon name
  @override
  Future<Pokemon> fetchDetail(String id, String name) async {
    try {
      final entity = await _detailService.fetchDetail(id);
      final model = _mapToModel(entity, id, name);
      return model;
    } catch (e) {
      // Re-throw error to preserve error type
      rethrow;
    }
  }

  /// Convert DetailEntity to Pokemon model
  /// Corresponds to iOS mapToModel(_ entity: DetailEntity) method
  Pokemon _mapToModel(DetailEntity entity, String id, String name) {
    // Create PokemonDetailData from entity
    final detailData = PokemonDetailData(
      id: entity.id,
      weight: entity.weight,
      height: entity.height,
      types: entity.types.map((t) => t.type.name).toList(),
    );

    // Create Pokemon with detail information
    return Pokemon(
      name: name,
      id: id,
      imageURL: entity.sprites?.frontDefault ?? 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$id.png',
      detail: detailData,
    );
  }
}
