import 'package:http/http.dart' as http;
import '../../networking/api_client.dart';
import '../../networking/request_builder.dart';
import 'service_helper.dart';

/// Pokemon core service class
/// Corresponds to iOS PokemonService class
/// Uses Singleton pattern to provide unified network request interface
class PokemonService {
  static PokemonService? _instance;
  static PokemonService get instance => _instance ??= PokemonService._internal();
  
  final APIClient _apiClient;
  
  PokemonService._internal({
    APIClient? apiClient,
  }) : _apiClient = apiClient ?? APIClient();
  
  /// Generic fetch method
  /// Corresponds to iOS fetch method
  /// 
  /// [path] API path
  /// [query] Query parameters
  Future<http.Response> fetch(
    String path, {
    Map<String, String?>? query,
  }) async {
    try {
      // Build request
      final requestBuilder = RequestBuilder.pokemon(path, query: query);
      
      // Execute network request
      final response = await _apiClient.get(requestBuilder);
      
      // Validate status code
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
