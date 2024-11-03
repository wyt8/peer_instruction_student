// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CourseList _$CourseListFromJson(Map<String, dynamic> json) => CourseList(
      courses: (json['courses'] as List<dynamic>)
          .map((e) => Course.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CourseListToJson(CourseList instance) =>
    <String, dynamic>{
      'courses': instance.courses,
    };
