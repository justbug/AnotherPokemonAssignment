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

/// APIClient 對應 iOS 的 APIClient class，使用 http 套件的原生方法
class APIClient {
  final http.Client _client;
  
  APIClient({http.Client? client}) : _client = client ?? http.Client();
  
  /// 執行 GET 請求，對應 iOS 的 fetch 方法
  Future<http.Response> get(RequestBuilder requestBuilder) async {
    final request = requestBuilder.build('GET');
    final streamedResponse = await _client.send(request);
    return await http.Response.fromStream(streamedResponse);
  }
  
  /// 執行 POST 請求
  Future<http.Response> post(RequestBuilder requestBuilder, {Object? body}) async {
    final request = requestBuilder.build('POST');
    if (body != null) {
      request.body = body.toString();
    }
    final streamedResponse = await _client.send(request);
    return await http.Response.fromStream(streamedResponse);
  }
  
  /// 執行 PUT 請求
  Future<http.Response> put(RequestBuilder requestBuilder, {Object? body}) async {
    final request = requestBuilder.build('PUT');
    if (body != null) {
      request.body = body.toString();
    }
    final streamedResponse = await _client.send(request);
    return await http.Response.fromStream(streamedResponse);
  }
  
  /// 執行 DELETE 請求
  Future<http.Response> delete(RequestBuilder requestBuilder, {Object? body}) async {
    final request = requestBuilder.build('DELETE');
    if (body != null) {
      request.body = body.toString();
    }
    final streamedResponse = await _client.send(request);
    return await http.Response.fromStream(streamedResponse);
  }
}
