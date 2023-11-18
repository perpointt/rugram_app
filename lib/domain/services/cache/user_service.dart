import 'package:rugram/data/api/api_client.dart';
import 'package:rugram/data/data_providers/session_data_provider.dart';
import 'package:rugram/data/data_providers/user_data_provider.dart';
import 'package:rugram/data/servies/user_service.dart';
import 'package:rugram/domain/api/api_client.dart';
import 'package:rugram/domain/api/interceptors/auth_interceptor.dart';
import 'package:rugram/domain/data_providers/session_data_provider.dart';
import 'package:rugram/domain/data_providers/user_data_provider.dart';
import 'package:rugram/domain/models/user/user.dart';

class CacheUserServiceImpl implements UserService {
  late final UserDataProvider userDataProvider;
  late final SessionDataProvider sessionDataProvider;

  CacheUserServiceImpl({
    UserDataProvider? userDataProvider,
    SessionDataProvider? sessionDataProvider,
  }) {
    this.userDataProvider = userDataProvider ?? UserDataProviderImpl();
    this.sessionDataProvider = sessionDataProvider ?? SessionDataProviderImpl();
  }

  @override
  Future<User?> getUser(String username) async {
    return userDataProvider.fetchUser(username);
  }

  @override
  Future<User?> getUserFromSession() async {
    final session = await sessionDataProvider.fetchSession();
    final id = session?.id;
    if (id == null) return null;
    return userDataProvider.fetchUserById(id);
  }
}
