import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatUserCard extends StatefulWidget {
  const ChatUserCard({super.key});

  @override
  State<ChatUserCard> createState() => _ChatUserCardState();
}

class _ChatUserCardState extends State<ChatUserCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: const Card(
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 10,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        child: ListTile(
          title: Text('Demo User'),
          subtitle: Text(
            'Last User Message',
            maxLines: 1,
          ),
          leading: CircleAvatar(
            child: Icon(CupertinoIcons.person),
          ),
          trailing: Text(
            '12:00 PM',
            style: TextStyle(
              color: Colors.black54,
            ),
          ),
        ),
      ),
    );
  }
}
