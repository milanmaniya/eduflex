import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:eduflex/screen/chat_screen/apis/apis.dart';
import 'package:eduflex/screen/chat_screen/model/chat_user_model.dart';
import 'package:eduflex/screen/chat_screen/widget/message_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:logger/logger.dart';

class UserMessagingScreen extends StatefulWidget {
  const UserMessagingScreen({super.key, required this.data});

  final Map<String, dynamic> data;

  @override
  State<UserMessagingScreen> createState() => _UserMessagingScreenState();
}

class _UserMessagingScreenState extends State<UserMessagingScreen> {
  @override
  void initState() {
    Logger().i(widget.data.toString());
    super.initState();
  }

  List<Message> _list = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: APIS.getAllMessage(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting ||
                    snapshot.connectionState == ConnectionState.none) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (snapshot.hasData) {
                  for (var element in snapshot.data!.docs) {
                    log(element.id.toString());
                  }
                }

                _list.clear();
                _list.add(
                  Message(
                    fromId: FirebaseAuth.instance.currentUser!.uid,
                    toId: 'xyz',
                    message: 'Hill',
                    read: '',
                    sent: '12:00 AM',
                    type: Type.text,
                  ),
                );
                _list.add(
                  Message(
                    toId: FirebaseAuth.instance.currentUser!.uid,
                    fromId: 'xyz',
                    message: 'Hello',
                    read: '',
                    sent: '12:05 AM',
                    type: Type.text,
                  ),
                );

                if (_list.isNotEmpty) {
                  return ListView.builder(
                    itemCount: _list.length,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 10,
                    ),
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return MessageCard(
                        message: _list[index],
                      );
                    },
                  );
                } else {
                  return const Center(
                    child: Text('Say Hill 👋'),
                  );
                }
              },
            ),
          ),
          _chatInput(),
        ],
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      elevation: 4,
      automaticallyImplyLeading: false,
      toolbarHeight: 64,
      flexibleSpace: Padding(
        padding: const EdgeInsets.only(
          top: 40,
        ),
        child: InkWell(
          onTap: () {},
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Iconsax.arrow_left),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: CachedNetworkImage(
                  height: 45,
                  width: 45,
                  fit: BoxFit.cover,
                  imageUrl: widget.data['image'],
                  errorWidget: (context, url, error) => const CircleAvatar(
                    child: Icon(Iconsax.people),
                  ),
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.data['userName'],
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black87.withOpacity(0.7),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    'Last seen not available',
                    style: TextStyle(
                      fontSize: 12.5,
                      color: Colors.black87,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _chatInput() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 12,
      ),
      child: Row(
        children: [
          Expanded(
            flex: 6,
            child: Card(
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Iconsax.emoji_happy),
                  ),
                  const Expanded(
                    child: TextField(
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        hintText: 'Type Something...',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Iconsax.image,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Iconsax.camera),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: MaterialButton(
              shape: const CircleBorder(),
              onPressed: () {},
              child: const Icon(
                Icons.send,
                size: 25,
                // color: Colors.blue,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
