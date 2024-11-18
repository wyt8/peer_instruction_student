import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:peer_instruction_student/apis/message_api.dart';
import 'package:peer_instruction_student/models/message/notice.dart';
import 'package:peer_instruction_student/pages/message/widgets/message_tile.dart';
import 'package:peer_instruction_student/utils/datetime_formatter.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({super.key});

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  void _showMessage(BuildContext context, int index) async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                      width: 370,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)),
                      clipBehavior: Clip.antiAlias,
                      child: AspectRatio(
                        aspectRatio: 16 / 9,
                        child: Image.network(
                          _notices[index].course.courseImageUrl,
                          scale: 16 / 9,
                          fit: BoxFit.cover,
                        ),
                      )),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Icon(
                        Icons.class_outlined,
                        color: Color(0xFF979797),
                        size: 16,
                      ),
                      const SizedBox(width: 16),
                      Text(
                        _notices[index].course.courseName,
                        style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF979797)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Icon(
                        Icons.person_outlined,
                        color: Color(0xFF979797),
                        size: 16,
                      ),
                      const SizedBox(width: 16),
                      Text(
                        _notices[index].course.teacher.teacherName,
                        style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF979797)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Icon(
                        Icons.date_range_outlined,
                        color: Color(0xFF979797),
                        size: 16,
                      ),
                      const SizedBox(width: 16),
                      Text(
                        DatetimeFormatter.format(_notices[index].sendTime,
                            FormatterType.dateAndTime),
                        style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF979797)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      _notices[index].content,
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          height: 20 / 18,
                          color: Color(0xFF3D3D3D)),
                    ),
                  ),
                ],
              ),
            ),
            actionsAlignment: MainAxisAlignment.center,
            actions: [
              FilledButton(
                  style: FilledButton.styleFrom(
                      backgroundColor: const Color(0xff4C6ED7),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6)),
                      minimumSize: const Size(250, 60)),
                  onPressed: _notices[index].isReceived
                      ? null
                      : () async {
                          // var noticeId = _notices[index].noticeId;
                          // var res = await MessageApi().markNoticeRead(noticeId);
                          // if (res) {
                          //   setState(() {
                          //     _notices[index].isReceived = true;
                          //   });
                          //   return;
                          // } else {

                          // }
                          Navigator.of(context).pop();
                        },
                  child: const Text('确认收到',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w700))),
            ],
          );
        });
  }

  late EasyRefreshController _controller;

  final List<Notice> _notices = [];
  int _lastNoticeId = 0;
  final int _num = 30;

  @override
  void initState() {
    super.initState();
    _controller = EasyRefreshController(
      controlFinishRefresh: true,
      controlFinishLoad: true,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('消息'),
        centerTitle: true,
        backgroundColor: const Color(0xFF4C6ED7),
        foregroundColor: Colors.white,
        titleTextStyle:
            const TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
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
            _lastNoticeId = 0;
            var res = await MessageApi().getMessageList(_lastNoticeId, _num);
            setState(() {
              _notices.clear();
              _notices.addAll(res.notices);
              _lastNoticeId = _notices.last.noticeId;
            });
            _controller.finishRefresh();
            _controller.resetFooter();
          },
          onLoad: () async {
            var res = await MessageApi().getMessageList(_lastNoticeId, _num);
            if (!mounted) {
              return;
            }
            setState(() {
              _notices.addAll(res.notices);
              _lastNoticeId = _notices.last.noticeId;
            });
            _controller.finishLoad(res.notices.isEmpty
                ? IndicatorResult.noMore
                : IndicatorResult.success);
          },
          child: ListView.builder(
              itemCount: _notices.length,
              itemBuilder: (context, index) {
                return MessageTile(
                  teacherAvatar: _notices[index].course.teacher.teacherAvatar,
                  courseName: _notices[index].course.courseName,
                  message: _notices[index].content,
                  sendTime: _notices[index].sendTime,
                  onTap: () {
                    _showMessage(context, index);
                  },
                );
              })),
    );
  }
}
