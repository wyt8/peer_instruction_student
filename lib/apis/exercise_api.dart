import 'package:peer_instruction_student/common/global.dart';
import 'package:peer_instruction_student/models/exercise/exercise.dart';
import 'package:peer_instruction_student/models/result.dart';
import 'package:peer_instruction_student/utils/base_request.dart';

class ExerciseApi {
  static ExerciseApi? _instance;

  factory ExerciseApi() => _instance ?? ExerciseApi._internal();

  static ExerciseApi get instance => _instance ?? ExerciseApi._internal();

  ExerciseApi._internal();

  Future<Result<ExerciseList>> getExercise(int courseId, int classId) async {
    var userId = Global.user.userId;
    var result = await BaseRequest().request(
        '/students/${userId ?? 0}/courses/$courseId/classes/$classId/exercises');
    return Result.fromJson(result, (json) => ExerciseList.fromJson(json));
  }

  Future<bool> submitExercise(int exerciseId, int option, int index) async {
    var userId = Global.user.userId;
    var result = await BaseRequest().request(
        '/students/${userId ?? 0}/exercises/$exerciseId',
        method: RequestMethod.post,
        data: {'option': option, 'index': index});
    return Result.fromJson(result, (json) => null).isSuccess;
  }
}
