import 'package:peer_instruction_student/common/global.dart';
import 'package:peer_instruction_student/models/class/class.dart';
import 'package:peer_instruction_student/models/class/class_list.dart';
import 'package:peer_instruction_student/models/result.dart';
import 'package:peer_instruction_student/utils/base_request.dart';

class ClassApi {
  static ClassApi? _instance;

  factory ClassApi() => _instance ?? ClassApi._internal();

  static ClassApi get instance => _instance ?? ClassApi._internal();

  ClassApi._internal();

  Future<Result<ClassList>> getClassList(int courseId) async {
    var userId = Global.user.userId;
    var result = await BaseRequest()
        .request('/students/${userId ?? 0}/courses/$courseId/classes');
    return Result.fromJson(result, (json) => ClassList.fromJson(json));
  }

  Future<bool> isAttended(int courseId, int classId) async {
    // BaseRequest().openLog(requestBody: true, responseBody: true);
    var userId = Global.user.userId;
    var result = await BaseRequest()
        .request('/students/${userId ?? 0}/courses/$courseId/classes/$classId');

    var res =
        Result.fromJson(result, (json) => Class.fromJson(json)).data.isAttended;
    return res ?? false;
  }

  Future<bool> checkIn(int courseId, int classId, String data) async {
    var userId = Global.user.userId;
    var result = await BaseRequest().request(
        '/students/${userId ?? 0}/courses/$courseId/classes/$classId',
        method: RequestMethod.post, data: {
          'data': data
        });
    return Result.fromJson(result, (json) => null).isSuccess;
  }
}
