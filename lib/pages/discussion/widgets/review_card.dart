import 'package:flutter/material.dart';
import 'package:peer_instruction_student/utils/datetime_formatter.dart';

class ReviewCard extends StatelessWidget {
  const ReviewCard(
      {super.key,
      required this.reviewContent,
      required this.createdTime,
      required this.reviewerAvatar,
      required this.reviewerName,
      required this.reviewId,
      required this.reviewRole});

  final String reviewContent;
  final DateTime createdTime;
  final String reviewerAvatar;
  final String reviewerName;
  final int reviewId;
  final int reviewRole;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 20),
      color: Colors.white,
      child: Column(children: [
        Row(
          children: [
            CircleAvatar(
              radius: 13,
              backgroundImage: NetworkImage(reviewerAvatar),
            ),
            const SizedBox(width: 8),
            Text(
              reviewerName,
              style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff3d3d3d)),
            ),
            const Spacer(),
            Text(
              DatetimeFormatter.format(createdTime, FormatterType.accordingNow),
              style: const TextStyle(fontSize: 10, color: Color(0xff4f4f4f)),
            )
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 30),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  reviewContent,
                  style: const TextStyle(fontSize: 14, color: Color(0xff888888)),
                ),
              )
            ],
          ),
        )
      ]),
    );
  }
}
