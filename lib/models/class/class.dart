import 'package:json_annotation/json_annotation.dart';

part 'class.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Class {
  final int classId;
  final String className;
  final DateTime startTime;
  final bool? isAttended;

 Class({required this.classId, required this.className, required this.startTime, this.isAttended});

  factory Class.fromJson(Map<String, dynamic> json) => _$ClassFromJson(json);
  Map<String, dynamic> toJson() => _$ClassToJson(this);
}