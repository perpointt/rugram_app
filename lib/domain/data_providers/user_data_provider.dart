import 'package:isar/isar.dart';
import 'package:rugram/data/data_providers/user_data_provider.dart';
import 'package:rugram/domain/database/database_client.dart';
import 'package:rugram/domain/models/user/user.dart';

class UserDataProviderImpl implements UserDataProvider {
  final _client = DatabaseClientImpl();

  @override
  Future<User?> fetchUser(String username) async {
    final user = await _client.instance.users
        .where()
        .usernameEqualTo(username)
        .findFirst();
    return user;
  }

  @override
  Future<User?> fetchUserById(int id) {
    return _client.instance.users.get(id);
  }

  @override
  Future<void> addUser(User user) async {
    await _client.instance.writeTxn(() async {
      await _client.instance.users.put(user);
    });
  }

  @override
  Future<void> clear() async {
    await _client.instance.writeTxn(() async {
      await _client.instance.users.clear();
    });
  }
}
