import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  const InfoCard({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.subTitle,
  });

  final String title;
  final String imageUrl;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: imageUrl.isNotEmpty
          ? CachedNetworkImage(
              imageUrl: imageUrl,
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
        title,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
      subtitle: Text(
        subTitle,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
