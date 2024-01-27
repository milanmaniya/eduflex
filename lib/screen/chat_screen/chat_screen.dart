import 'dart:developer';
import 'package:eduflex/screen/chat_screen/apis/apis.dart';
import 'package:eduflex/screen/chat_screen/widget/chat_search_screen.dart';
import 'package:eduflex/screen/chat_screen/widget/chat_user_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  void initState() {
    super.initState();

    APIS.getFirebaseMessagingToken();

    APIS.updateActiveStatus(true);

    SystemChannels.lifecycle.setMessageHandler((message) {
      log(message.toString());

      if (FirebaseAuth.instance.currentUser != null) {
        if (message!.contains('resume')) {
          APIS.updateActiveStatus(true);
        }

        if (message.contains('pause')) {
          APIS.updateActiveStatus(false);
        }
      }

      return Future.value(message);
    });
  }

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
        onPressed: () {
          _showAddChatUserDialog();
        },
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
                data: data[index],
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

  void _showAddChatUserDialog() {
    String email = '';

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        contentPadding: const EdgeInsets.only(
          left: 20,
          right: 20,
          top: 20,
          bottom: 10,
        ),
        title: const Row(
          children: [
            Icon(
              Icons.message,
              color: Colors.blue,
              size: 28,
            ),
            SizedBox(
              width: 10,
            ),
            Text('Add User')
          ],
        ),
        content: TextFormField(
          maxLines: null,
          onChanged: (value) {
            setState(() {
              email = value;
            });
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // APIS.updateMessage('', email);
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }
}
