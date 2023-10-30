import 'package:rugram/domain/models/user/user.dart';

abstract class AuthService {
  Future<User> login(Map<String, dynamic> queryParameters);
  Future<User> register(Map<String, dynamic> queryParameters);
  Future<void> logout();
  Future<bool> isAuthenticated();
}
