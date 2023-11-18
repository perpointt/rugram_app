import 'package:isar/isar.dart';
import 'package:rugram/data/data_providers/session_data_provider.dart';
import 'package:rugram/domain/database/database_client.dart';
import 'package:rugram/domain/models/session/session.dart';

class SessionDataProviderImpl implements SessionDataProvider {
  final _client = DatabaseClientImpl();

  @override
  Future<Session?> fetchSession() async {
    final collection = await _client.instance.sessions.where().findAll();
    return collection.lastOrNull;
  }

  @override
  Future<void> addSession(Session session) async {
    await _client.instance.writeTxn(() async {
      await _client.instance.sessions.put(session);
    });
  }

  @override
  Future<void> clear() async {
    await _client.instance.writeTxn(() async {
      await _client.instance.sessions.clear();
    });
  }
}
