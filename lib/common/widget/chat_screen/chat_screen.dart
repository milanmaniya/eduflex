import 'package:eduflex/common/widget/chat_user/chat_user_card.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: const [
          Icon(Iconsax.search_normal),
          SizedBox(
            width: 15,
          ),
          Icon(Iconsax.more),
          SizedBox(
            width: 10,
          ),
        ],
        automaticallyImplyLeading: false,
        title: const Text(
          'We Chat',
        ),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Iconsax.add),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.only(
          top: 10,
          bottom: 10,
        ),
        itemCount: 10,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) => const ChatUserCard(),
      ),
    );
  }
}
