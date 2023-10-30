import 'package:rugram/data/data_providers/user_data_provider.dart';
import 'package:rugram/data/database/database_client.dart';
import 'package:rugram/domain/database/database_client.dart';
import 'package:rugram/domain/models/user/user.dart';

class UserDataProviderImpl implements UserDataProvider {
  late final DatabaseClient client;

  UserDataProviderImpl({DatabaseClient? client}) {
    this.client = client ?? DatabaseClientImpl();
  }

  @override
  Future<User?> fetchUser() async {
    final collection = await client.instance.users.where().findAll();
    return collection.firstOrNull;
  }
}
