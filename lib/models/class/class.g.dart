// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'class.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Class _$ClassFromJson(Map<String, dynamic> json) => Class(
      classId: (json['class_id'] as num).toInt(),
      className: json['class_name'] as String,
      startTime: DateTime.parse(json['start_time'] as String),
      isAttended: json['is_attended'] as bool?,
    );

Map<String, dynamic> _$ClassToJson(Class instance) => <String, dynamic>{
      'class_id': instance.classId,
      'class_name': instance.className,
      'start_time': instance.startTime.toIso8601String(),
      'is_attended': instance.isAttended,
    };
