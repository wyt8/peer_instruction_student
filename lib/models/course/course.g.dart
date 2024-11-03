// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Course _$CourseFromJson(Map<String, dynamic> json) => Course(
      Teacher.fromJson(json['teacher'] as Map<String, dynamic>),
      courseId: (json['course_id'] as num).toInt(),
      courseName: json['course_name'] as String,
      courseImageUrl: json['course_image_url'] as String,
      joinTime: DateTime.parse(json['join_time'] as String),
    );

Map<String, dynamic> _$CourseToJson(Course instance) => <String, dynamic>{
      'course_id': instance.courseId,
      'course_name': instance.courseName,
      'course_image_url': instance.courseImageUrl,
      'join_time': instance.joinTime.toIso8601String(),
      'teacher': instance.teacher,
    };
