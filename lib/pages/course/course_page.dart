import 'package:flutter/material.dart';
import 'package:peer_instruction_student/apis/course_api.dart';
import 'package:peer_instruction_student/models/course/course.dart';
import 'package:peer_instruction_student/pages/course/widgets/course_card.dart';

class CoursePage extends StatefulWidget {
  const CoursePage({super.key});

  @override
  State<CoursePage> createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage> {
  Future<void> _refreshCourseList() async {
    var res = await CourseApi().getAllCourses();
    setState(() {
      _courses = res.courses;
    });
  }

  List<Course> _courses = [];

  @override
  void initState() {
    _refreshCourseList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _refreshCourseList,
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: const Text('课程'),
            backgroundColor: const Color(0xFF4C6ED7),
      
          ),
          SliverList.builder(
            itemCount: _courses.length,
            itemBuilder: (context, index) {
                return CourseCard(
                  courseId: _courses[index].courseId,
                  imageUrl: _courses[index].courseImageUrl, 
                  courseName: _courses[index].courseName, 
                  joinTime: _courses[index].joinTime, 
                  teacherAvatar: _courses[index].teacher.teacherAvatar, 
                  teacherName: _courses[index].teacher.teacherName,
                  onTap: () {},
                );
            }
          )
        ],
      ),
    );

    return Column(
      children: [
        AppBar(
          title: const Text('课程'),
          centerTitle: true,
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.add))
          ],
          backgroundColor: const Color(0xFF4C6ED7),
          foregroundColor: Colors.white,
          titleTextStyle: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold
          ),
        ),
        Expanded(
          child: RefreshIndicator(
            onRefresh: _refreshCourseList,
            child: ListView.builder(
              itemCount: 30,
              itemBuilder: (context, index) {
                
              }
            )
          )
        )
      ],
    );
  }
}
