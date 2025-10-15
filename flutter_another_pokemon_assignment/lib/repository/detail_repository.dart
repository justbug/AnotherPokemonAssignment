import '../models/models.dart';
import '../services/detail_service.dart';

/// Pokemon 詳細資訊倉庫規格介面
/// 對應 iOS 的 DetailUseCaseSpec protocol
abstract class DetailRepositorySpec {
  Future<PokemonDetail> fetchDetail(String id);
}

/// Pokemon 詳細資訊倉庫
/// 對應 iOS 的 DetailUseCase struct
class DetailRepository implements DetailRepositorySpec {
  final DetailService _detailService;

  DetailRepository({DetailService? detailService}) 
      : _detailService = detailService ?? DetailService();

  /// 取得 Pokemon 詳細資訊
  /// 對應 iOS 的 fetchDetail(id: String) 方法
  /// 
  /// [id] Pokemon ID
  @override
  Future<PokemonDetail> fetchDetail(String id) async {
    try {
      final entity = await _detailService.fetchDetail(id);
      final model = _mapToModel(entity);
      return model;
    } catch (e) {
      // 重新拋出錯誤，保持錯誤類型
      rethrow;
    }
  }

  /// 將 DetailEntity 轉換為 PokemonDetail 模型
  /// 對應 iOS 的 mapToModel(_ entity: DetailEntity) 方法
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
