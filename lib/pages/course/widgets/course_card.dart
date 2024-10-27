import 'package:flutter/material.dart';

class CourseCard extends StatelessWidget {
  const CourseCard({super.key, required this.courseId, required this.imageUrl, required this.courseName, required this.attendTime, required this.teacherAvatar, required this.teacherName, this.onTap});

  final int courseId;
  final String imageUrl;
  final String courseName;
  final DateTime attendTime;
  final String teacherAvatar;
  final String teacherName;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10)
              ),
              clipBehavior: Clip.antiAlias,
              child: Image.network(
                imageUrl,
                scale: 16/9,
                fit: BoxFit.cover,
              )
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Text('于 ${attendTime.year}-${attendTime.month}-${attendTime.day} 加入',
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