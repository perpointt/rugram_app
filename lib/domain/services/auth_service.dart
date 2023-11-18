import 'package:rugram/data/api/api_client.dart';
import 'package:rugram/data/data_providers/session_data_provider.dart';
import 'package:rugram/data/data_providers/user_data_provider.dart';
import 'package:rugram/data/servies/auth_service.dart';
import 'package:rugram/domain/api/api_client.dart';
import 'package:rugram/domain/api/interceptors/auth_interceptor.dart';
import 'package:rugram/domain/data_providers/session_data_provider.dart';
import 'package:rugram/domain/data_providers/user_data_provider.dart';
import 'package:rugram/domain/models/session/session.dart';
import 'package:rugram/domain/models/user/user.dart';

class AuthServiceImpl implements AuthService {
  late final ApiClient client;
  late final UserDataProvider userDataProvider;
  late final SessionDataProvider sessionDataProvider;

  AuthServiceImpl({
    ApiClient? client,
    UserDataProvider? userDataProvider,
    SessionDataProvider? sessionDataProvider,
  }) {
    this.sessionDataProvider = sessionDataProvider ?? SessionDataProviderImpl();
    final authInterceptor = AuthInterceptor(this.sessionDataProvider);
    this.client = client ?? ApiClientImpl([authInterceptor]);
    this.userDataProvider = userDataProvider ?? UserDataProviderImpl();
  }

  @override
  Future<User> login(Map<String, dynamic> queryParameters) async {
    final tokenResponse = await client.login(queryParameters);
    final session = Session.fromJson(tokenResponse);
    await sessionDataProvider.addSession(session);

    final userResponse = await client.getUserFromSession();
    final user = User.fromJson(userResponse);
    await userDataProvider.addUser(user);

    await sessionDataProvider.addSession(session.copyWith(id: user.id));

    return user;
  }

  @override
  Future<User> register(Map<String, dynamic> data) async {
    final registerResponse = await client.register(data);
    final user = User.fromJson(registerResponse);
    await userDataProvider.addUser(user);

    final tokenResponse = await client.login(data);
    final session = Session.fromJson(tokenResponse);
    await sessionDataProvider.addSession(session.copyWith(id: user.id));

    return user;
  }

  @override
  Future<bool> isAuthenticated() async {
    final session = await sessionDataProvider.fetchSession();
    return session != null;
  }

  @override
  Future<void> logout() async {
    await userDataProvider.clear();
    await sessionDataProvider.clear();
  }
}
