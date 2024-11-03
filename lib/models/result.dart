import 'package:json_annotation/json_annotation.dart';

part 'result.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class Result<T> {
  final int code;
  final String msg;
  final T data;

  Result({required this.msg, required this.data, required this.code});

  bool get isSuccess => code == 0;

  factory Result.fromJson(
          Map<String, dynamic> json, T Function(dynamic json) fromJsonT) =>
      _$ResultFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) =>
      _$ResultToJson(this, toJsonT);
}
