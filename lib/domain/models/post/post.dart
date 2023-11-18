import 'package:isar/isar.dart';
import 'package:json_annotation/json_annotation.dart';
part 'post.g.dart';

@JsonSerializable()
@collection
class Post {
  final Id id;
  @JsonKey(name: 'is_liked', defaultValue: false)
  final bool isLiked;
  final int likes;
  final DateTime date;
  final String caption;
  @Index(type: IndexType.value)
  final String username;
  final List<String> filenames;

  Post({
    required this.id,
    this.isLiked = false,
    this.likes = 0,
    required this.date,
    this.caption = '',
    this.username = '',
    this.filenames = const <String>[],
  });

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);

  @override
  String toString() {
    return 'Post{id: $id, isLiked: $isLiked, likes: $likes, date: $date, caption: $caption, username: $username, filenames: $filenames}';
  }

  Post copyWith({
    Id? id,
    bool? isLiked,
    int? likes,
    DateTime? date,
    String? caption,
    String? username,
    List<String>? filenames,
  }) {
    return Post(
      id: id ?? this.id,
      isLiked: isLiked ?? this.isLiked,
      likes: likes ?? this.likes,
      date: date ?? this.date,
      caption: caption ?? this.caption,
      username: username ?? this.username,
      filenames: filenames ?? this.filenames,
    );
  }
}
