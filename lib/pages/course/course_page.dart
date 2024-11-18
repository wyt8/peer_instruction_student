import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:peer_instruction_student/pages/course/class_tab_view.dart';
import 'package:peer_instruction_student/pages/course/discussion_tab_view.dart';
import 'package:peer_instruction_student/pages/course/statistic_tab_view.dart';

class CoursePage extends StatefulWidget {
  const CoursePage(
      {super.key,
      required this.courseId,
      required this.courseName,
      required this.courseImageUrl});

  final int courseId;
  final String courseName;
  final String courseImageUrl;

  @override
  State<CoursePage> createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ExtendedNestedScrollView(
        onlyOneScrollInBody: true,
        pinnedHeaderSliverHeightBuilder: () {
          return MediaQuery.of(context).padding.top + kToolbarHeight;
        },
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            title: Text(widget.courseName),
            pinned: true,
            expandedHeight: 240,
            flexibleSpace: FlexibleSpaceBar(
              background: DecoratedBox(
                position: DecorationPosition.foreground,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.center,
                        stops: [0.3, 1],
                        colors: [Colors.white, Colors.transparent])),
                child: Image.network(
                  widget.courseImageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            bottom: TabBar(
                indicatorColor: const Color(0xff4C6ED7),
                indicatorSize: TabBarIndicatorSize.tab,
                controller: _tabController,
                labelStyle: const TextStyle(
                  fontSize: 14,
                  color: Color(0xff4C6ED7),
                ),
                unselectedLabelStyle:
                    const TextStyle(fontSize: 14, color: Color(0xff3D3D3D)),
                tabs: const [
                  Tab(
                    icon: Icon(Icons.collections_bookmark_outlined),
                    text: '课堂',
                  ),
                  Tab(
                    icon: Icon(Icons.comment_outlined),
                    text: '讨论',
                  ),
                  Tab(
                    icon: Icon(Icons.bar_chart),
                    text: '统计',
                  )
                ]),
          ),
        ],
        body: TabBarView(
          controller: _tabController,
          children: [
            ExtendedVisibilityDetector(
              uniqueKey: const Key('Tab0'),
              child: ClassTabView(courseId: widget.courseId),
            ),
            ExtendedVisibilityDetector(
              uniqueKey: const Key('Tab1'),
              child: DiscussionTabView(courseId: widget.courseId),
            ),
            ExtendedVisibilityDetector(
              uniqueKey: const Key('Tab2'),
              child: StatisticTabView(courseId: widget.courseId),
            ),
          ],
        ),
      ),
    );
  }
}
