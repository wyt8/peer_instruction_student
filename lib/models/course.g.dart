// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Course _$CourseFromJson(Map<String, dynamic> json) => Course(
      Teacher.fromJson(json['teacher'] as Map<String, dynamic>),
      courseId: (json['courseId'] as num).toInt(),
      courseName: json['courseName'] as String,
      courseImageUrl: json['courseImageUrl'] as String,
      attendTime: DateTime.parse(json['attendTime'] as String),
    );

Map<String, dynamic> _$CourseToJson(Course instance) => <String, dynamic>{
      'courseId': instance.courseId,
      'courseName': instance.courseName,
      'courseImageUrl': instance.courseImageUrl,
      'attendTime': instance.attendTime.toIso8601String(),
      'teacher': instance.teacher,
    };
