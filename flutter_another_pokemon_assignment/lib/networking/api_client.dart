import 'package:http/http.dart' as http;
import 'request_builder.dart';

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
