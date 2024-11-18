// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_statistic.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CourseStatistic _$CourseStatisticFromJson(Map<String, dynamic> json) =>
    CourseStatistic(
      classNum: (json['class_num'] as num).toInt(),
      attendenceNum: (json['attendence_num'] as num).toInt(),
      discussionNum: (json['discussion_num'] as num).toInt(),
      reviewNum: (json['review_num'] as num).toInt(),
      classStatistics: (json['class_statistics'] as List<dynamic>)
          .map((e) => ClassStatistic.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CourseStatisticToJson(CourseStatistic instance) =>
    <String, dynamic>{
      'class_num': instance.classNum,
      'attendence_num': instance.attendenceNum,
      'discussion_num': instance.discussionNum,
      'review_num': instance.reviewNum,
      'class_statistics': instance.classStatistics,
    };

ClassStatistic _$ClassStatisticFromJson(Map<String, dynamic> json) =>
    ClassStatistic(
      exerciseNum: (json['exercise_num'] as num).toInt(),
      firstRightNum: (json['first_right_num'] as num).toInt(),
      secondRightNum: (json['second_right_num'] as num).toInt(),
    );

Map<String, dynamic> _$ClassStatisticToJson(ClassStatistic instance) =>
    <String, dynamic>{
      'exercise_num': instance.exerciseNum,
      'first_right_num': instance.firstRightNum,
      'second_right_num': instance.secondRightNum,
    };
