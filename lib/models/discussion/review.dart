import 'package:json_annotation/json_annotation.dart';

part 'review.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ReviewList {
  final List<Review> reviews;

  ReviewList({required this.reviews});

  factory ReviewList.fromJson(Map<String, dynamic> json) =>
      _$ReviewListFromJson(json);
  Map<String, dynamic> toJson() => _$ReviewListToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Review {
  final int reviewId;
  final String reviewContent;
  final DateTime createdTime;
  final Reviewer reviewer;

  Review({
    required this.reviewId,
    required this.reviewContent,
    required this.createdTime,
    required this.reviewer,
  });

  factory Review.fromJson(Map<String, dynamic> json) => _$ReviewFromJson(json);
  Map<String, dynamic> toJson() => _$ReviewToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Reviewer {
  final int userId;
  final String userName;
  final String userAvatar;
  final int userRole;

  Reviewer({
    required this.userId,
    required this.userName,
    required this.userAvatar,
    required this.userRole,
  });

  factory Reviewer.fromJson(Map<String, dynamic> json) =>
      _$ReviewerFromJson(json);
  Map<String, dynamic> toJson() => _$ReviewerToJson(this);
}
