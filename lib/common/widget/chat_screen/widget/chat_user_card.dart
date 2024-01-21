import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class ChatUserCard extends StatefulWidget {
  const ChatUserCard({
    super.key,
    required this.title,
    this.image = '',
    required this.subTitle,
  });

  final String title;
  final String image;
  final String subTitle;

  @override
  State<ChatUserCard> createState() => _ChatUserCardState();
}

class _ChatUserCardState extends State<ChatUserCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () {},
        child: ListTile(
          leading: const CircleAvatar(
            child: Icon(Iconsax.people),
          ),
          title: Text(widget.title),
          trailing: const Text(
            '12:40 PM',
            style: TextStyle(
              color: Colors.black54,
            ),
          ),
          subtitle: Text(
            widget.subTitle,
            maxLines: 1,
          ),
        ),
      ),
    );
  }
}
