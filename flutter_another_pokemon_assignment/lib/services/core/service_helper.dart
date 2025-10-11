import 'package:http/http.dart' as http;

/// Pokemon 服務相關的自訂錯誤
class PokemonServiceException implements Exception {
  final String message;
  final int? statusCode;
  
  const PokemonServiceException(this.message, [this.statusCode]);
  
  @override
  String toString() => 'PokemonServiceException: $message${statusCode != null ? ' (Status: $statusCode)' : ''}';
}

/// 無效狀態碼錯誤
class InvalidStatusCodeException extends PokemonServiceException {
  const InvalidStatusCodeException(int statusCode) 
      : super('Invalid status code: $statusCode', statusCode);
}

/// 網路請求錯誤
class NetworkException extends PokemonServiceException {
  const NetworkException(String message) : super(message);
}

/// JSON 解析錯誤
class JsonParseException extends PokemonServiceException {
  const JsonParseException(String message) : super(message);
}

/// 擴展 http.Response 添加狀態碼驗證
extension ResponseValidation on http.Response {
  /// 驗證狀態碼是否在 200-299 範圍內
  /// 如果無效則拋出 InvalidStatusCodeException
  void validateStatusCode() {
    if (statusCode < 200 || statusCode >= 300) {
      throw InvalidStatusCodeException(statusCode);
    }
  }
}

/// 擴展 int? 添加轉換為 String? 的方法
extension IntToString on int? {
  /// 將 int? 轉換為 String?，對應 iOS 的 toString 屬性
  String? get toStringOrNull => this?.toString();
}
