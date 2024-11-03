import 'package:json_annotation/json_annotation.dart';
import 'package:peer_instruction_student/models/course/course.dart';

part 'course_list.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class CourseList {
  final List<Course> courses;

  CourseList({required this.courses});

  factory CourseList.fromJson(Map<String, dynamic> json) => _$CourseListFromJson(json);
  Map<String, dynamic> toJson() => _$CourseListToJson(this);
}