import 'package:http/http.dart' as http;
import '../../networking/api_client.dart';
import '../../networking/request_builder.dart';
import 'service_helper.dart';

/// Pokemon 核心服務類別
/// 對應 iOS 的 PokemonService class
/// 使用 Singleton pattern 提供統一的網路請求介面
class PokemonService {
  static PokemonService? _instance;
  static PokemonService get instance => _instance ??= PokemonService._internal();
  
  final APIClient _apiClient;
  
  PokemonService._internal({
    APIClient? apiClient,
  }) : _apiClient = apiClient ?? APIClient();
  
  /// 通用的 fetch 方法
  /// 對應 iOS 的 fetch 方法
  /// 
  /// [path] API 路徑
  /// [query] 查詢參數
  Future<http.Response> fetch(
    String path, {
    Map<String, String?>? query,
  }) async {
    try {
      // 建構請求
      final requestBuilder = RequestBuilder.pokemon(path, query: query);
      
      // 執行網路請求
      final response = await _apiClient.get(requestBuilder);
      
      // 驗證狀態碼
      response.validateStatusCode();
      
      return response;
    } on InvalidStatusCodeException {
      rethrow;
    } on http.ClientException catch (e) {
      throw NetworkException('Network error: ${e.message}');
    } catch (e) {
      throw PokemonServiceException('Unexpected error: $e');
    }
  }
}
