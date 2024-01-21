import 'package:cached_network_image/cached_network_image.dart';
import 'package:eduflex/utils/helper/helper_function.dart';
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
          leading: ClipRRect(
            borderRadius:
                BorderRadius.circular(THelperFunction.screenHeight() * .3),
            child: CachedNetworkImage(
              height: 50,
              width: 50,
              imageUrl: widget.image,
              errorWidget: (context, url, error) => const Icon(Iconsax.people),
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
          // trailing: const Text(
          //   '12:40 PM',
          //   style: TextStyle(
          //     color: Colors.black54,
          //   ),
          // ),
          subtitle: Text(
            widget.subTitle,
            maxLines: 1,
          ),
        ),
      ),
    );
  }
}
