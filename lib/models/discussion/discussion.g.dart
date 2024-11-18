// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'discussion.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DiscussionList _$DiscussionListFromJson(Map<String, dynamic> json) =>
    DiscussionList(
      discussions: (json['discussions'] as List<dynamic>)
          .map((e) => Discussion.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DiscussionListToJson(DiscussionList instance) =>
    <String, dynamic>{
      'discussions': instance.discussions,
    };

Discussion _$DiscussionFromJson(Map<String, dynamic> json) => Discussion(
      discussionId: (json['discussion_id'] as num).toInt(),
      discussionTitle: json['discussion_title'] as String,
      discussionContent: json['discussion_content'] as String,
      createdTime: DateTime.parse(json['created_time'] as String),
      poster: DiscussionPoster.fromJson(json['poster'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DiscussionToJson(Discussion instance) =>
    <String, dynamic>{
      'discussion_id': instance.discussionId,
      'discussion_title': instance.discussionTitle,
      'discussion_content': instance.discussionContent,
      'created_time': instance.createdTime.toIso8601String(),
      'poster': instance.poster,
    };

DiscussionPoster _$DiscussionPosterFromJson(Map<String, dynamic> json) =>
    DiscussionPoster(
      userId: (json['user_id'] as num).toInt(),
      userName: json['user_name'] as String,
      userAvatar: json['user_avatar'] as String,
      userRole: (json['user_role'] as num).toInt(),
    );

Map<String, dynamic> _$DiscussionPosterToJson(DiscussionPoster instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'user_name': instance.userName,
      'user_avatar': instance.userAvatar,
      'user_role': instance.userRole,
    };
