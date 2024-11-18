import 'package:peer_instruction_student/common/global.dart';
import 'package:peer_instruction_student/models/course/course.dart';
import 'package:peer_instruction_student/models/course/course_list.dart';
import 'package:peer_instruction_student/models/course/course_statistic.dart';
import 'package:peer_instruction_student/models/result.dart';
import 'package:peer_instruction_student/utils/base_request.dart';

class CourseApi {
  static CourseApi? _instance;

  factory CourseApi() => _instance ?? CourseApi._internal();

  static CourseApi get instance => _instance ?? CourseApi._internal();

  CourseApi._internal();

  Future<Result<CourseList>> getAllCourses() async {
    var userId = Global.user.userId;
    var result =
        await BaseRequest().request("/students/${userId ?? 0}/courses");
    var res = Result<CourseList>.fromJson(
        result, (json) => CourseList.fromJson(json));
    return res;
  }

  Future<Result<Course>> addCourse(String courseCode) async {
    var userId = Global.user.userId;
    var result = await BaseRequest().request("/students/${userId ?? 0}/courses",
        method: RequestMethod.post, data: {"course_code": courseCode});
    var res = Result<Course>.fromJson(result, (json) => Course.fromJson(json));
    return res;
  }

  Future<Result<CourseStatistic>> getCourseStatistic(int courseId) async {
    var userId = Global.user.userId;
    var result = await BaseRequest()
        .request("/courses/$courseId/statistics/students/${userId ?? 0}");
    var res = Result<CourseStatistic>.fromJson(
        result, (json) => CourseStatistic.fromJson(json));
    return res;
  }
}
