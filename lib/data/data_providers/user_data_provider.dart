import 'package:rugram/domain/models/user/user.dart';

abstract class UserDataProvider {
  Future<User?> fetchUser();
}
