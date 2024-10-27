// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'teacher.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Teacher _$TeacherFromJson(Map<String, dynamic> json) => Teacher(
      teacherId: (json['teacherId'] as num).toInt(),
      teacherName: json['teacherName'] as String,
      teacherAvatar: json['teacherAvatar'] as String,
    );

Map<String, dynamic> _$TeacherToJson(Teacher instance) => <String, dynamic>{
      'teacherId': instance.teacherId,
      'teacherName': instance.teacherName,
      'teacherAvatar': instance.teacherAvatar,
    };
