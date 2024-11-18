import 'package:flutter/material.dart';
import 'package:peer_instruction_student/utils/datetime_formatter.dart';

class CourseCard extends StatelessWidget {
  const CourseCard({super.key, required this.courseId, required this.imageUrl, required this.courseName, required this.joinTime, required this.teacherAvatar, required this.teacherName, this.onTap});

  final int courseId;
  final String imageUrl;
  final String courseName;
  final DateTime joinTime;
  final String teacherAvatar;
  final String teacherName;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10)
              ),
              clipBehavior: Clip.antiAlias,
              child: AspectRatio(
                aspectRatio: 16/9,
                child: Image.network(
                  imageUrl,
                  scale: 16/9,
                  fit: BoxFit.cover,
                ),
              )
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Text('于 ${DatetimeFormatter.format(joinTime, FormatterType.accordingNow)} 加入',
                  style: const TextStyle(
                    fontSize: 14, 
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF4F4F4F)
                  ),
                ),
                const Spacer(),
                Text(teacherName,
                  style: const TextStyle(
                    fontSize: 14, 
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF4F4F4F)
                  ),
                ),
                const SizedBox(width: 15),
                CircleAvatar(
                  radius: 16,
                  backgroundImage: NetworkImage(teacherAvatar),
                )
              ],
            ),
            Text(courseName, 
              style: const TextStyle(
                fontSize: 18, 
                fontWeight: FontWeight.bold,
                color: Color(0xFF181818)
              ),
            )
          ],
        ),
      ),
    );
  }
}