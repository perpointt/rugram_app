import 'package:isar/isar.dart';
import 'package:rugram/data/database/database_client.dart';
import 'package:rugram/domain/models/user/user.dart';

abstract class UserDataProvider {
  Future<User?> fetchUser();
}
