import 'package:rugram/domain/models/user/user.dart';

abstract class UserService {
  Future<User?> fetchUserFromCache();
  Future<User?> fetchUserFromApi();
}
