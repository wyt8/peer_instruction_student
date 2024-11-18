import 'package:flutter/material.dart';

class ExerciseCard extends StatelessWidget {
  const ExerciseCard(
      {super.key,
      required this.content,
      required this.index,
      this.onFirstTap,
      this.onSecondTap});

  final String content;
  final int index;
  final void Function()? onFirstTap;
  final void Function()? onSecondTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(193, 240, 244, 255),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '题目 $index',
            style: const TextStyle(
                fontSize: 24,
                color: Color(0xff3d3d3d),
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text(
            content,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Color(0xFF181818)),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                  child: FilledButton(
                      onPressed: onFirstTap, child: const Text("第一次答题"))),
              const SizedBox(width: 10),
              Expanded(
                  child: FilledButton(
                      onPressed: onSecondTap, child: const Text("第二次答题"))),
            ],
          )
        ],
      ),
    );
  }
}
