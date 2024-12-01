import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:peer_instruction_student/apis/exercise_api.dart';
import 'package:toastification/toastification.dart';

class ExercisePage extends StatefulWidget {
  const ExercisePage(
      {super.key,
      required this.exerciseId,
      required this.index,
      required this.time,
      required this.exerciseContent,
      required this.exerciseOptions,
      this.myOption,
      this.rightOption});

  final int exerciseId;
  final int index;
  final Duration time;
  final String exerciseContent;
  final List<String> exerciseOptions;
  final int? myOption;
  final int? rightOption;

  @override
  State<ExercisePage> createState() => _ExercisePageState();
}

class _ExercisePageState extends State<ExercisePage> {
  late Duration _duration;
  late Timer _timer;

  int _selectedOption = -1;

  Future<void> _submit(int option, int index, BuildContext context) async {
    var res =
        await ExerciseApi().submitExercise(widget.exerciseId, option, index);
    if (res) {
      toastification.show(
        showProgressBar: false,
        autoCloseDuration: const Duration(seconds: 1),
        alignment: Alignment.topCenter,
        title: const Text('提交成功'),
        type: ToastificationType.success,
        callbacks: ToastificationCallbacks(
          onAutoCompleteCompleted: (_) {
            if (context.mounted) {
              GoRouter.of(context).pop();
            }
          },
        )
      );
    } else {
      toastification.show(
        showProgressBar: false,
        autoCloseDuration: const Duration(seconds: 3),
        alignment: Alignment.topCenter,
        title: const Text('提交失败'),
        type: ToastificationType.error,
      );
    }
  }

  @override
  void initState() {
    _duration = widget.time;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_duration.inSeconds == 0) {
        timer.cancel();
      }
      setState(() {
        _duration = _duration - const Duration(seconds: 1);
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.index == 0
           ? '第一次作答'
            : '第二次作答'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Builder(builder: (context) {
                if (widget.rightOption != null) {
                  return const SizedBox();
                } else {
                  return Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                            _duration.inSeconds <= 0
                                ? '时间到'
                                : '${_duration.inMinutes}:${_duration.inSeconds % 60}s',
                            style: TextStyle(
                                fontSize: 18,
                                color: _duration.inSeconds <= 10
                                    ? const Color(0xffff5b5b)
                                    : const Color(0xff979797),
                                fontWeight: FontWeight.w500)),
                        const SizedBox(width: 5),
                        Icon(
                          Icons.timer_outlined,
                          size: 18,
                          color: _duration.inSeconds <= 10
                              ? const Color(0xffff5b5b)
                              : const Color(0xff979797),
                        )
                      ]);
                }
              }),
              const SizedBox(height: 20),
              Text(widget.exerciseContent,
                  style: const TextStyle(
                      fontSize: 18,
                      color: Color(0xff181818),
                      fontWeight: FontWeight.w500)),
              const SizedBox(height: 20),
              _buildOptionButtonGroup(context),
              const SizedBox(height: 40),
              Builder(builder: (context) {
                if (widget.rightOption != null) {
                  return Center(
                    child: Text(
                        widget.myOption != null
                            ? '正确答案：${String.fromCharCode(65 + widget.rightOption!)}    我的答案：${String.fromCharCode(65 + widget.myOption!)}'
                            : '正确答案：${String.fromCharCode(65 + widget.rightOption!)}',
                        style: const TextStyle(
                            fontSize: 18,
                            color: Color(0xff181818),
                            fontWeight: FontWeight.w500)),
                  );
                } else {
                  return Center(
                    child: FilledButton(
                        style: FilledButton.styleFrom(
                            backgroundColor: const Color(0xff4C6ED7),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6)),
                            minimumSize: const Size(300, 60)),
                        onPressed:
                            _duration.inSeconds <= 0 || _selectedOption == -1
                                ? null
                                : () {
                                    _submit(_selectedOption, widget.index, context);
                                },
                        child: const Text('提交',
                            style: TextStyle(
                                fontSize: 18,
                                color: Color(0xfffdfdfd),
                                fontWeight: FontWeight.w500))),
                  );
                }
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOptionButtonGroup(BuildContext context) {
    return Column(
      children: widget.exerciseOptions.asMap().entries.map((entry) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: SizedBox(
            width: double.infinity,
            height: 64,
            child: FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: _selectedOption == entry.key
                      ? const Color(0xff4C6ED7)
                      : Colors.transparent,
                  foregroundColor: _selectedOption == entry.key
                      ? const Color(0xfffdfdfd)
                      : const Color(0xff181818),
                  alignment: Alignment.centerLeft,
                  shape: RoundedRectangleBorder(
                      side: BorderSide(
                          color: _selectedOption == entry.key
                              ? const Color(0xff4C6ED7)
                              : const Color(0xff9D9B9B)),
                      borderRadius: BorderRadius.circular(6)),
                ),
                onPressed: widget.rightOption != null
                    ? null
                    : () {
                        setState(() {
                          _selectedOption = entry.key;
                        });
                      },
                child: Text(
                    '${String.fromCharCode(65 + entry.key)}. ${entry.value}',
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w500))),
          ),
        );
      }).toList(),
    );
  }
}
