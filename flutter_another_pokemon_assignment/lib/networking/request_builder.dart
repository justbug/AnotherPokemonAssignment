import 'package:http/http.dart' as http;

/// Request builder, corresponds to iOS Request struct, responsible for URL construction and headers management
class RequestBuilder {
  final Uri baseURL;
  final String path;
  final Map<String, String?>? query;
  final Map<String, String>? headers;
  
  RequestBuilder({
    required this.baseURL,
    required this.path,
    this.query,
    this.headers,
  });
  
  /// Factory method for Pokemon API requests
  factory RequestBuilder.pokemon(String path, {Map<String, String?>? query}) {
    return RequestBuilder(
      baseURL: Uri.parse('https://pokeapi.co'),
      path: '/api/v2/$path',
      query: query,
    );
  }
  
  /// Create http.Request object
  http.Request build(String method) {
    final uri = buildURI();
    final request = http.Request(method, uri);
    
    // Set headers
    if (headers != null) {
      request.headers.addAll(headers!);
    }
    
    return request;
  }
  
  /// Create URI with query parameters
  Uri buildURI() {
    final fullURL = baseURL.resolve(path);
    
    if (query == null || query!.isEmpty) {
      return fullURL;
    }
    
    // Filter out null values, corresponds to iOS version filtering logic
    final filteredQuery = <String, String>{};
    query!.forEach((key, value) {
      if (value != null) {
        filteredQuery[key] = value;
      }
    });
    
    return fullURL.replace(queryParameters: filteredQuery);
  }
}
