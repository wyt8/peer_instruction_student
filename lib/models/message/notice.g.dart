// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notice.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Notice _$NoticeFromJson(Map<String, dynamic> json) => Notice(
      noticeId: (json['notice_id'] as num).toInt(),
      content: json['content'] as String,
      sendTime: DateTime.parse(json['send_time'] as String),
      isReceived: json['is_received'] as bool,
      course: Course.fromJson(json['course'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$NoticeToJson(Notice instance) => <String, dynamic>{
      'notice_id': instance.noticeId,
      'content': instance.content,
      'send_time': instance.sendTime.toIso8601String(),
      'is_received': instance.isReceived,
      'course': instance.course,
    };
