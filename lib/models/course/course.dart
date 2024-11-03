import 'package:json_annotation/json_annotation.dart';
import 'package:peer_instruction_student/models/user/teacher.dart';

part 'course.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Course {
  final int courseId;
  final String courseName;
  final String courseImageUrl;
  final DateTime joinTime;
  final Teacher teacher;

  Course(this.teacher, {required this.courseId, required this.courseName, required this.courseImageUrl, required this.joinTime});

  factory Course.fromJson(Map<String, dynamic> json) => _$CourseFromJson(json);
  Map<String, dynamic> toJson() => _$CourseToJson(this);
}