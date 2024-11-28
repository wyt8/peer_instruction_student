import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:peer_instruction_student/apis/exercise_api.dart';
import 'package:peer_instruction_student/models/exercise/exercise.dart';
import 'package:peer_instruction_student/pages/class/check_in_tab_view.dart';
import 'package:peer_instruction_student/pages/class/widgets/exercise_card.dart';
import 'package:toastification/toastification.dart';

class ClassPage extends StatefulWidget {
  const ClassPage({super.key, required this.courseId, required this.classId});

  final int courseId;
  final int classId;

  @override
  State<ClassPage> createState() => _ClassPageState();
}

class _ClassPageState extends State<ClassPage> with TickerProviderStateMixin {
  late TabController _tabController;
  late Timer _timer;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
    _getExerciseList();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _getExerciseList(notice: true);
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('课堂详情'),
          centerTitle: true,
          bottom: TabBar(
              indicatorColor: const Color(0xff4C6ED7),
              indicatorSize: TabBarIndicatorSize.tab,
              controller: _tabController,
              // labelColor: ,
              labelStyle: const TextStyle(
                fontSize: 14,
                color: Color(0xff4C6ED7),
              ),
              unselectedLabelStyle:
                  const TextStyle(fontSize: 14, color: Color(0xff3D3D3D)),
              tabs: const [
                // Tab(
                //   icon: Icon(Icons.collections_bookmark_outlined),
                //   text: '课前预习',
                // ),
                Tab(
                  icon: Icon(Icons.location_on_outlined),
                  text: '课堂签到',
                ),
                Tab(
                  icon: Icon(Icons.assignment_outlined),
                  text: '课上答题',
                )
              ]),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            CheckInTabView(
              classId: widget.classId,
              courseId: widget.courseId,
            ),
            _buildExerciseTabView(context)
          ],
        ));
  }

  List<Exercise> _exercises = [];

  Future<void> _getExerciseList({bool notice = false}) async {
    var result =
        await ExerciseApi().getExercise(widget.courseId, widget.classId);
    if (result.isSuccess) {
      if (notice && !_compareExerciseList(result.data.exercises)) {
        toastification.show(
          showProgressBar: false,
          autoCloseDuration: const Duration(seconds: 3),
          alignment: Alignment.topCenter,
          title: const Text('有新的题目，请及时回答'),
          type: ToastificationType.info,
        );
      }
      if (mounted) {
        setState(() {
          _exercises = result.data.exercises;
        });
      }
    }
  }

  // 比较两个列表是否相同，如果相同返回true，否则返回false
  bool _compareExerciseList(List<Exercise> newValue) {
    if (newValue.length != _exercises.length) {
      return false;
    }
    for (var i = 0; i < newValue.length; i++) {
      if (newValue[i].firstAnswer.status != _exercises[i].firstAnswer.status ||
          newValue[i].secondAnswer.status !=
              _exercises[i].secondAnswer.status) {
        return false;
      }
    }
    return true;
  }

  Widget _buildExerciseTabView(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => _getExerciseList(notice: true),
      child: ListView.builder(
          itemCount: _exercises.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: ExerciseCard(
                onFirstTap: _exercises[index].firstAnswer.status == 0
                    ? null
                    : () {
                        GoRouter.of(context).push(
                          '/exercise/${_exercises[index].exerciseId}',
                          extra: {
                            'index': 0,
                            'time': _exercises[index]
                                .firstAnswer
                                .startTime
                                ?.add(Duration(
                                    seconds: _exercises[index]
                                            .firstAnswer
                                            .limitTime ??
                                        0))
                                .difference(DateTime.now()),
                            'exercise_content': _exercises[index].content,
                            'exercise_options': _exercises[index].options,
                            'my_option': _exercises[index].firstAnswer.myOption,
                            'right_option':
                                _exercises[index].firstAnswer.rightOption,
                          },
                        );
                      },
                onSecondTap: _exercises[index].secondAnswer.status == 0
                    ? null
                    : () {
                        GoRouter.of(context).push(
                          '/exercise/${_exercises[index].exerciseId}',
                          extra: {
                            'index': 1,
                            'time': _exercises[index]
                                .secondAnswer
                                .startTime
                                ?.add(Duration(
                                    seconds: _exercises[index]
                                            .secondAnswer
                                            .limitTime ??
                                        0))
                                .difference(DateTime.now()),
                            'exercise_content': _exercises[index].content,
                            'exercise_options': _exercises[index].options,
                            'my_option':
                                _exercises[index].secondAnswer.myOption,
                            'right_option':
                                _exercises[index].secondAnswer.rightOption,
                          },
                        );
                      },
                content: _exercises[index].content,
                index: index + 1,
              ),
            );
          }),
    );
  }
}
