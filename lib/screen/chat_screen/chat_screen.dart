import 'dart:developer';
import 'package:eduflex/screen/chat_screen/apis/apis.dart';
import 'package:eduflex/screen/chat_screen/widget/chat_search_screen.dart';
import 'package:eduflex/screen/chat_screen/widget/chat_user_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iconsax/iconsax.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final localStorage = GetStorage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Messages',
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Iconsax.search_normal,
              size: 20,
            ),
            onPressed: () => Get.to(() => const ChatSearchScreen()),
          ),
          IconButton(
            icon: const Icon(
              Iconsax.menu,
              size: 20,
            ),
            onPressed: () {},
          ),
        ],
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Iconsax.add),
        onPressed: () {},
      ),
      body: StreamBuilder(
        stream: APIS.getAllUser(),
        builder: (context, snapshot) {
          final List<Map<String, dynamic>> data = [];

          if (snapshot.connectionState == ConnectionState.waiting ||
              snapshot.connectionState == ConnectionState.none) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasData) {
            for (var element in snapshot.data!.docs) {
              data.add(element.data());
              log(data.toString());
            }
          }

          if (data.isNotEmpty) {
            return ListView.separated(
              physics: const BouncingScrollPhysics(),
              separatorBuilder: (context, index) => const SizedBox(
                height: 5,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 10,
              ),
              itemCount: data.length,
              itemBuilder: (context, index) => ChatUserCard(
                subTitle: data[index]['about'],
                title: data[index]['userName'],
                image: data[index]['image'],
              ),
            );
          } else {
            return const Center(
              child: Text('No Connection Found!'),
            );
          }
        },
      ),
    );
  }
}
