import 'package:rugram/domain/models/user/user.dart';

abstract class UserDataProvider {
  Future<User?> fetchUser();
  Future<void> addUser(User user);
  Future<void> clear();
}
