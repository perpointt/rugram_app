import 'package:isar/isar.dart';
import 'package:rugram/data/data_providers/user_data_provider.dart';
import 'package:rugram/domain/database/database_client.dart';
import 'package:rugram/domain/models/user/user.dart';

class UserDataProviderImpl implements UserDataProvider {
  final _client = DatabaseClientImpl();

  @override
  Future<User?> fetchUser() async {
    final collection = await _client.instance.users.where().findAll();
    return collection.firstOrNull;
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
