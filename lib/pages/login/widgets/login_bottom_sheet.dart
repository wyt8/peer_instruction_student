import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginBottomSheet extends StatefulWidget {
  const LoginBottomSheet({super.key, required this.onSubmit});

  final void Function(String email, String password) onSubmit;

  @override
  State<LoginBottomSheet> createState() => _LoginBottomSheetState();
}

class _LoginBottomSheetState extends State<LoginBottomSheet> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _showPassword = false;

  @override
  void dispose() {
    _emailController.dispose();
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
              Text('登录',
                  style: TextStyle(fontSize: 24, color: Color(0xff181818), fontWeight: FontWeight.w700))
            ],
          ),
          const SizedBox(height: 18),
          TextField(
            keyboardType: TextInputType.emailAddress,
            controller: _emailController,
            autocorrect: true,
            style: const TextStyle(
                fontSize: 16,
                color: Color(0xff181818),
                fontWeight: FontWeight.w700,
                height: 24 / 14),
            decoration: const InputDecoration(
              labelText: '邮箱',
              hintText: '请输入邮箱',
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
                labelText: '密码',
                hintText: '请输入密码',
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
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              RichText(
                  text: TextSpan(
                text: '忘记密码？',
                style: const TextStyle(
                    color: Color(0xff4C6ED7),
                    fontSize: 14,
                    decoration: TextDecoration.underline,
                    fontWeight: FontWeight.w500),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    GoRouter.of(context).go('/forget_password');
                  },
                mouseCursor: SystemMouseCursors.click,
              ))
            ],
          ),
          const SizedBox(height: 18),
          FilledButton(
              style: FilledButton.styleFrom(
                  backgroundColor: const Color(0xff4C6ED7),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6)),
                  minimumSize: const Size(250, 60)),
              onPressed: () {
                widget.onSubmit(
                    _emailController.text, _passwordController.text);
              },
              child: const Text('登录',
                  style: TextStyle(
                      fontSize: 24,
                      color: Color(0xfffdfdfd),
                      fontWeight: FontWeight.w700))),
          const SizedBox(height: 18),
          RichText(
              text: TextSpan(
                  text: '没有账号？',
                  style: const TextStyle(
                      color: Color(0xff181818),
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                  children: [
                TextSpan(
                  text: '立即注册',
                  style: const TextStyle(
                    color: Color(0xff4C6ED7),
                    fontSize: 14,
                    decoration: TextDecoration.underline,
                    fontWeight: FontWeight.w500,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      GoRouter.of(context).go('/register');
                    },
                  mouseCursor: SystemMouseCursors.click,
                )
              ]))
        ],
      ),
    );
  }
}
