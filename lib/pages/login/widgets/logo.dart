import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
            width: 100,
            height: 100,
            child: Image.asset('assets/imgs/logo.png')),
        const SizedBox(height: 10),
        const Text(
          '同伴课堂学生端',
          style: TextStyle(
              fontSize: 26,
              color: Color(0xff2e3192),
              fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 10),
        const Text(
          '同伴教学法支撑平台',
          style: TextStyle(
              fontSize: 18,
              color: Color(0xff181818),
              fontWeight: FontWeight.normal),
        )
      ],
    );
  }
}
