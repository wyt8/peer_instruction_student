// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'teacher.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Teacher _$TeacherFromJson(Map<String, dynamic> json) => Teacher(
      teacherId: (json['teacher_id'] as num).toInt(),
      teacherName: json['teacher_name'] as String,
      teacherAvatar: json['teacher_avatar'] as String,
    );

Map<String, dynamic> _$TeacherToJson(Teacher instance) => <String, dynamic>{
      'teacher_id': instance.teacherId,
      'teacher_name': instance.teacherName,
      'teacher_avatar': instance.teacherAvatar,
    };
