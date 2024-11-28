import 'package:flutter/material.dart';
import 'package:peer_instruction_student/utils/datetime_formatter.dart';

class DiscussionCard extends StatelessWidget {
  const DiscussionCard(
      {super.key,
      required this.discussionId,
      required this.discussionTitle,
      required this.discussionContent,
      required this.createdTime,
      required this.posterAvatar,
      this.onTap});

  final int discussionId;
  final String posterAvatar;
  final String discussionTitle;
  final String discussionContent;
  final DateTime createdTime;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(6),
      child: Container(
          height: 120,
          decoration: BoxDecoration(
            color: const Color(0xfffdfdfd),
            borderRadius: BorderRadius.circular(6),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                spreadRadius: 0,
                blurRadius: 30,
                offset: const Offset(0, 2),
              )
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: CircleAvatar(
                  radius: 15,
                  backgroundImage: NetworkImage(posterAvatar),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 15, 20, 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        discussionTitle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      const SizedBox(height: 5),
                      Expanded(
                        child: Text(
                          discussionContent,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                          style: const TextStyle(
                              fontSize: 14, color: Color(0xFF181818)),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            '于 ${DatetimeFormatter.format(createdTime, FormatterType.accordingNow)} 发布',
                            style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF4F4F4F)),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          )),
    );
  }
}
