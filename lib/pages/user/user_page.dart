import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:peer_instruction_student/pages/user/widgets/user_item_tile.dart';
import 'package:peer_instruction_student/states/local_user.dart';
import 'package:provider/provider.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});

  Widget _buildEditTiles(BuildContext context) {
    return Column(
      children: [
        Selector<LocalUser, String?>(
          builder: (context, name, child) => UserItemTile(
            itemName: '姓名', 
            itemValue: name ?? '未知', 
            icon: Icons.person, 
            editHandle: (old, n) => true
          ), 
          selector: (context, localUser) => localUser.userName
        ),
        UserItemTile(
            itemName: '密码', 
            itemValue: '********', 
            icon: Icons.key, 
            editHandle: (old, n) => true
        ),
      ],
    );
  }

  void _logout(BuildContext context) {
    Provider.of<LocalUser>(context, listen: false).clear();
    GoRouter.of(context).go('/login');
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 46, 16, 20),
            child: Selector<LocalUser, String?>(
              selector: (context, localUser) => localUser.userAvatar,
              builder: (context, avatar, child) => avatar != null ? CircleAvatar(
                backgroundImage: NetworkImage(avatar),
                radius: 50,
              ) : const CircleAvatar(
                backgroundColor: Colors.grey,
                radius: 50,
                child: Text('未登录'),
              ),
            )
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Selector<LocalUser, String?>(
              selector: (context, localUser) => localUser.email,
              builder: (context, email, child) => Text(email ?? '未知邮箱',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              )
            )
          ),
          _buildEditTiles(context),
          const SizedBox(height: 100),
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)
              ),
              minimumSize: const Size(200, 50)
            ),
            onPressed: () {
              _logout(context);
            },
            child: const Text('退出登录')
          )
        ],
      ),
    );
  }
}
