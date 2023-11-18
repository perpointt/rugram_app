class AppException implements Exception {
  final dynamic error;
  late final StackTrace stackTrace;

  AppException({
    required this.error,
    StackTrace? stackTrace,
  }) {
    this.stackTrace = stackTrace ?? StackTrace.current;
  }

  @override
  String toString() {
    return 'AppException{error: $error, stackTrace: $stackTrace}';
  }
}

class ApiException extends AppException {
  final ApiExceptionType type;
  final int? statusCode;

  ApiException({
    dynamic error,
    StackTrace? stackTrace,
    required this.type,
    this.statusCode,
  }) : super(error: error, stackTrace: stackTrace);

  @override
  String toString() {
    return 'ApiException{error: $error, stackTrace: $stackTrace, type: $type, statusCode: $statusCode}';
  }
}

enum ApiExceptionType { timeout, auth, badRequest, other }
