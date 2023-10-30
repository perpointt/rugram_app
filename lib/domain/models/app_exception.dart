class AppException implements Exception {
  final dynamic error;

  AppException(this.error);

  @override
  String toString() {
    return 'AppException{error: $error}';
  }
}
