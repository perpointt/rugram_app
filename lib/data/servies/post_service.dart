import 'package:rugram/domain/models/post/post.dart';

abstract class PostService {
  Future<void> create(Map<String, dynamic> data);

  Future<Post?> getPost(int id);
  Future<List<Post>> getAllPosts(String username);

  Future<void> deletePost(int id);
  Future<Post> updatePost(int id, String caption);

  Future<Map<String, dynamic>> createLike(int id);
  Future<Map<String, dynamic>> deleteLike(int id);
}
