import 'package:rugram/domain/models/token/token.dart';

abstract class TokenDataProvider {
  Future<Token?> fetchToken();
  Future<void> addToken(Token user);
  Future<void> clear();
}
