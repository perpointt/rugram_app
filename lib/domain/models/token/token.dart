import 'package:isar/isar.dart';
import 'package:json_annotation/json_annotation.dart';
part 'token.g.dart';

@JsonSerializable(createToJson: false)
@collection
class Token {
  @JsonKey(includeFromJson: false)
  final Id id = Isar.autoIncrement;

  @JsonKey(name: 'token')
  final String value;

  Token({this.value = ''});

  factory Token.fromJson(Map<String, dynamic> json) => _$TokenFromJson(json);

  @override
  String toString() {
    return value;
  }
}
