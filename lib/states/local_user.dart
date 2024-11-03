import 'package:flutter/foundation.dart';
import 'package:peer_instruction_student/common/global.dart';
import 'package:peer_instruction_student/models/user/user.dart';

class LocalUser extends ChangeNotifier {
  final User _user = Global.user;

  int? get userId => _user.userId;
  String? get userName => _user.userName;
  String? get userAvatar => _user.userAvatar;
  String? get token => _user.token;
  String? get email => _user.email;

  // 用户是否登录
  bool get isLogin => token != null;

  /// 清除用户信息，用于退出登录等
  void clear() {
    _user.userId = null;
    _user.userName = null;
    _user.userAvatar = null;
    _user.token = null;
    _user.email = null;
    Global.save();
    notifyListeners();
  }

  void setUser(User user) {
    _user.userId = user.userId;
    _user.userName = user.userName;
    _user.userAvatar = user.userAvatar;
    _user.token = user.token;
    _user.email = user.email;
    Global.save();
    notifyListeners();
  }

  set userName(String? value) {
    if(value != userName) {
      _user.userName = value;
      Global.save();
      notifyListeners();
    }
  }

  set userAvatar(String? value) {
    if (value != userAvatar) {
      _user.userAvatar = value;
      Global.save();
      notifyListeners();
    }
  }

  set token(String? value) {
    if(value != token) {
      _user.token = value;
      Global.save();
      notifyListeners();
    }
  }
}