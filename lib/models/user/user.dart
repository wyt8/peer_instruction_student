import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class User {
  int? userId;
  String? userName;
  String? userAvatar;
  String? token;
  String? email;

  User({this.userId, this.userName, this.userAvatar, this.email, this.token});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}