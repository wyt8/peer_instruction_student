import 'package:json_annotation/json_annotation.dart';

part 'exercise.g.dart';


@JsonSerializable(fieldRename: FieldRename.snake)
class ExerciseList {
  final List<Exercise> exercises;
  ExerciseList({required this.exercises});
  factory ExerciseList.fromJson(Map<String, dynamic> json) => _$ExerciseListFromJson(json);
  Map<String, dynamic> toJson() => _$ExerciseListToJson(this);
}


@JsonSerializable(fieldRename: FieldRename.snake)
class Exercise {
  final int exerciseId;
  final String content;
  final List<String> options;
  final Answer firstAnswer;
  final Answer secondAnswer;

  Exercise({required this.exerciseId, required this.content, required this.options, required this.firstAnswer, required this.secondAnswer});

  factory Exercise.fromJson(Map<String, dynamic> json) => _$ExerciseFromJson(json);
  Map<String, dynamic> toJson() => _$ExerciseToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Answer {
  final int status;
  final DateTime? startTime;
  final int? limitTime;
  final int? myOption;
  final int? rightOption;

  Answer({required this.status, this.startTime, this.limitTime, this.myOption, this.rightOption});

  factory Answer.fromJson(Map<String, dynamic> json) => _$AnswerFromJson(json);
  Map<String, dynamic> toJson() => _$AnswerToJson(this);
}

