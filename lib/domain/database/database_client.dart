import 'package:isar/isar.dart';
import 'package:rugram/data/database/database_client.dart';
import 'package:rugram/domain/models/token/token.dart';
import 'package:rugram/domain/models/user/user.dart';

class DatabaseClientImpl implements DatabaseClient {
  Isar get instance => _instance;

  static late final Isar _instance;

  @override
  Future<void> open(String path) async {
    _instance = await Isar.open(
      [UserSchema, TokenSchema],
      directory: path,
    );
  }
}
