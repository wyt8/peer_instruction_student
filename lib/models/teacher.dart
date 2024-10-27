import 'package:json_annotation/json_annotation.dart';

part 'teacher.g.dart';

@JsonSerializable()
class Teacher {
  final int teacherId;
  final String teacherName;
  final String teacherAvatar;

  Teacher({required this.teacherId, required this.teacherName, required this.teacherAvatar});

  factory Teacher.fromJson(Map<String, dynamic> json) => _$TeacherFromJson(json);
  Map<String, dynamic> toJson() => _$TeacherToJson(this);
}