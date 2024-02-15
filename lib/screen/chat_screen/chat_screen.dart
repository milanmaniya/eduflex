import 'dart:developer';
import 'package:eduflex/screen/chat_screen/apis/apis.dart';
import 'package:eduflex/screen/chat_screen/widget/chat_search_screen.dart';
import 'package:eduflex/screen/chat_screen/widget/chat_user_card.dart';
import 'package:eduflex/utils/constant/text_strings.dart';
import 'package:eduflex/utils/popups/loader.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iconsax/iconsax.dart';
import 'package:logger/logger.dart';

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

    Logger().i(FirebaseAuth.instance.currentUser!.uid.toString());

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
        stream: APIS.getMyUserId(),
        builder: (context, snapshot) {
          final userId = [];

          if (snapshot.connectionState == ConnectionState.waiting ||
              snapshot.connectionState == ConnectionState.none) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasData) {
            log(snapshot.data!.docs.map((e) => e.id).toList().toString());
            userId.add(snapshot.data!.docs.map((e) => e.id).toList());

            return StreamBuilder(
              stream: APIS.getAllUser(
                  snapshot.data?.docs.map((e) => e.id).toList() ?? []),
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
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
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
          left: 12,
          right: 12,
          top: 20,
          bottom: 10,
        ),
        title: const Row(
          children: [
            Icon(
              Iconsax.user_add,
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
          onChanged: (value) {
            setState(() {
              email = value;
            });
          },
          maxLines: null,
          validator: MultiValidator([
            RequiredValidator(errorText: 'Email is required'),
            EmailValidator(errorText: 'Email is not a valid format'),
          ]),
          decoration: const InputDecoration(
            labelText: TTexts.email,
            prefixIcon: Icon(Iconsax.direct),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              if (email.isNotEmpty) {
                await APIS.addChatUser(email.toString()).then((value) {
                  if (!value) {
                    TLoader.errorSnackBar(
                        title: 'Oh Snap! ', message: 'User Does Not Exists!');
                  }
                });
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }
}
