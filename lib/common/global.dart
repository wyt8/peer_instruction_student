import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:peer_instruction_student/models/user/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Global {
  static late SharedPreferences _preferences;

  static User user = User();

  // 是否为release版
  static bool get isRelease => const bool.fromEnvironment('dart.vm.product');

  static bool get isLogin => user.token != null;

  // 从本地加载应用信息
  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    _preferences = await SharedPreferences.getInstance();
    var userString = _preferences.getString('user');
    if(userString != null) {
      user = User.fromJson(jsonDecode(userString));
    }
  }

  // 持久化应用信息
  static Future<void> save() async {
    await _preferences.setString('user', jsonEncode(user.toJson()));
  }
}