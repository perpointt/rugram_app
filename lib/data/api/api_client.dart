abstract class ApiClient {
  Future<Map<String, dynamic>> get(
    String method,
    Map<String, dynamic> queryParameters,
  );

  Future<Map<String, dynamic>> post(
    String method,
    Map<String, dynamic> queryParameters,
  );
}
