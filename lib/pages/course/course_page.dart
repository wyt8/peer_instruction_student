import 'package:flutter/material.dart';
import 'package:peer_instruction_student/pages/course/widgets/course_card.dart';

class CoursePage extends StatelessWidget {
  const CoursePage({super.key});

  Future<void> _refreshCourseList() async {
    // 这里执行数据刷新的操作，例如网络请求
    await Future.delayed(const Duration(seconds: 2)); // 模拟数据加载
    // 数据刷新完毕，返回
  }

  @override
  Widget build(BuildContext context) {
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
                return CourseCard(
                  courseId: index,
                  imageUrl: 'https://img0.baidu.com/it/u=3543009939,2144310597&fm=253&fmt=auto&app=138&f=JPEG?w=704&h=500', 
                  courseName: '卓越工程综合训练$index', 
                  attendTime: DateTime.now(), 
                  teacherAvatar: 'https://img1.baidu.com/it/u=1653751609,236581088&fm=253&fmt=auto&app=120&f=JPEG?w=500&h=500', 
                  teacherName: '车海莺',
                  onTap: () {},
                );
              }
            )
          )
        )
      ],
    );
  }
}
