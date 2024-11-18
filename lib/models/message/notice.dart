import 'package:json_annotation/json_annotation.dart';
import 'package:peer_instruction_student/models/course/course.dart';

part 'notice.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Notice {
  final int noticeId;
  final String content;
  final DateTime sendTime;
  final bool isReceived;
  final Course course;

  Notice(
      {required this.noticeId,
      required this.content,
      required this.sendTime,
      required this.isReceived,
      required this.course});

  factory Notice.fromJson(Map<String, dynamic> json) => _$NoticeFromJson(json);
  Map<String, dynamic> toJson() => _$NoticeToJson(this);
}
