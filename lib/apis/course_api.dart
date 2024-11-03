import 'package:peer_instruction_student/models/course/course_list.dart';
import 'package:peer_instruction_student/models/result.dart';
import 'package:peer_instruction_student/utils/base_request.dart';

class CourseApi {
  static CourseApi? _instance;

  factory CourseApi() => _instance ?? CourseApi._internal();

  static CourseApi get instance => _instance ?? CourseApi._internal();

  CourseApi._internal();

  Future<CourseList> getAllCourses() async {
    var result = await BaseRequest().request(
      "/students/1/courses");
    var res = Result<CourseList>.fromJson(
        result, (json) => CourseList.fromJson(json)).data;
    return res;
  }
}