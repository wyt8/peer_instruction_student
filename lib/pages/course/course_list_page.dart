import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:peer_instruction_student/apis/course_api.dart';
import 'package:peer_instruction_student/models/course/course.dart';
import 'package:peer_instruction_student/pages/course/widgets/course_card.dart';
import 'package:peer_instruction_student/states/local_user.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';

class CourseListPage extends StatefulWidget {
  const CourseListPage({super.key});

  @override
  State<CourseListPage> createState() => _CourseListPageState();
}

class _CourseListPageState extends State<CourseListPage> {
  final TextEditingController _courseCodeController = TextEditingController();

  @override
  void dispose() {
    _courseCodeController.dispose();
    super.dispose();
  }

  /// 显示添加课程对话框
  void _showAddCourseDialog(BuildContext context) async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            contentPadding: const EdgeInsets.all(20),
            title: const Center(
              child: Text(
                '添加课程',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF3D3D3D),
                ),
              ),
            ),
            content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: _courseCodeController,
                    decoration: const InputDecoration(
                      labelText: '课程码',
                    ),
                  )
                ]),
            actionsAlignment: MainAxisAlignment.center,
            actions: [
              FilledButton(
                  style: FilledButton.styleFrom(
                      backgroundColor: const Color(0xff4C6ED7),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6)),
                      minimumSize: const Size(250, 40)),
                  onPressed: () async {
                    if (_courseCodeController.text.isNotEmpty) {
                      var res = await CourseApi()
                          .addCourse(_courseCodeController.text);
                      if (res.isSuccess) {
                        _refreshCourseList();
                        toastification.show(
                          showProgressBar: false,
                          autoCloseDuration: const Duration(seconds: 3),
                          alignment: Alignment.bottomCenter,
                          title: const Text('添加成功'),
                          type: ToastificationType.success,
                        );
                      } else {
                        toastification.show(
                          showProgressBar: false,
                          autoCloseDuration: const Duration(seconds: 3),
                          alignment: Alignment.bottomCenter,
                          title: const Text('添加失败'),
                          type: ToastificationType.error,
                        );
                      }
                    }
                    if (context.mounted) {
                      Navigator.of(context).pop();
                    }
                  },
                  child: const Text('添加',
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.w700))),
            ],
          );
        });
  }

  Future<void> _refreshCourseList() async {
    var res = await CourseApi().getAllCourses();
    setState(() {
      _courses.clear();
      _courses.addAll(res.data.courses);
    });
  }

  final List<Course> _courses = [];
  late EasyRefreshController _controller;

  @override
  void initState() {
    super.initState();
    _controller = EasyRefreshController(
        controlFinishRefresh: true, controlFinishLoad: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('课程'),
          backgroundColor: const Color(0xFF4C6ED7),
          centerTitle: true,
          foregroundColor: Colors.white,
          titleTextStyle:
              const TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: IconButton(
                  onPressed: () {
                    _showAddCourseDialog(context);
                  },
                  icon: const Icon(Icons.add)),
            )
          ],
        ),
        body: EasyRefresh(
            controller: _controller,
            header: const MaterialHeader(),
            footer: const MaterialFooter(),
            refreshOnStart: true,
            refreshOnStartHeader: BuilderHeader(
              triggerOffset: 70,
              clamping: true,
              position: IndicatorPosition.above,
              processedDuration: Duration.zero,
              builder: (ctx, state) {
                if (state.mode == IndicatorMode.inactive ||
                    state.mode == IndicatorMode.done) {
                  return const SizedBox();
                }
                return Container(
                  padding: const EdgeInsets.only(bottom: 100),
                  width: double.infinity,
                  height: state.viewportDimension,
                  alignment: Alignment.center,
                  child: const CircularProgressIndicator(),
                );
              },
            ),
            onRefresh: () async {
              var res = await CourseApi().getAllCourses();
              setState(() {
                _courses.clear();
                _courses.addAll(res.data.courses);
              });
              _controller.finishRefresh();
              _controller.resetFooter();
            },
            child: CustomScrollView(slivers: [
              SliverToBoxAdapter(
                  child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Selector<LocalUser, String?>(
                        selector: (context, value) => value.userName,
                        builder: (context, value, child) {
                          return Text(
                            '你好，${value?? "未登录"}',
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w900,
                              color: Color(0xff181818),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        '今天要学习什么呢？',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Color(0xff888888),
                        ),
                      )
                    ]),
              )),
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
                      onTap: () {
                        GoRouter.of(context).push(
                            '/course/${_courses[index].courseId}',
                            extra: {
                              'course_name': _courses[index].courseName,
                              'course_image_url': _courses[index].courseImageUrl
                            });
                      },
                    );
                  })
            ])));
  }
}
