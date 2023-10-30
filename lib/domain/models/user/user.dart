import 'package:isar/isar.dart';
import 'package:json_annotation/json_annotation.dart';
part 'user.g.dart';

@JsonSerializable(createToJson: false)
@collection
class User {
  final Id id;
  final String name;
  final String email;
  final String username;
  final String picture;
  final bool private;
  final String bio;

  User({
    required this.id,
    this.name = '',
    this.email = '',
    this.username = '',
    this.picture = '',
    this.private = false,
    this.bio = '',
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
