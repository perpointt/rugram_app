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
}
