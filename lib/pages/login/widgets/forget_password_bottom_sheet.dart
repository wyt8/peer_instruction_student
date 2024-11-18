import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ForgetPasswordBottomSheet extends StatefulWidget {
  const ForgetPasswordBottomSheet(
      {super.key, required this.onSubmit, required this.onSendVerifyCode});

  final void Function(String email, String verifyCode, String password)
      onSubmit;
  final void Function(String email) onSendVerifyCode;

  @override
  State<ForgetPasswordBottomSheet> createState() => _ForgetPasswordBottomSheetState();
}

class _ForgetPasswordBottomSheetState extends State<ForgetPasswordBottomSheet> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _verifyCodeController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _showPassword = false;

  @override
  void dispose() {
    _emailController.dispose();
    _verifyCodeController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      padding: const EdgeInsets.all(30),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40), topRight: Radius.circular(40)),
          color: Color(0xfffdfdfd),
          boxShadow: [
            BoxShadow(
                color: Color(0x17000000),
                offset: Offset(0, -4),
                blurRadius: 50,
                spreadRadius: 0)
          ]),
      child: Column(
        children: [
          const Row(
            children: [
              Text('找回密码',
                  style: TextStyle(fontSize: 24, color: Color(0xff181818), fontWeight: FontWeight.w700))

            ],
          ),
          const SizedBox(height: 18),
          TextField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            style: const TextStyle(
                fontSize: 16,
                color: Color(0xff181818),
                fontWeight: FontWeight.w700,
                height: 24 / 14),
            decoration: InputDecoration(
                labelText: '邮箱',
                hintText: '请输入邮箱',
                contentPadding: const EdgeInsets.all(8),
                suffixIcon: TextButton(
                    onPressed: () {
                      widget.onSendVerifyCode(_emailController.text);
                    },
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.all(0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6)),
                    ),
                    child: const Text(
                      '发送验证码',
                      style: TextStyle(
                          fontSize: 14,
                          color: Color(0xffbdbdbd),
                          fontWeight: FontWeight.w500),
                    ))),
          ),
          const SizedBox(height: 18),
          TextField(
            controller: _verifyCodeController,
            style: const TextStyle(
                fontSize: 16,
                color: Color(0xff181818),
                fontWeight: FontWeight.w700,
                height: 24 / 14),
            decoration: const InputDecoration(
              labelText: '邮箱验证码',
              hintText: '请输入验证码',
              contentPadding: EdgeInsets.all(8),
            ),
          ),
          const SizedBox(height: 18),
          TextField(
            controller: _passwordController,
            keyboardType: TextInputType.visiblePassword,
            style: const TextStyle(
                fontSize: 16,
                color: Color(0xff181818),
                fontWeight: FontWeight.w700,
                height: 24 / 14),
            decoration: InputDecoration(
                labelText: '新密码',
                hintText: '请输入新密码',
                contentPadding: const EdgeInsets.all(8),
                suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _showPassword = !_showPassword;
                      });
                    },
                    icon: Icon(
                      _showPassword
                          ? Icons.visibility_off
                          : Icons.remove_red_eye,
                    ))),
            obscureText: !_showPassword,
          ),
          const SizedBox(height: 18),
          FilledButton(
              style: FilledButton.styleFrom(
                  backgroundColor: const Color(0xff4C6ED7),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6)),
                  minimumSize: const Size(250, 60)),
              onPressed: () {
                widget.onSubmit(_emailController.text,
                    _verifyCodeController.text, _passwordController.text);
              },
              child: const Text('确认修改',
                  style: TextStyle(
                      fontSize: 24,
                      color: Color(0xfffdfdfd),
                      fontWeight: FontWeight.w700))),
          const SizedBox(height: 18),
          RichText(
              text: TextSpan(
                  text: '已有账号？',
                  style: const TextStyle(
                      color: Color(0xff181818),
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                  children: [
                TextSpan(
                  text: '立即登录',
                  style: const TextStyle(
                    color: Color(0xff4C6ED7),
                    fontSize: 14,
                    decoration: TextDecoration.underline,
                    fontWeight: FontWeight.w500,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      GoRouter.of(context).go('/login');
                    },
                  mouseCursor: SystemMouseCursors.click,
                )
              ]))
        ],
      ),
    );
  }
}
