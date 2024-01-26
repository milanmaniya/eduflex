// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:iconsax/iconsax.dart';
import 'package:logger/logger.dart';

import 'package:eduflex/screen/chat_screen/apis/apis.dart';
import 'package:eduflex/screen/chat_screen/model/chat_user_model.dart';
import 'package:eduflex/utils/constant/sizes.dart';
import 'package:eduflex/utils/helper/helper_function.dart';

class MessageCard extends StatefulWidget {
  const MessageCard({super.key, required this.message});

  final Message message;

  @override
  State<MessageCard> createState() => _MessageCardState();
}

class _MessageCardState extends State<MessageCard> {
  @override
  Widget build(BuildContext context) {
    bool isMe = FirebaseAuth.instance.currentUser!.uid == widget.message.fromId;

    return InkWell(
      onLongPress: () {
        _showModalSheet(isMe);
      },
      child: isMe ? _sender() : _reciever(),
    );
  }

  void _showModalSheet(bool isMe) {
    showModalBottomSheet(
      context: context,
      isDismissible: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      builder: (context) {
        return ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 10,
          ),
          children: [
            Container(
              height: 5,
              margin: EdgeInsets.symmetric(
                vertical: TSize.spaceBtwItems,
                horizontal: THelperFunction.screenWidth() * .4,
              ),
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            widget.message.type == Type.text
                ? _OptionItem(
                    name: 'Copy Text',
                    icon: const Icon(
                      Icons.copy_all_rounded,
                      color: Colors.blue,
                      size: 26,
                    ),
                    onTap: () {},
                  )
                : _OptionItem(
                    name: 'Save Image',
                    icon: const Icon(
                      Icons.download_done_rounded,
                      color: Colors.blue,
                      size: 26,
                    ),
                    onTap: () {},
                  ),
            if (isMe)
              Divider(
                color: Colors.black54,
                endIndent: THelperFunction.screenWidth() * .4,
                indent: THelperFunction.screenWidth() * .4,
              ),
            if (widget.message.type == Type.text && isMe)
              _OptionItem(
                name: 'Edit Message',
                icon: const Icon(
                  Icons.edit,
                  color: Colors.blue,
                  size: 26,
                ),
                onTap: () {},
              ),
            if (isMe)
              _OptionItem(
                name: 'Delete Message',
                icon: const Icon(
                  Icons.delete_forever,
                  color: Colors.red,
                  size: 26,
                ),
                onTap: () {},
              ),
            Divider(
              color: Colors.black54,
              endIndent: THelperFunction.screenWidth() * .4,
              indent: THelperFunction.screenWidth() * .4,
            ),
            _OptionItem(
              name: 'Sent At',
              icon: const Icon(
                Icons.remove_red_eye,
                color: Colors.blue,
              ),
              onTap: () {},
            ),
            _OptionItem(
              name: 'Read At',
              icon: const Icon(
                Icons.remove_red_eye_rounded,
                color: Colors.green,
              ),
              onTap: () {},
            ),
          ],
        );
      },
    );
  }

  Widget _reciever() {
    if (widget.message.read.isEmpty) {
      APIS.updateMessageReadStatus(widget.message);
      Logger().i('Message read updated!');
    }

    return ChatBubble(
      clipper: ChatBubbleClipper1(type: BubbleType.receiverBubble),
      backGroundColor: const Color(0xffE7E7ED),
      margin: const EdgeInsets.only(top: 20),
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.7,
          minWidth: MediaQuery.of(context).size.width * 0.2,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            widget.message.type == Type.text
                ? Text(
                    widget.message.message,
                    textAlign: TextAlign.start,
                    style: const TextStyle(color: Colors.black),
                  )
                : ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl: widget.message.message,
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      errorWidget: (context, url, error) => const CircleAvatar(
                        child: Icon(Iconsax.people),
                      ),
                    ),
                  ),
            const SizedBox(
              height: 3,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  THelperFunction.timeFormat(
                    context: context,
                    time: widget.message.sent,
                  ),
                  textAlign: TextAlign.justify,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _sender() {
    return ChatBubble(
      clipper: ChatBubbleClipper1(type: BubbleType.sendBubble),
      alignment: Alignment.topRight,
      margin: const EdgeInsets.only(top: 20),
      backGroundColor: Colors.blue,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.7,
          minWidth: MediaQuery.of(context).size.width * 0.2,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            widget.message.type == Type.text
                ? Text(
                    widget.message.message,
                    textAlign: TextAlign.start,
                    style: const TextStyle(color: Colors.white),
                  )
                : ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      imageUrl: widget.message.message,
                      errorWidget: (context, url, error) => const CircleAvatar(
                        child: Icon(Iconsax.people),
                      ),
                    ),
                  ),
            const SizedBox(
              height: 3,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  THelperFunction.timeFormat(
                    context: context,
                    time: widget.message.sent,
                  ),
                  textAlign: TextAlign.justify,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Icon(
                  widget.message.read.isNotEmpty
                      ? Icons.done_all_rounded
                      : Icons.done,
                  color: Colors.white,
                  size: 18,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _OptionItem extends StatelessWidget {
  const _OptionItem({
    required this.name,
    required this.icon,
    required this.onTap,
  });

  final String name;
  final Icon icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(
          top: 15,
          left: 50,
          bottom: TSize.spaceBtwItems,
        ),
        child: Row(
          children: [
            icon,
            const SizedBox(
              width: TSize.spaceBtwItems,
            ),
            Flexible(
              child: Text(
                name,
                style: const TextStyle(
                  fontSize: 15,
                  letterSpacing: 0.2,
                  color: Colors.black54,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
