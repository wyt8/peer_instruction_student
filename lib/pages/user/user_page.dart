import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:peer_instruction_student/apis/user_api.dart';
import 'package:peer_instruction_student/pages/user/widgets/user_item_tile.dart';
import 'package:peer_instruction_student/states/local_user.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});

  void _editUserInfo(BuildContext context, String item, String oldValue,
      String newValue) async {
    if (oldValue == newValue && item != 'password') {
      return;
    }
    var res = false;
    switch (item) {
      case 'name':
        res = await UserApi().modifyUserInfo(name: newValue);
        if (res) {
          if (context.mounted) {
            Provider.of<LocalUser>(context, listen: false).userName = newValue;
          }
        }
        break;
      case 'password':
        res = await UserApi().modifyUserInfo(password: newValue);
        break;
      case 'avatar':
        res = await UserApi().modifyUserInfo(avatar: newValue);
        if (res) {
          if (context.mounted) {
            Provider.of<LocalUser>(context, listen: false).userAvatar =
                newValue;
          }
        }
        break;
    }

    if (res) {
      toastification.show(
        showProgressBar: false,
        autoCloseDuration: const Duration(seconds: 3),
        alignment: Alignment.bottomCenter,
        title: const Text('修改成功'),
        type: ToastificationType.success,
      );
    } else {
      toastification.show(
        showProgressBar: false,
        autoCloseDuration: const Duration(seconds: 3),
        alignment: Alignment.bottomCenter,
        title: const Text('修改失败'),
        type: ToastificationType.error,
      );
    }
  }

  Widget _buildEditTiles(BuildContext context) {
    return Column(
      children: [
        Selector<LocalUser, String?>(
            builder: (context, name, child) => UserItemTile(
                itemName: '姓名',
                itemValue: name ?? '未知',
                icon: Icons.person,
                editHandle: (oldValue, newValue) =>
                    _editUserInfo(context, 'name', oldValue, newValue)),
            selector: (context, localUser) => localUser.userName),
        UserItemTile(
            itemName: '密码',
            itemValue: '********',
            icon: Icons.key,
            editHandle: (oldValue, newValue) =>
                _editUserInfo(context, 'password', oldValue, newValue)),
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
              padding: const EdgeInsets.fromLTRB(16, 100, 16, 20),
              child: Selector<LocalUser, String?>(
                selector: (context, localUser) => localUser.userAvatar,
                builder: (context, avatar, child) => avatar != null
                    ? CircleAvatar(
                        backgroundImage: NetworkImage(avatar),
                        radius: 50,
                      )
                    : const CircleAvatar(
                        backgroundColor: Colors.grey,
                        radius: 50,
                        child: Text('未登录'),
                      ),
              )),
          Padding(
              padding: const EdgeInsets.all(8),
              child: Selector<LocalUser, String?>(
                  selector: (context, localUser) => localUser.email,
                  builder: (context, email, child) => Text(
                        email ?? '未知邮箱',
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w700),
                      ))),
          const SizedBox(height: 50),
          _buildEditTiles(context),
          const SizedBox(height: 100),
          OutlinedButton(
              style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6)),
                  minimumSize: const Size(230, 55)),
              onPressed: () {
                _logout(context);
              },
              child: const Text(
                '退出登录',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ))
        ],
      ),
    );
  }
}
