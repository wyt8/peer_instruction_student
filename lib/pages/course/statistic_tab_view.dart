import 'package:flutter/material.dart';
import 'package:peer_instruction_student/apis/course_api.dart';
import 'package:peer_instruction_student/models/course/course_statistic.dart';
import 'package:peer_instruction_student/pages/course/widgets/chart_card.dart';

class StatisticTabView extends StatefulWidget {
  const StatisticTabView({super.key, required this.courseId});
  final int courseId;

  @override
  State<StatisticTabView> createState() => _StatisticTabViewState();
}

class _StatisticTabViewState extends State<StatisticTabView> {
  CourseStatistic? _courseStatistic;

  Future<void> _getCourseStatistic() async {
    var res = await CourseApi().getCourseStatistic(widget.courseId);
    if (mounted) {
      setState(() {
        _courseStatistic = res.data;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _getCourseStatistic();
  }

  Widget _buildDataBox(String title, String value, String unit) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      width: 140,
      decoration: BoxDecoration(
        color: const Color(0xffF3F3F3),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Color(0xff4F4F4F),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.normal,
              color: Color(0xff181818),
            ),
          ),
          Text(
            unit,
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.normal,
              color: Color(0xff4f4f4f),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => _getCourseStatistic(),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '数据',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildDataBox(
                        '课堂数',
                        '${_courseStatistic?.classNum ?? 0}',
                        '次',
                      ),
                      _buildDataBox(
                        '出勤数',
                        '${_courseStatistic?.attendenceNum ?? 0}',
                        '次',
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildDataBox(
                        '发布讨论数',
                        '${_courseStatistic?.discussionNum ?? 0}',
                        '个',
                      ),
                      _buildDataBox(
                        '回复讨论数',
                        '${_courseStatistic?.reviewNum ?? 0}',
                        '个',
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    '答题正确率',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ChartCard(
                    firstAccuracies: _courseStatistic?.classStatistics
                            .map((item) => item.exerciseNum == 0
                                ? 0
                                : (item.firstRightNum * 100 / item.exerciseNum)
                                    .round())
                            .toList() ??
                        List.empty(),
                    secondAccuracies: _courseStatistic?.classStatistics
                            .map((item) => (item.exerciseNum == 0
                                    ? 0
                                    : item.secondRightNum *
                                        100 /
                                        item.exerciseNum)
                                .round())
                            .toList() ??
                        List.empty(),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
