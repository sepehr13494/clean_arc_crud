class CacheException implements Exception{
  final String message;

  CacheException({required this.message});

  @override
  String toString() {
    return "CacheException : $message";
  }
}

class InputValidationException implements Exception{
  final String message;

  InputValidationException({required this.message});

  @override
  String toString() {
    return "InputValidationException : $message";
  }
}