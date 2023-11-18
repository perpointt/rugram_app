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
  Future<Map<String, dynamic>> getUser(String username);
  Future<Map<String, dynamic>> getUserFromSession();

  Future<Map<String, dynamic>> createPost(Map<String, dynamic> data);
  Future<Map<String, dynamic>> getPost(int id);
  Future<Map<String, dynamic>> getAllPosts(String username);

  Future<Map<String, dynamic>> deletePost(int id);
  Future<Map<String, dynamic>> updatePost(int id, String caption);

  Future<Map<String, dynamic>> createLike(int id);
  Future<Map<String, dynamic>> deleteLike(int id);
}
