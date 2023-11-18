import 'package:isar/isar.dart';
import 'package:json_annotation/json_annotation.dart';
part 'session.g.dart';

@JsonSerializable(createToJson: false)
@collection
class Session {
  @JsonKey(includeFromJson: false)
  final Id id;
  final String token;

  Session({this.id = -1000000, this.token = ''});

  factory Session.fromJson(Map<String, dynamic> json) =>
      _$SessionFromJson(json);

  Session copyWith({
    Id? id,
    String? token,
  }) {
    return Session(
      id: id ?? this.id,
      token: token ?? this.token,
    );
  }
}
