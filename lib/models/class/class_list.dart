import 'package:json_annotation/json_annotation.dart';
import 'package:peer_instruction_student/models/class/class.dart';

part 'class_list.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ClassList {
  final List<Class> classes;

 ClassList({required this.classes});

  factory ClassList.fromJson(Map<String, dynamic> json) => _$ClassListFromJson(json);
  Map<String, dynamic> toJson() => _$ClassListToJson(this);
}