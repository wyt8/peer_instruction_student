import 'package:flutter/material.dart';
import 'package:peer_instruction_student/utils/datetime_formatter.dart';

class ClassCard extends StatelessWidget {
  const ClassCard(
      {super.key,
      required this.className,
      required this.createdTime,
      this.onTap});

  // final int courseId;
  final String className;
  final DateTime createdTime;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
          decoration: BoxDecoration(
            color: const Color(0xffF0F4FF),
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DatetimeFormatter.format(
                    createdTime, FormatterType.accordingNow),
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF979797)),
              ),
              const SizedBox(height: 16),
              Text(
                className,
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff3d3d3d)),
              )
            ],
          )),
    );
  }
}
