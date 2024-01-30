// ignore: unused_import
import 'dart:ffi';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:eduflex/screen/chat_screen/apis/apis.dart';
import 'package:eduflex/screen/chat_screen/model/chat_user_model.dart';
import 'package:eduflex/screen/chat_screen/widget/user_messaging_screen.dart';
import 'package:eduflex/utils/helper/helper_function.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ChatUserCard extends StatefulWidget {
  const ChatUserCard({
    super.key,
    required this.data,
  });

  final Map<String, dynamic> data;

  @override
  State<ChatUserCard> createState() => _ChatUserCardState();
}

class _ChatUserCardState extends State<ChatUserCard> {
  Message? msg;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: APIS.getLastMessage(widget.data['id']),
      builder: (context, snapshot) {
        final data = snapshot.data?.docs;

        final list =
            data?.map((e) => Message.fromJson(e.data())).toList() ?? [];

        if (list.isNotEmpty) {
          msg = list[0];
        }

        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: InkWell(
            onTap: () => Get.to(
              () => UserMessagingScreen(
                data: widget.data,
              ),
            ),
            child: Container(
              alignment: Alignment.center,
              height: 90,
              child: ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(
                      THelperFunction.screenHeight() * .3),
                  child: CachedNetworkImage(
                    height: 50,
                    width: 50,
                    imageUrl: widget.data['image'],
                    fit: BoxFit.cover,
                    errorWidget: (context, url, error) =>
                        const CircleAvatar(child: Icon(Iconsax.people)),
                  ),
                ),
                title: Text(widget.data['userName']),
                trailing: msg == null
                    ? null
                    : msg!.read.isEmpty &&
                            msg!.fromId !=
                                FirebaseAuth.instance.currentUser!.uid
                        ? Container(
                            height: 12,
                            width: 12,
                            decoration: const BoxDecoration(
                              color: Colors.green,
                              shape: BoxShape.circle,
                            ),
                          )
                        : Text(
                            THelperFunction.getLastMessageTime(
                              context: context,
                              time: msg!.sent,
                            ),
                            style: const TextStyle(
                              color: Colors.black54,
                            ),
                          ),
                subtitle: Text(
                  msg != null
                      ? msg!.type == Type.image
                          ? 'image'
                          : msg!.message
                      : widget.data['about'],
                  maxLines: 1,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
