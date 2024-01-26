import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:eduflex/screen/chat_screen/apis/apis.dart';
import 'package:eduflex/screen/chat_screen/model/chat_user_model.dart';
import 'package:eduflex/screen/chat_screen/widget/message_card.dart';
import 'package:eduflex/utils/helper/helper_function.dart';
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

  bool _isUploading = false;

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
                    reverse: true,
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
          if (_isUploading)
            const Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 10,
                ),
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                ),
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
          child: StreamBuilder(
            stream: APIS.getUserInfo(chatUserID: widget.data['id']),
            builder: (context, snapshot) {
              final data = snapshot.data?.docs;

              final list = [];
              if (snapshot.hasData) {
                for (var element in data!) {
                  list.add(element.data());
                }
              }

              return Row(
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
                      imageUrl: list.isNotEmpty
                          ? list[0]['image']
                          : widget.data['image'],
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
                        list.isNotEmpty
                            ? list[0]['userName']
                            : widget.data['userName'],
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black87.withOpacity(0.7),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        list.isNotEmpty
                            ? list[0]['isOnline']
                                ? 'Online'
                                : THelperFunction.getLastActiveTime(
                                    context: context,
                                    lastActive: list[0]['lastActive'])
                            : THelperFunction.getLastActiveTime(
                                context: context,
                                lastActive: widget.data['lastActive']),
                        style: const TextStyle(
                          fontSize: 12.5,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  )
                ],
              );
            },
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
                    onPressed: () async {
                      final ImagePicker picker = ImagePicker();
                      final List<XFile> image = await picker.pickMultiImage();

                      for (var element in image) {
                        setState(() {
                          _isUploading = true;
                        });
                        await APIS.sendChatImage(
                            data: widget.data, file: File(element.path));
                        setState(() {
                          _isUploading = false;
                        });
                      }
                    },
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
                        setState(() {
                          _isUploading = true;
                        });
                        await APIS.sendChatImage(
                            data: widget.data, file: File(image.path));
                        setState(() {
                          _isUploading = false;
                        });
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
                    widget.data,
                    _textController.text,
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
