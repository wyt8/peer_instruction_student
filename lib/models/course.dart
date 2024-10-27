import 'package:json_annotation/json_annotation.dart';
import 'package:peer_instruction_student/models/teacher.dart';

part 'course.g.dart';

@JsonSerializable()
class Course {
  final int courseId;
  final String courseName;
  final String courseImageUrl;
  final DateTime attendTime;
  final Teacher teacher;

  Course(this.teacher, {required this.courseId, required this.courseName, required this.courseImageUrl, required this.attendTime});

  factory Course.fromJson(Map<String, dynamic> json) => _$CourseFromJson(json);
  Map<String, dynamic> toJson() => _$CourseToJson(this);
}