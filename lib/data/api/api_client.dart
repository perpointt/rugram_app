abstract class ApiClient {
  Future<Map<String, dynamic>> get(
    String method,
    Map<String, dynamic> queryParameters,
  );

  Future<Map<String, dynamic>> post(
    String method,
    Map<String, dynamic> queryParameters,
  );

  Future<Map<String, dynamic>> login(Map<String, dynamic> data);
  Future<Map<String, dynamic>> register(Map<String, dynamic> data);
  Future<Map<String, dynamic>> createPost(Map<String, dynamic> data);
  Future<Map<String, dynamic>> getUser(String username);
}
