import 'package:flutter/material.dart';
import 'package:peer_instruction_student/utils/datetime_formatter.dart';

class MessageTile extends StatelessWidget {
  const MessageTile(
      {super.key,
      required this.teacherAvatar,
      required this.courseName,
      required this.message,
      required this.sendTime,
      this.onTap});

  final String teacherAvatar;
  final String courseName;
  final String message;
  final DateTime sendTime;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(teacherAvatar,
            width: 50, height: 50, fit: BoxFit.cover),
      ),
      title: Text(
        courseName,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(message),
      trailing: SizedBox(
          height: 50,
          child: Text(DatetimeFormatter.format(
              sendTime, FormatterType.accordingNow))),
      onTap: onTap,
    );
  }
}
