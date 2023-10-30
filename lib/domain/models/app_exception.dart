class AppException implements Exception {
  final dynamic error;
  final StackTrace stackTrace;

  AppException({
    required this.error,
    required this.stackTrace,
  });

  @override
  String toString() {
    return 'AppException{error: $error, stackTrace: $stackTrace}';
  }
}

class ApiException extends AppException {
  final ApiExceptionType type;
  final int? statusCode;

  ApiException({
    required dynamic error,
    required StackTrace stackTrace,
    required this.type,
    this.statusCode,
  }) : super(error: error, stackTrace: stackTrace);

  @override
  String toString() {
    return 'ApiException{error: $error, stackTrace: $stackTrace, type: $type, statusCode: $statusCode}';
  }
}

enum ApiExceptionType { timeout, auth, badRequest, other }
