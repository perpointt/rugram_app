import 'package:rugram/data/data_providers/post_data_provider.dart';
import 'package:rugram/data/servies/post_service.dart';
import 'package:rugram/domain/data_providers/post_data_provider.dart';
import 'package:rugram/domain/models/app_exception.dart';
import 'package:rugram/domain/models/post/post.dart';

class CachePostServiceImpl implements PostService {
  late final PostDataProvider postDataProvider;

  CachePostServiceImpl({PostDataProvider? postDataProvider}) {
    this.postDataProvider = postDataProvider ?? PostDataProviderImpl();
  }

  @override
  Future<void> create(Map<String, dynamic> data) async {
    return postDataProvider.addPost(Post.fromJson(data));
  }

  @override
  Future<Map<String, dynamic>> createLike(int id) {
    throw UnimplementedError();
  }

  @override
  Future<Map<String, dynamic>> deleteLike(int id) {
    throw UnimplementedError();
  }

  @override
  Future<void> deletePost(int id) {
    return postDataProvider.deletePost(id);
  }

  @override
  Future<List<Post>> getAllPosts(String username) {
    return postDataProvider.fetchAllPosts(username);
  }

  @override
  Future<Post?> getPost(int id) {
    return postDataProvider.fetchPost(id);
  }

  @override
  Future<Post> updatePost(int id, String caption) async {
    final post = await postDataProvider.fetchPost(id);
    if (post == null) throw AppException(error: 'Post not found');
    final updated = post.copyWith(caption: caption);
    await postDataProvider.addPost(updated);
    return updated;
  }
}
