import 'package:rugram/domain/models/user/user.dart';

abstract class UserDataProvider {
  Future<User?> fetchUser(String username);
  Future<User?> fetchUserById(int id);
  Future<void> addUser(User user);
  Future<void> clear();
}
