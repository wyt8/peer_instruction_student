import 'package:peer_instruction_student/common/global.dart';
import 'package:peer_instruction_student/models/result.dart';
import 'package:peer_instruction_student/models/user/user.dart';
import 'package:peer_instruction_student/utils/base_request.dart';

class UserApi {
  static UserApi? _instance;

  factory UserApi() => _instance ?? UserApi._internal();

  static UserApi get instance => _instance ?? UserApi._internal();

  UserApi._internal();

  // Future<CourseList> getAllCourses() async {
  //   BaseRequest().openLog(responseBody: true);
  //   var result = await BaseRequest().request(
  //     "/students/1/courses");
  //   var res = Result<CourseList>.fromJson(
  //       result, (json) => CourseList.fromJson(json)).data;
  //   return res;
  // }
  Future<bool> modifyUserInfo({String? name, String? avatar, String? password}) async {
    var userId = Global.user.userId;
    var json = await BaseRequest().request(
      "/students/${userId ?? 0}",
      method: RequestMethod.put,
      data: {
        "name": name,
        "avatar": avatar,
        "password": password
      }
    );
    var res = Result<Null>.fromJson(json, (json) => null);
    return res.isSuccess;
  }

  Future<Result<User>> login(String email, String password) async {
    var json = await BaseRequest().request(
      "/login",
      method: RequestMethod.post,
      data: {
        "role": 3,
        "email": email,
        "password": password
      }
    );
    if(json["code"] == 0) {
      var res = Result<User>.fromJson(json, (json) => User.fromJson(json));
      res.data.email = email;
      return res;
    } else {
      return Result<User>.fromJson(json, (json) => User());
    }
  }

  Future<Result<User>> register(String email, String verifyCode, String password) async {
    var json = await BaseRequest().request(
      "/register",
      method: RequestMethod.post,
      data: {
        "role": 3,
        "email": email,
        "password": password,
        "verification_code": verifyCode
      }
    );

    if(json["code"] == 0) {
      var res = Result<User>.fromJson(json, (json) => User.fromJson(json));
      res.data.email = email;
      return res;
    } else {
      return Result<User>.fromJson(json, (json) => User());
    }
  }

  Future<bool> sendVerifyCode(String email) async {
    var json = await BaseRequest().request(
      "/email_verify",
      method: RequestMethod.post,
      data: {
        "role": 3,
        "email": email
      }
    );

    var res = Result<Null>.fromJson(json, (json) => null);
    return res.isSuccess;
  }

  Future<Result<User>> forgetPassword(String email, String verifyCode, String password) async {
    var json = await BaseRequest().request(
      "/modify_password",
      method: RequestMethod.post,
      data: {
        "role": 3,
        "email": email,
        "password": password,
        "verification_code": verifyCode
      }
    );

    if(json["code"] == 0) {
      var res = Result<User>.fromJson(json, (json) => User.fromJson(json));
      res.data.email = email;
      return res;
    } else {
      return Result<User>.fromJson(json, (json) => User());
    }
  }
}