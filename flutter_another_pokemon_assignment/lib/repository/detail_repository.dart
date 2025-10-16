import '../models/models.dart';
import '../services/detail_service.dart';

/// Pokemon detail repository specification interface
/// Corresponds to iOS DetailUseCaseSpec protocol
abstract class DetailRepositorySpec {
  Future<PokemonDetail> fetchDetail(String id);
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
  @override
  Future<PokemonDetail> fetchDetail(String id) async {
    try {
      final entity = await _detailService.fetchDetail(id);
      final model = _mapToModel(entity);
      return model;
    } catch (e) {
      // Re-throw error to preserve error type
      rethrow;
    }
  }

  /// Convert DetailEntity to PokemonDetail model
  /// Corresponds to iOS mapToModel(_ entity: DetailEntity) method
  PokemonDetail _mapToModel(DetailEntity entity) {
    return PokemonDetail(
      id: entity.id,
      weight: entity.weight,
      height: entity.height,
      types: entity.types.map((t) => t.type.name).toList(),
      imageUrl: entity.sprites?.frontDefault,
    );
  }
}
