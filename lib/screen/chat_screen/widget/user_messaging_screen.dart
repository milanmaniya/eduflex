import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:eduflex/screen/chat_screen/apis/apis.dart';
import 'package:eduflex/screen/chat_screen/model/chat_user_model.dart';
import 'package:eduflex/screen/chat_screen/widget/message_card.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
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
  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: APIS.getAllMessage(id: widget.data['id']),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting ||
                    snapshot.connectionState == ConnectionState.none) {
                  return const Center(
                    child: SizedBox(),
                  );
                }

                if (snapshot.hasData) {
                  final data = snapshot.data!.docs;

                  _list = data.map((e) => Message.fromJson(e.data())).toList();
                }

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
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: TextField(
                      controller: _textController,
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      decoration: const InputDecoration(
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
                    onPressed: () async {
                      final ImagePicker picker = ImagePicker();
                      final XFile? image = await picker.pickImage(
                        source: ImageSource.camera,
                      );
                      if (image != null) {
                        log(image.path.toString());

                        await APIS.sendChatImage(
                            widget.data['id'], File(image.path));
                      }
                    },
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
              onPressed: () {
                if (_textController.text.isNotEmpty) {
                  APIS.sendMessage(
                    widget.data['id'],
                    _textController.text.trim(),
                    Type.text,
                  );
                  _textController.clear();
                }
              },
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
