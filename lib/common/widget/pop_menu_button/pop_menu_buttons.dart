import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zego_zimkit/zego_zimkit.dart';

class PopMenuButtonPage extends StatefulWidget {
  const PopMenuButtonPage({super.key});

  @override
  State<PopMenuButtonPage> createState() => _PopMenuButtonPageState();
}

class _PopMenuButtonPageState extends State<PopMenuButtonPage> {
  final userIdController = TextEditingController();
  final groupNameController = TextEditingController();
  final groupUsersController = TextEditingController();
  final groupIdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      position: PopupMenuPosition.under,
      icon: const Icon(CupertinoIcons.add_circled),
      itemBuilder: (context) {
        return [
          PopupMenuItem(
            value: 'New Chat',
            child: ListTile(
              leading: const Icon(
                CupertinoIcons.chat_bubble_2_fill,
              ),
              onTap: () => ZIMKit().showDefaultNewPeerChatDialog(context),
              title: const Text(
                'New Chat',
                maxLines: 1,
              ),
            ),
          ),
          PopupMenuItem(
            value: 'New Group',
            child: ListTile(
              leading: const Icon(
                CupertinoIcons.chat_bubble_2_fill,
              ),
              onTap: () => ZIMKit().showDefaultNewPeerChatDialog(context),
              title: const Text(
                'New Group',
                maxLines: 1,
              ),
            ),
          ),
          PopupMenuItem(
            value: 'Join Group',
            child: ListTile(
              leading: const Icon(
                CupertinoIcons.chat_bubble_2_fill,
              ),
              onTap: () => ZIMKit().showDefaultNewPeerChatDialog(context),
              title: const Text(
                'Join Group',
                maxLines: 1,
              ),
            ),
          ),
        ];
      },
    );
  }
}
