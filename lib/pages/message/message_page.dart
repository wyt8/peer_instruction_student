import 'package:flutter/material.dart';
import 'package:peer_instruction_student/pages/message/widgets/message_tile.dart';

class MessagePage extends StatelessWidget {
  const MessagePage({super.key});

  @override
Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          title: const Text('消息'),
          centerTitle: true,
          backgroundColor: const Color(0xFF4C6ED7),
          foregroundColor: Colors.white,
          titleTextStyle: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold
          ),
        ),
        Expanded(
          child: RefreshIndicator(
            onRefresh: _refreshMessageList,
            child: ListView.builder(
              itemCount: 30,
              itemBuilder: (context, index) {
                return MessageTile(
                  teacherAvatar: 'https://img1.baidu.com/it/u=1653751609,236581088&fm=253&fmt=auto&app=120&f=JPEG?w=500&h=500', 
                  courseName: '卓越工程综合训练$index', 
                  message: '消息$index', 
                  sendTime: DateTime.now(),
                  onTap: () {},
                );
              }
            )
          )
        )
      ],
    );
  }

  Future<void> _refreshMessageList() async {
    await Future.delayed(const Duration(seconds: 2)); 
  }
}