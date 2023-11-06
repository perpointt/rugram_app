import 'package:rugram/data/api/api_client.dart';
import 'package:rugram/data/data_providers/token_data_provider.dart';
import 'package:rugram/data/data_providers/user_data_provider.dart';
import 'package:rugram/data/servies/auth_service.dart';
import 'package:rugram/domain/api/api_client.dart';
import 'package:rugram/domain/api/interceptors/auth_interceptor.dart';
import 'package:rugram/domain/data_providers/token_data_provider.dart';
import 'package:rugram/domain/data_providers/user_data_provider.dart';
import 'package:rugram/domain/models/token/token.dart';
import 'package:rugram/domain/models/user/user.dart';

class AuthServiceImpl implements AuthService {
  late final ApiClient client;
  late final UserDataProvider userDataProvider;
  late final TokenDataProvider tokenDataProvider;

  AuthServiceImpl({
    ApiClient? client,
    UserDataProvider? userDataProvider,
    TokenDataProvider? tokenDataProvider,
  }) {
    this.tokenDataProvider = tokenDataProvider ?? TokenDataProviderImpl();
    final authInterceptor = AuthInterceptor(this.tokenDataProvider);
    this.client = client ?? ApiClientImpl([authInterceptor]);
    this.userDataProvider = userDataProvider ?? UserDataProviderImpl();
  }

  @override
  Future<User> login(Map<String, dynamic> queryParameters) async {
    final tokenResponse = await client.login(queryParameters);
    final token = Token.fromJson(tokenResponse);
    await tokenDataProvider.addToken(token);

    final userResponse = await client.getUser(queryParameters['username']);
    final user = User.fromJson(userResponse);
    await userDataProvider.addUser(user);

    return user;
  }

  @override
  Future<User> register(Map<String, dynamic> data) async {
    final registerResponse = await client.register(data);
    final user = User.fromJson(registerResponse);
    await userDataProvider.addUser(user);

    final tokenResponse = await client.login(data);
    final token = Token.fromJson(tokenResponse);
    await tokenDataProvider.addToken(token);

    return user;
  }

  @override
  Future<bool> isAuthenticated() async {
    final token = await tokenDataProvider.fetchToken();
    return token != null;
  }

  @override
  Future<void> logout() async {
    await userDataProvider.clear();
    await tokenDataProvider.clear();
  }
}
