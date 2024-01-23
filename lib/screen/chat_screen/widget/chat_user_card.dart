import 'package:cached_network_image/cached_network_image.dart';
import 'package:eduflex/utils/helper/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class ChatUserCard extends StatefulWidget {
  const ChatUserCard({
    super.key,
    required this.title,
    required this.image,
    required this.subTitle,
    required this.onPressed,
  });

  final String title;
  final String image;
  final String subTitle;
  final VoidCallback onPressed;

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
        onTap: widget.onPressed,
        child: Container(
          alignment: Alignment.center,
          height: 90,
          child: ListTile(
            leading: ClipRRect(
              borderRadius:
                  BorderRadius.circular(THelperFunction.screenHeight() * .3),
              child: CachedNetworkImage(
                height: 50,
                width: 50,
                imageUrl: widget.image,
                errorWidget: (context, url, error) =>
                    const CircleAvatar(child: Icon(Iconsax.people)),
              ),
            ),
            title: Text(widget.title),
            trailing: Container(
              height: 12,
              width: 12,
              decoration: const BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
              ),
            ),
            subtitle: Text(
              widget.subTitle,
              maxLines: 1,
            ),
          ),
        ),
      ),
    );
  }
}
