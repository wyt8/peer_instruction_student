import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:peer_instruction_student/apis/class_api.dart';
import 'package:peer_instruction_student/models/class/class.dart';
import 'package:peer_instruction_student/pages/course/widgets/class_card.dart';

class ClassTabView extends StatefulWidget {
  const ClassTabView({super.key, required this.courseId});

  final int courseId;

  @override
  State<ClassTabView> createState() => _ClassTabViewState();
}

class _ClassTabViewState extends State<ClassTabView> {
  final List<Class> _classes = [];

  @override
  void initState() {
    super.initState();
    _getClasses();
  }

  Future<void> _getClasses() async {
    var res = await ClassApi().getClassList(widget.courseId);
    if (mounted) {
      setState(() {
        _classes.clear();
        _classes.addAll(res.data.classes);
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _getClasses,
        child: ListView.builder(
            itemCount: _classes.length,
            itemBuilder: (context, index) {
              return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 35, vertical: 10),
                  child: ClassCard(
                      className: _classes[index].className,
                      createdTime: _classes[index].startTime,
                      onTap: () {
                        GoRouter.of(context).push(
                            '/course/${widget.courseId}/class/${_classes[index].classId}');
                      }));
            }),
      ),
    );
  }
}
