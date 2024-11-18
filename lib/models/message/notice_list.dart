import 'package:json_annotation/json_annotation.dart';
import 'package:peer_instruction_student/models/message/notice.dart';

part 'notice_list.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class NoticeList {
  final List<Notice> notices;

  NoticeList({required this.notices});

  factory NoticeList.fromJson(Map<String, dynamic> json) =>
      _$NoticeListFromJson(json);
  Map<String, dynamic> toJson() => _$NoticeListToJson(this);
}
