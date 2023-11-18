import 'package:isar/isar.dart';
import 'package:rugram/data/data_providers/post_data_provider.dart';
import 'package:rugram/domain/database/database_client.dart';
import 'package:rugram/domain/models/post/post.dart';

class PostDataProviderImpl implements PostDataProvider {
  final _client = DatabaseClientImpl();

  @override
  Future<void> addPost(Post post) async {
    await _client.instance.writeTxn(() async {
      await _client.instance.posts.put(post);
    });
  }

  @override
  Future<void> deletePost(int id) async {
    await _client.instance.writeTxn(() async {
      await _client.instance.posts.delete(id);
    });
  }

  @override
  Future<List<Post>> fetchAllPosts(String username) async {
    return _client.instance.posts
        .where()
        .usernameEqualTo(username)
        .sortByDateDesc()
        .findAll();
  }

  @override
  Future<Post?> fetchPost(int id) {
    return _client.instance.posts.get(id);
  }

  @override
  Future<void> addAllPost(List<Post> posts) async {
    await _client.instance.writeTxn(() async {
      await _client.instance.posts.putAll(posts);
    });
  }
}
