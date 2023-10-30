import 'package:rugram/data/api/api_client.dart';
import 'package:rugram/data/data_providers/user_data_provider.dart';
import 'package:rugram/data/servies/user_service.dart';
import 'package:rugram/domain/api/api_client.dart';
import 'package:rugram/domain/data_providers/user_data_provider.dart';
import 'package:rugram/domain/models/user/user.dart';

class UserServiceImpl implements UserService {
  late final ApiClient client;
  late final UserDataProvider userDataProvider;

  UserServiceImpl({
    UserDataProvider? userDataProvider,
    ApiClient? client,
  }) {
    this.client = client ?? ApiClientImpl();
    this.userDataProvider = userDataProvider ?? UserDataProviderImpl();
  }

  @override
  Future<User?> fetchUserFromCache() {
    return userDataProvider.fetchUser();
  }

  @override
  Future<User?> fetchUserFromApi() {
    throw UnimplementedError();
  }
}
