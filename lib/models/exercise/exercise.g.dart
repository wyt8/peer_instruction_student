// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExerciseList _$ExerciseListFromJson(Map<String, dynamic> json) => ExerciseList(
      exercises: (json['exercises'] as List<dynamic>)
          .map((e) => Exercise.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ExerciseListToJson(ExerciseList instance) =>
    <String, dynamic>{
      'exercises': instance.exercises,
    };

Exercise _$ExerciseFromJson(Map<String, dynamic> json) => Exercise(
      exerciseId: (json['exercise_id'] as num).toInt(),
      content: json['content'] as String,
      options:
          (json['options'] as List<dynamic>).map((e) => e as String).toList(),
      firstAnswer:
          Answer.fromJson(json['first_answer'] as Map<String, dynamic>),
      secondAnswer:
          Answer.fromJson(json['second_answer'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ExerciseToJson(Exercise instance) => <String, dynamic>{
      'exercise_id': instance.exerciseId,
      'content': instance.content,
      'options': instance.options,
      'first_answer': instance.firstAnswer,
      'second_answer': instance.secondAnswer,
    };

Answer _$AnswerFromJson(Map<String, dynamic> json) => Answer(
      status: (json['status'] as num).toInt(),
      startTime: json['start_time'] == null
          ? null
          : DateTime.parse(json['start_time'] as String),
      limitTime: (json['limit_time'] as num?)?.toInt(),
      myOption: (json['my_option'] as num?)?.toInt(),
      rightOption: (json['right_option'] as num?)?.toInt(),
    );

Map<String, dynamic> _$AnswerToJson(Answer instance) => <String, dynamic>{
      'status': instance.status,
      'start_time': instance.startTime?.toIso8601String(),
      'limit_time': instance.limitTime,
      'my_option': instance.myOption,
      'right_option': instance.rightOption,
    };
