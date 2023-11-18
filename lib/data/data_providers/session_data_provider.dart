import 'package:rugram/domain/models/session/session.dart';

abstract class SessionDataProvider {
  Future<Session?> fetchSession();
  Future<void> addSession(Session session);
  Future<void> clear();
}
