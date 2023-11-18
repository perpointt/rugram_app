import 'package:rugram/domain/models/post/post.dart';

abstract class PostDataProvider {
  Future<Post?> fetchPost(int id);
  Future<List<Post>> fetchAllPosts(String username);
  Future<void> addPost(Post post);
  Future<void> addAllPost(List<Post> posts);
  Future<void> deletePost(int id);
}
