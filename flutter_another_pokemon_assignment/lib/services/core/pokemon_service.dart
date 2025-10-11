import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../networking/api_client.dart';
import '../../models/list_entity.dart';
import '../../models/detail_entity.dart';
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
  
  /// 通用的 fetch 方法，支援泛型
  /// 對應 iOS 的 fetch&lt;T: Decodable&gt; 方法
  /// 
  /// [T] 回傳型別，必須支援 fromJson
  /// [path] API 路徑
  /// [query] 查詢參數
  Future<T> fetch<T>(
    String path, {
    Map<String, String?>? query,
  }) async {
    try {
      // 建構請求
      final requestBuilder = _buildPokemonRequest(path, query);
      
      // 執行網路請求
      final response = await _apiClient.get(requestBuilder);
      
      // 驗證狀態碼
      response.validateStatusCode();
      
      // 解析 JSON
      return _decode<T>(response.body);
    } on InvalidStatusCodeException {
      rethrow;
    } on http.ClientException catch (e) {
      throw NetworkException('Network error: ${e.message}');
    } on FormatException catch (e) {
      throw JsonParseException('JSON parse error: ${e.message}');
    } catch (e) {
      throw PokemonServiceException('Unexpected error: $e');
    }
  }
  
  /// 建構 Pokemon API 請求的 private 方法
  /// 對應原本的 PokemonRequestMaker 功能
  RequestBuilder _buildPokemonRequest(String path, Map<String, String?>? query) {
    const baseURL = 'https://pokeapi.co';
    const apiVersion = 'v2';
    final fullPath = '/api/$apiVersion/$path';
    
    return RequestBuilder(
      baseURL: Uri.parse(baseURL),
      path: fullPath,
      query: query,
    );
  }
  
  /// JSON 解碼方法
  /// 對應 iOS 的 decode&lt;T: Decodable&gt; 方法
  T _decode<T>(String jsonString) {
    try {
      final jsonMap = jsonDecode(jsonString) as Map<String, dynamic>;
      
      // 使用 json_serializable 生成的 fromJson 方法
      if (T == ListEntity) {
        return ListEntity.fromJson(jsonMap) as T;
      } else if (T == DetailEntity) {
        return DetailEntity.fromJson(jsonMap) as T;
      } else {
        throw JsonParseException('Unsupported type: $T');
      }
    } catch (e) {
      throw JsonParseException('Failed to decode JSON: $e');
    }
  }
}