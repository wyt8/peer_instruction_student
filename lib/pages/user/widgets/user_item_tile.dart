import 'package:flutter/material.dart';

class UserItemTile extends StatelessWidget {
  const UserItemTile(
      {super.key,
      required this.itemName,
      required this.itemValue,
      required this.icon,
      required this.editHandle});

  final String itemName;
  final String itemValue;
  final IconData icon;

  /// 返回值表示是否修改成功
  final void Function(String oldValue, String newValue) editHandle;

  void _editItem(BuildContext context) async {
    String inputValue = "";
    String? result = await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text('编辑$itemName'),
              content: SingleChildScrollView(
                child: TextField(
                  style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xff181818),
                      fontWeight: FontWeight.w500,
                      height: 24 / 14),
                  decoration: InputDecoration(
                    labelText: itemName,
                    hintText: '请输入修改后的值',
                    contentPadding: const EdgeInsets.all(8),
                  ),
                  onChanged: (value) => inputValue = value,
                ),
              ),
              actions: [
                FilledButton.tonal(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('取消')),
                FilledButton(
                    onPressed: () {
                      Navigator.of(context).pop(inputValue);
                    },
                    child: const Text('确认'))
              ],
            ));
    if (result != null && result.isNotEmpty) {
      editHandle(itemValue, result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, size: 40, color: const Color(0xff4C6ED7)),
      title: Text(itemName),
      subtitle: Text(itemValue),
      trailing: TextButton(
          onPressed: () => _editItem(context), child: const Text('编辑')),
    );
  }
}
