import 'package:rugram/domain/models/user/user.dart';

abstract class UserService {
  Future<User?> getUser(String username);
  Future<User?> getUserFromSession();
}
