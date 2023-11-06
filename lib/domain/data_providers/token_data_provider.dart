import 'package:isar/isar.dart';
import 'package:rugram/data/data_providers/token_data_provider.dart';
import 'package:rugram/domain/database/database_client.dart';
import 'package:rugram/domain/models/token/token.dart';

class TokenDataProviderImpl implements TokenDataProvider {
  final _client = DatabaseClientImpl();

  @override
  Future<Token?> fetchToken() async {
    final collection = await _client.instance.tokens.where().findAll();
    return collection.firstOrNull;
  }

  @override
  Future<void> addToken(Token user) async {
    await _client.instance.writeTxn(() async {
      await _client.instance.tokens.put(user);
    });
  }

  @override
  Future<void> clear() async {
    await _client.instance.writeTxn(() async {
      await _client.instance.tokens.clear();
    });
  }
}
