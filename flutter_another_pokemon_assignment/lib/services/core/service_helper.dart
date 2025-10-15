import 'package:http/http.dart' as http;

/// Pokemon service related custom errors
class PokemonServiceException implements Exception {
  final String message;
  final int? statusCode;
  
  const PokemonServiceException(this.message, [this.statusCode]);
  
  @override
  String toString() => 'PokemonServiceException: $message${statusCode != null ? ' (Status: $statusCode)' : ''}';
}

/// Invalid status code error
class InvalidStatusCodeException extends PokemonServiceException {
  const InvalidStatusCodeException(int statusCode) 
      : super('Invalid status code: $statusCode', statusCode);
}

/// Network request error
class NetworkException extends PokemonServiceException {
  const NetworkException(super.message);
}

/// JSON parsing error
class JsonParseException extends PokemonServiceException {
  const JsonParseException(super.message);
}

/// Extension for http.Response to add status code validation
extension ResponseValidation on http.Response {
  /// Validate if status code is within 200-299 range
  /// Throws InvalidStatusCodeException if invalid
  void validateStatusCode() {
    if (statusCode < 200 || statusCode >= 300) {
      throw InvalidStatusCodeException(statusCode);
    }
  }
}

/// Extension for int? to add conversion to String? method
extension IntToString on int? {
  /// Convert int? to String?, corresponds to iOS toString property
  String? get toStringOrNull => this?.toString();
}
