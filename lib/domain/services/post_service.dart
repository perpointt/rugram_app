import 'package:rugram/data/api/api_client.dart';
import 'package:rugram/data/data_providers/post_data_provider.dart';
import 'package:rugram/data/data_providers/session_data_provider.dart';
import 'package:rugram/data/servies/post_service.dart';
import 'package:rugram/domain/api/api_client.dart';
import 'package:rugram/domain/api/interceptors/auth_interceptor.dart';
import 'package:rugram/domain/data_providers/post_data_provider.dart';
import 'package:rugram/domain/data_providers/session_data_provider.dart';
import 'package:rugram/domain/models/post/post.dart';

class PostServiceImpl implements PostService {
  late final ApiClient client;
  late final SessionDataProvider sessionDataProvider;
  late final PostDataProvider postDataProvider;

  PostServiceImpl({
    ApiClient? client,
    SessionDataProvider? sessionDataProvider,
    PostDataProvider? postDataProvider,
  }) {
    this.sessionDataProvider = sessionDataProvider ?? SessionDataProviderImpl();
    final authInterceptor = AuthInterceptor(this.sessionDataProvider);
    this.client = client ?? ApiClientImpl([authInterceptor]);
    this.postDataProvider = postDataProvider ?? PostDataProviderImpl();
  }

  @override
  Future<void> create(Map<String, dynamic> data) async {
    await client.createPost(data);
  }

  @override
  Future<Map<String, dynamic>> createLike(int id) {
    return client.createLike(id);
  }

  @override
  Future<Map<String, dynamic>> deleteLike(int id) {
    return client.deleteLike(id);
  }

  @override
  Future<void> deletePost(int id) {
    return client.deletePost(id);
  }

  @override
  Future<List<Post>> getAllPosts(String username) async {
    final response = await client.getAllPosts(username);
    final data = response['data'];

    if (data is List) {
      final posts = data.map((e) => Post.fromJson(e)).toList();
      await postDataProvider.addAllPost(posts);
      return _sortByDateDesc(posts);
    }

    return [];
  }

  List<Post> _sortByDateDesc(List<Post> posts) {
    final items = List<Post>.from(posts);
    items.sort((a, b) => b.date.compareTo(a.date));
    return items;
  }

  @override
  Future<Post?> getPost(int id) async {
    final response = await client.getPost(id);
    final post = Post.fromJson(response);
    await postDataProvider.addPost(post);
    return post;
  }

  @override
  Future<Post> updatePost(int id, String caption) async {
    final response = await client.updatePost(id, caption);
    return Post.fromJson(response);
  }
}
