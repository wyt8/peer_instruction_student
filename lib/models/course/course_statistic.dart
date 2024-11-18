import 'package:json_annotation/json_annotation.dart';

part 'course_statistic.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class CourseStatistic {
  final int classNum;
  final int attendenceNum;
  final int discussionNum;
  final int reviewNum;
  final List<ClassStatistic> classStatistics;

  CourseStatistic({required this.classNum, required this.attendenceNum, required this.discussionNum, required this.reviewNum, required this.classStatistics});

  factory CourseStatistic.fromJson(Map<String, dynamic> json) => _$CourseStatisticFromJson(json);
  Map<String, dynamic> toJson() => _$CourseStatisticToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class ClassStatistic {
  final int exerciseNum;
  final int firstRightNum;
  final int secondRightNum;

  ClassStatistic({required this.exerciseNum, required this.firstRightNum, required this.secondRightNum});

  factory ClassStatistic.fromJson(Map<String, dynamic> json) => _$ClassStatisticFromJson(json);
  Map<String, dynamic> toJson() => _$ClassStatisticToJson(this);

}