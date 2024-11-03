import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:peer_instruction_student/apis/user_api.dart';
import 'package:peer_instruction_student/models/user/user.dart';
import 'package:peer_instruction_student/pages/login/widgets/forget_password_bottom_sheet.dart';
import 'package:peer_instruction_student/pages/login/widgets/logo.dart';
import 'package:peer_instruction_student/states/local_user.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';

class ForgetPasswordPage extends StatelessWidget {
  const ForgetPasswordPage({super.key});

  bool _verifyEmailHandler(String email) {
    if (email.isEmpty || email.length < 8) {
      return false;
    }
    if (email.contains('@') == false) {
      return false;
    }
    return true;
  }

  bool _verifyHandler(String email, String verifyCode, String password) {
    if (!_verifyEmailHandler(email) ||
        password.isEmpty ||
        verifyCode.isEmpty ||
        password.length < 8) {
      return false;
    }
    return true;
  }

  void _onSubmit(BuildContext context, String email, String verifyCode,
      String password) async {
    if (_verifyHandler(email, verifyCode, password)) {
      var res = await UserApi().forgetPassword(email, verifyCode, password);
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
          title: const Text('邮箱验证码错误'),
          type: ToastificationType.error,
        );
      }
    } else {
      toastification.show(
        showProgressBar: false,
        autoCloseDuration: const Duration(seconds: 3),
        alignment: Alignment.topCenter,
        title: const Text('请正确输入邮箱、验证码和密码'),
        type: ToastificationType.warning,
      );
    }
  }

  void _onSendVerifyCode(BuildContext context, String email) async {
    if (_verifyEmailHandler(email)) {
      var res = await UserApi().sendVerifyCode(email);
      if (res) {
        toastification.show(
          showProgressBar: false,
          autoCloseDuration: const Duration(seconds: 3),
          alignment: Alignment.topCenter,
          title: const Text('验证码已发送'),
          type: ToastificationType.success,
        );
      } else {
        toastification.show(
          showProgressBar: false,
          autoCloseDuration: const Duration(seconds: 3),
          alignment: Alignment.topCenter,
          title: const Text('验证码发送失败'),
          type: ToastificationType.error,
        );
      }
    } else {
      toastification.show(
        showProgressBar: false,
        autoCloseDuration: const Duration(seconds: 3),
        alignment: Alignment.topCenter,
        title: const Text('请正确输入邮箱'),
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
              child: ForgetPasswordBottomSheet(
                onSubmit: (email, verifyCode, password) =>
                    _onSubmit(context, email, verifyCode, password),
                onSendVerifyCode: (email) => _onSendVerifyCode(context, email),
              ))
        ],
      ),
    );
  }
}
