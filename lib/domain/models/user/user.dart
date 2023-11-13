import 'package:isar/isar.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:rugram/domain/extensions/extensions.dart';
part 'user.g.dart';

@JsonSerializable(createToJson: false)
@collection
class User {
  final Id id;
  final String name;
  final String email;
  final String username;
  @JsonKey(fromJson: _pictureFromJson)
  final String avatar;
  final bool private;
  final String bio;

  User({
    required this.id,
    this.name = '',
    this.email = '',
    this.username = '',
    this.avatar = '',
    this.private = false,
    this.bio = '',
  });

  static String _pictureFromJson(String? value) {
    final isNotImage = !(value?.isImage ?? false);
    if (value == null || isNotImage) return '';
    return value;
  }

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  @override
  String toString() {
    return 'User{id: $id, name: $name, email: $email, username: $username, avatar: $avatar, private: $private, bio: $bio}';
  }
}
