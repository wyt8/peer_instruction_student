import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:peer_instruction_student/apis/discussion_api.dart';
import 'package:peer_instruction_student/models/discussion/discussion.dart';
import 'package:peer_instruction_student/pages/course/widgets/discussion_card.dart';
import 'package:peer_instruction_student/widgets/empty,dart';
import 'package:toastification/toastification.dart';

class DiscussionTabView extends StatefulWidget {
  const DiscussionTabView({super.key, required this.courseId});

  final int courseId;

  @override
  State<DiscussionTabView> createState() => _DiscussionTabViewState();
}

class _DiscussionTabViewState extends State<DiscussionTabView> {
  late TextEditingController _discussionTitleController;
  late TextEditingController _discussionContentController;

  @override
  void initState() {
    _discussionTitleController = TextEditingController();
    _discussionContentController = TextEditingController();
    _getDiscussions();
    super.initState();
  }

  @override
  void dispose() {
    _discussionTitleController.dispose();
    _discussionContentController.dispose();
    super.dispose();
  }

  void _showAddDiscussionDialog(BuildContext context) async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            contentPadding: const EdgeInsets.all(20),
            title: const Center(
              child: Text(
                '添加讨论',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF3d3D3D),
                ),
              ),
            ),
            content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    '标题',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _discussionTitleController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    '内容',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _discussionContentController,
                    maxLines: 5,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
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
                    var res = await _postDiscussionHandle(
                        context,
                        _discussionTitleController.text,
                        _discussionContentController.text);
                    if (res && context.mounted) {
                      Navigator.of(context).pop();
                    }
                  },
                  child: const Text('发布',
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.w500))),
            ],
          );
        });
  }

  // 发布讨论
  Future<bool> _postDiscussionHandle(
      BuildContext context, String title, String content) async {
    if (title.isNotEmpty && content.isNotEmpty) {
      var res =
          await DiscussionApi().addDiscussion(widget.courseId, title, content);
      if (res) {
        toastification.show(
          showProgressBar: false,
          autoCloseDuration: const Duration(seconds: 3),
          alignment: Alignment.topCenter,
          title: const Text('发布成功'),
          type: ToastificationType.success,
        );
        _getDiscussions();
        return true;
      } else {
        toastification.show(
          showProgressBar: false,
          autoCloseDuration: const Duration(seconds: 3),
          alignment: Alignment.topCenter,
          title: const Text('发布失败'),
          type: ToastificationType.error,
        );
      }
    } else {
      toastification.show(
        showProgressBar: false,
        autoCloseDuration: const Duration(seconds: 3),
        alignment: Alignment.topCenter,
        title: const Text('请正确输入标题和内容'),
        type: ToastificationType.warning,
      );
    }
    return false;
  }

  List<Discussion> _discussions = [];
  bool _isLoading = false;

  Future<void> _getDiscussions() async {
    if (_isLoading) {
      return;
    }
    setState(() {
      _isLoading = true;
    });
    var res = await DiscussionApi().getDiscussions(widget.courseId, 0, 10);
    if (res.isSuccess && mounted) {
      setState(() {
        _discussions = res.data.discussions;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
            child: RefreshIndicator(
                onRefresh: _getDiscussions,
                child: Builder(builder: (context) {
                  if (_isLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  // if (_discussions.isEmpty) {
                  //   return const Empty();
                  // }

                  return ListView.builder(
                      controller: ScrollController(),
                      itemCount: _discussions.length,
                      itemBuilder: (context, index) {
                        return Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            child: DiscussionCard(
                              discussionId: _discussions[index].discussionId,
                              discussionTitle:
                                  _discussions[index].discussionTitle,
                              discussionContent:
                                  _discussions[index].discussionContent,
                              createdTime: _discussions[index].createdTime,
                              posterAvatar:
                                  _discussions[index].poster.userAvatar,
                              onTap: () {
                                GoRouter.of(context).push(
                                    '/course/${widget.courseId}/discussion/${_discussions[index].discussionId}',
                                    extra: {
                                      'discussion_title':
                                          _discussions[index].discussionTitle,
                                      'discussion_content':
                                          _discussions[index].discussionContent,
                                      'created_time':
                                          _discussions[index].createdTime,
                                      'poster_avatar':
                                          _discussions[index].poster.userAvatar,
                                      'poster_name':
                                          _discussions[index].poster.userName,
                                    });
                              },
                            ));
                      });
                }))),
        Positioned(
          right: 50,
          bottom: 50,
          child: FloatingActionButton(
            onPressed: () {
              _showAddDiscussionDialog(context);
            },
            backgroundColor: const Color(0xff4C6ED7),
            foregroundColor: Colors.white,
            shape: const CircleBorder(),
            child: const Icon(Icons.add),
          ),
        ),
      ],
    );
  }
}
