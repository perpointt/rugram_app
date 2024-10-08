import 'package:rugram/data/api/api_client.dart';
import 'package:rugram/data/data_providers/session_data_provider.dart';
import 'package:rugram/data/data_providers/user_data_provider.dart';
import 'package:rugram/data/servies/user_service.dart';
import 'package:rugram/domain/api/api_client.dart';
import 'package:rugram/domain/api/interceptors/auth_interceptor.dart';
import 'package:rugram/domain/data_providers/session_data_provider.dart';
import 'package:rugram/domain/data_providers/user_data_provider.dart';
import 'package:rugram/domain/models/user/user.dart';

class UserServiceImpl implements UserService {
  late final ApiClient client;
  late final UserDataProvider userDataProvider;
  late final SessionDataProvider sessionDataProvider;

  UserServiceImpl({
    UserDataProvider? userDataProvider,
    ApiClient? client,
    SessionDataProvider? sessionDataProvider,
  }) {
    this.sessionDataProvider = sessionDataProvider ?? SessionDataProviderImpl();
    final authInterceptor = AuthInterceptor(this.sessionDataProvider);
    this.client = client ?? ApiClientImpl([authInterceptor]);
    this.userDataProvider = userDataProvider ?? UserDataProviderImpl();
  }

  @override
  Future<User?> getUser(String username) async {
    final response = await client.getUser(username);
    final user = User.fromJson(response);
    await userDataProvider.addUser(user);
    return user;
  }

  @override
  Future<User?> getUserFromSession() async {
    final response = await client.getUserFromSession();
    final user = User.fromJson(response);
    await userDataProvider.addUser(user);
    return user;
  }
}
