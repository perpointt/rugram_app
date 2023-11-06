import 'package:isar/isar.dart';
import 'package:json_annotation/json_annotation.dart';
part 'post.g.dart';

@JsonSerializable(createToJson: false)
@collection
class Post {
  @JsonKey(includeFromJson: false)
  final Id id = Isar.autoIncrement;

  @JsonKey(name: 'token')
  final String value;

  Post({this.value = ''});

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);

  @override
  String toString() {
    return value;
  }
}
