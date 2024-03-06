// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InfoCard extends StatefulWidget {
  const InfoCard({
    Key? key,
    required this.title,
    required this.imageUrl,
    required this.subTitle,
  }) : super(key: key);

  final String title;
  final String imageUrl;
  final String subTitle;

  @override
  State<InfoCard> createState() => _InfoCardState();
}

class _InfoCardState extends State<InfoCard> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: widget.imageUrl.isNotEmpty
          ? CachedNetworkImage(
              imageUrl: widget.imageUrl,
              height: 40,
              width: 40,
            )
          : const CircleAvatar(
              backgroundColor: Colors.white24,
              child: Icon(
                CupertinoIcons.person,
                color: Colors.white,
              ),
            ),
      title: Text(
        widget.title,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
      subtitle: Text(
        widget.subTitle,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
