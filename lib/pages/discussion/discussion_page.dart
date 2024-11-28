import 'package:flutter/material.dart';
import 'package:peer_instruction_student/apis/discussion_api.dart';
import 'package:peer_instruction_student/models/discussion/review.dart';
import 'package:peer_instruction_student/pages/discussion/widgets/review_card.dart';
import 'package:peer_instruction_student/utils/datetime_formatter.dart';
import 'package:toastification/toastification.dart';

class DiscussionPage extends StatefulWidget {
  const DiscussionPage(
      {super.key,
      required this.courseId,
      required this.discussionId,
      required this.discussionTitle,
      required this.discussionContent,
      required this.createdTime,
      required this.posterAvatar,
      required this.posterName});

  final int courseId;
  final int discussionId;
  final String discussionTitle;
  final String discussionContent;
  final DateTime createdTime;
  final String posterAvatar;
  final String posterName;

  @override
  State<DiscussionPage> createState() => _DiscussionPageState();
}

class _DiscussionPageState extends State<DiscussionPage> {
  late TextEditingController _textEditingController;
  late FocusNode _foucusNode;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
    _foucusNode = FocusNode();
    _getReviews();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _foucusNode.dispose();
    super.dispose();
  }

  Widget _buildDiscussionCard() {
    return Container(
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 0,
          blurRadius: 10,
          offset: const Offset(0, 5),
        )
      ]),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            CircleAvatar(
              radius: 15,
              backgroundImage: NetworkImage(widget.posterAvatar),
            ),
            const SizedBox(width: 20),
            Text(
              widget.posterName,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Color(0xff3d3d3d),
              ),
            ),
          ]),
          const SizedBox(height: 14),
          Text(
            widget.discussionTitle,
            softWrap: true,
            style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xff181818)),
          ),
          const SizedBox(height: 14),
          Text(
            widget.discussionContent,
            style: const TextStyle(fontSize: 14, color: Color(0xff181818)),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                '发布于 ${DatetimeFormatter.format(widget.createdTime, FormatterType.dateAndTime)}',
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildInputBox() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: const Color(0xfffdfdfd), boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.08),
          spreadRadius: 0,
          blurRadius: 2,
          offset: const Offset(0, -1),
        )
      ]),
      height: 90,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _textEditingController,
              focusNode: _foucusNode,
              decoration: InputDecoration(
                hintText: '输入...',
                hintStyle: const TextStyle(
                  fontSize: 14,
                  color: Color(0xff979797),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: const Color(0xfff3f3f3),
              ),
            ),
          ),
          const SizedBox(width: 10),
          FilledButton(
              style: FilledButton.styleFrom(
                  backgroundColor: const Color(0xff4C6ED7),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6)),
                  minimumSize: const Size(80, 50)),
              onPressed: () {
                _sendReview();
              },
              child: const Text('回复',
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.normal)))
        ],
      ),
    );
  }

  void _sendReview() async {
    // 发送评论
    if (_textEditingController.text.isNotEmpty) {
      var res = await DiscussionApi().sendReview(
          widget.courseId, widget.discussionId, _textEditingController.text);
      if (res) {
        toastification.show(
          showProgressBar: false,
          autoCloseDuration: const Duration(seconds: 3),
          alignment: Alignment.topCenter,
          title: const Text('回复成功'),
          type: ToastificationType.success,
        );
        _getReviews();
        _textEditingController.clear();
        _foucusNode.unfocus();
      } else {
        toastification.show(
          showProgressBar: false,
          autoCloseDuration: const Duration(seconds: 3),
          alignment: Alignment.topCenter,
          title: const Text('回复失败'),
          type: ToastificationType.error,
        );
      }
    }
  }

  List<Review> _reviews = [];

  Future<void> _getReviews() async {
    var res = await DiscussionApi()
        .getReviews(widget.courseId, widget.discussionId, 0, 10);
    if (res.isSuccess && mounted) {
      setState(() {
        _reviews = res.data.reviews;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('讨论详情'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          _buildDiscussionCard(),
          Expanded(
            child: RefreshIndicator(
              onRefresh: _getReviews,
              child: ListView.builder(
                  itemCount: _reviews.length,
                  itemBuilder: (context, index) {
                    return ReviewCard(
                        reviewContent: _reviews[index].reviewContent,
                        createdTime: _reviews[index].createdTime,
                        reviewerAvatar: _reviews[index].reviewer.userAvatar,
                        reviewerName: _reviews[index].reviewer.userName,
                        reviewId: _reviews[index].reviewId,
                        reviewRole: _reviews[index].reviewer.userRole);
                  }),
            ),
          ),
          _buildInputBox(),
        ],
      ),
    );
  }
}
