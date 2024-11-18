// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReviewList _$ReviewListFromJson(Map<String, dynamic> json) => ReviewList(
      reviews: (json['reviews'] as List<dynamic>)
          .map((e) => Review.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ReviewListToJson(ReviewList instance) =>
    <String, dynamic>{
      'reviews': instance.reviews,
    };

Review _$ReviewFromJson(Map<String, dynamic> json) => Review(
      reviewId: (json['review_id'] as num).toInt(),
      reviewContent: json['review_content'] as String,
      createdTime: DateTime.parse(json['created_time'] as String),
      reviewer: Reviewer.fromJson(json['reviewer'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ReviewToJson(Review instance) => <String, dynamic>{
      'review_id': instance.reviewId,
      'review_content': instance.reviewContent,
      'created_time': instance.createdTime.toIso8601String(),
      'reviewer': instance.reviewer,
    };

Reviewer _$ReviewerFromJson(Map<String, dynamic> json) => Reviewer(
      userId: (json['user_id'] as num).toInt(),
      userName: json['user_name'] as String,
      userAvatar: json['user_avatar'] as String,
      userRole: (json['user_role'] as num).toInt(),
    );

Map<String, dynamic> _$ReviewerToJson(Reviewer instance) => <String, dynamic>{
      'user_id': instance.userId,
      'user_name': instance.userName,
      'user_avatar': instance.userAvatar,
      'user_role': instance.userRole,
    };
