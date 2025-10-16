import 'package:http/http.dart' as http;
import 'request_builder.dart';

/// APIClient corresponds to iOS APIClient class, uses native methods from http package
class APIClient {
  final http.Client _client;
  
  APIClient({http.Client? client}) : _client = client ?? http.Client();
  
  /// Execute GET request, corresponds to iOS fetch method
  Future<http.Response> get(RequestBuilder requestBuilder) async {
    final request = requestBuilder.build('GET');
    final streamedResponse = await _client.send(request);
    return await http.Response.fromStream(streamedResponse);
  }
  
  /// Execute POST request
  Future<http.Response> post(RequestBuilder requestBuilder, {Object? body}) async {
    final request = requestBuilder.build('POST');
    if (body != null) {
      request.body = body.toString();
    }
    final streamedResponse = await _client.send(request);
    return await http.Response.fromStream(streamedResponse);
  }
  
  /// Execute PUT request
  Future<http.Response> put(RequestBuilder requestBuilder, {Object? body}) async {
    final request = requestBuilder.build('PUT');
    if (body != null) {
      request.body = body.toString();
    }
    final streamedResponse = await _client.send(request);
    return await http.Response.fromStream(streamedResponse);
  }
  
  /// Execute DELETE request
  Future<http.Response> delete(RequestBuilder requestBuilder, {Object? body}) async {
    final request = requestBuilder.build('DELETE');
    if (body != null) {
      request.body = body.toString();
    }
    final streamedResponse = await _client.send(request);
    return await http.Response.fromStream(streamedResponse);
  }
}
