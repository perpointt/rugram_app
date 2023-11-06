import 'package:rugram/data/api/api_client.dart';
import 'package:rugram/data/data_providers/token_data_provider.dart';
import 'package:rugram/data/servies/post_service.dart';
import 'package:rugram/domain/api/api_client.dart';
import 'package:rugram/domain/api/interceptors/auth_interceptor.dart';
import 'package:rugram/domain/data_providers/token_data_provider.dart';

class PostServiceImpl implements PostService {
  late final ApiClient client;
  late final TokenDataProvider tokenDataProvider;

  PostServiceImpl({ApiClient? client, TokenDataProvider? tokenDataProvider}) {
    this.tokenDataProvider = tokenDataProvider ?? TokenDataProviderImpl();
    final authInterceptor = AuthInterceptor(this.tokenDataProvider);
    this.client = client ?? ApiClientImpl([authInterceptor]);
  }

  @override
  Future<void> create(Map<String, dynamic> data) async {
    await client.createPost(data);
  }
}
