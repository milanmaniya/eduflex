import 'package:eduflex/common/widget/pop_menu_button/pop_menu_buttons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zego_zimkit/zego_zimkit.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          actions: const [PopMenuButtonPage()],
          automaticallyImplyLeading: false,
          title: const Text(
            'Messages',
          ),
          centerTitle: true,
        ),
        body: ZIMKitConversationListView(
          onPressed: (context, conversation, defaultAction) {
            Get.to(
              () => ZIMKitMessageListPage(
                conversationID: conversation.id,
                conversationType: conversation.type,
              ),
            );
          },
        ),
      ),
    );
  }
}
