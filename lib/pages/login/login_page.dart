import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:peer_instruction_student/apis/user_api.dart';
import 'package:peer_instruction_student/models/user/user.dart';
import 'package:peer_instruction_student/pages/login/widgets/login_bottom_sheet.dart';
import 'package:peer_instruction_student/pages/login/widgets/logo.dart';
import 'package:peer_instruction_student/states/local_user.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  bool _verifyHandler(String email, String password) {
    if (email.isEmpty ||
        password.isEmpty ||
        password.length < 8 ||
        email.length < 8) {
      return false;
    }
    if (email.contains('@') == false) {
      return false;
    }
    return true;
  }

  void _onSubmit(BuildContext context, String email, String password) async {
    if (_verifyHandler(email, password)) {
      var res = await UserApi().login(email, password);
      if (res.isSuccess) {
        if (context.mounted) {
          User user = res.data;
          Provider.of<LocalUser>(context, listen: false).setUser(user);
          GoRouter.of(context).go('/course');
        }
      } else {
        toastification.show(
          showProgressBar: false,
          autoCloseDuration: const Duration(seconds: 3),
          alignment: Alignment.topCenter,
          title: const Text('邮箱或密码错误'),
          type: ToastificationType.error,
        );
      }
    } else {
      toastification.show(
        showProgressBar: false,
        autoCloseDuration: const Duration(seconds: 3),
        alignment: Alignment.topCenter,
        title: const Text('请正确输入邮箱和密码'),
        type: ToastificationType.warning,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          const Positioned(top: 100, child: Logo()),
          Positioned(
              bottom: 0,
              child: LoginBottomSheet(
                onSubmit: (email, password) {
                  _onSubmit(context, email, password);
                },
              ))
        ],
      ),
    );
  }
}
