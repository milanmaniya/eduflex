import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class ChatUserCard extends StatefulWidget {
  const ChatUserCard({super.key});

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
        child: const ListTile(
          trailing: CircleAvatar(
            child: Icon(Iconsax.people),
          ),
          title: Text('Milan Maniya'),
          leading: Text(
            '12:40 PM',
            style: TextStyle(
              color: Colors.black54,
            ),
          ),
          subtitle: Text(
            'Last user Message',
            maxLines: 1,
          ),
        ),
      ),
    );
  }
}
