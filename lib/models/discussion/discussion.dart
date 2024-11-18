import 'package:json_annotation/json_annotation.dart';

part 'discussion.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class DiscussionList {
  final List<Discussion> discussions;

  DiscussionList({required this.discussions});

  factory DiscussionList.fromJson(Map<String, dynamic> json) => _$DiscussionListFromJson(json);
  Map<String, dynamic> toJson() => _$DiscussionListToJson(this);
}


@JsonSerializable(fieldRename: FieldRename.snake)
class Discussion {
  final int discussionId;
  final String discussionTitle;
  final String discussionContent;
  final DateTime createdTime;
  final DiscussionPoster poster;
  
  Discussion({
    required this.discussionId,
    required this.discussionTitle,
    required this.discussionContent,
    required this.createdTime,
    required this.poster,
  });

  factory Discussion.fromJson(Map<String, dynamic> json) => _$DiscussionFromJson(json);
  Map<String, dynamic> toJson() => _$DiscussionToJson(this);
}


@JsonSerializable(fieldRename: FieldRename.snake)
class DiscussionPoster {
  final int userId;
  final String userName;
  final String userAvatar;
  final int userRole;

  DiscussionPoster({
    required this.userId,
    required this.userName,
    required this.userAvatar,
    required this.userRole,
  });

  factory DiscussionPoster.fromJson(Map<String, dynamic> json) => _$DiscussionPosterFromJson(json);
  Map<String, dynamic> toJson() => _$DiscussionPosterToJson(this);
}