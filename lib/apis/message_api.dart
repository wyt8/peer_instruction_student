import 'package:peer_instruction_student/common/global.dart';
import 'package:peer_instruction_student/models/message/notice_list.dart';
import 'package:peer_instruction_student/models/result.dart';
import 'package:peer_instruction_student/utils/base_request.dart';

class MessageApi {
  static MessageApi? _instance;

  factory MessageApi() => _instance ?? MessageApi._internal();

  static MessageApi get instance => _instance ?? MessageApi._internal();

  MessageApi._internal();

  Future<NoticeList> getMessageList(int lastNoticeId, int num) async {
    var userId = Global.user.userId;
    var result = await BaseRequest().request("/students/${userId ?? 0}/notices");
        // queryParameters: {"last_notice_id": lastNoticeId, "num": num},
        
    var res =
        Result<NoticeList>.fromJson(result, (json) => NoticeList.fromJson(json))
            .data;
    return res;
  }

  Future<bool> markNoticeRead(int noticeId) async {
    var userId = Global.user.userId;
    var result = await BaseRequest().request(
        "/students/${userId ?? 0}/notices/$noticeId/read",
        method: RequestMethod.put);
    var res = Result.fromJson(result, (json) => null);
    return res.isSuccess;
  }
}
