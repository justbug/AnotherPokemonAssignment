import 'package:http/http.dart' as http;

/// Request 建構器，對應 iOS 的 Request struct，負責 URL 建構和 headers 管理
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
  
  /// Pokemon API 請求的 factory 方法
  factory RequestBuilder.pokemon(String path, {Map<String, String?>? query}) {
    return RequestBuilder(
      baseURL: Uri.parse('https://pokeapi.co'),
      path: '/api/v2/$path',
      query: query,
    );
  }
  
  /// 建立 http.Request 物件
  http.Request build(String method) {
    final uri = buildURI();
    final request = http.Request(method, uri);
    
    // 設定 headers
    if (headers != null) {
      request.headers.addAll(headers!);
    }
    
    return request;
  }
  
  /// 建立包含查詢參數的 URI
  Uri buildURI() {
    final fullURL = baseURL.resolve(path);
    
    if (query == null || query!.isEmpty) {
      return fullURL;
    }
    
    // 過濾掉 null 值，對應 iOS 版本的過濾邏輯
    final filteredQuery = <String, String>{};
    query!.forEach((key, value) {
      if (value != null) {
        filteredQuery[key] = value;
      }
    });
    
    return fullURL.replace(queryParameters: filteredQuery);
  }
}
