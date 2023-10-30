import 'package:rugram/data/api/api_client.dart';
import 'package:rugram/data/data_providers/user_data_provider.dart';
import 'package:rugram/data/servies/auth_service.dart';
import 'package:rugram/domain/api/api_client.dart';
import 'package:rugram/domain/data_providers/user_data_provider.dart';
import 'package:rugram/domain/models/user/user.dart';

class AuthServiceImpl implements AuthService {
  late final ApiClient client;
  late final UserDataProvider userDataProvider;

  AuthServiceImpl({ApiClient? client, UserDataProvider? userDataProvider}) {
    this.client = client ?? ApiClientImpl();
    this.userDataProvider = userDataProvider ?? UserDataProviderImpl();
  }

  @override
  Future<User> login(Map<String, dynamic> queryParameters) async {
    final response = await client.login(queryParameters);
    return User.fromJson(response);
  }

  @override
  Future<User> register(Map<String, dynamic> queryParameters) async {
    final response = await client.register(queryParameters);
    return User.fromJson(response);
  }

  @override
  Future<bool> isAuthenticated() async {
    final user = await userDataProvider.fetchUser();
    return user != null;
  }
}
