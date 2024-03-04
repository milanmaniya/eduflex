import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class NewsBox extends StatelessWidget {
  const NewsBox({
    super.key,
    required this.url,
    required this.imageUrl,
    required this.title,
    required this.time,
    required this.description,
    required this.imageForError,
  });

  final String url;
  final String imageUrl;
  final String title;
  final String time;
  final String description;
  final String imageForError;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        
      },
      leading: CachedNetworkImage(
        imageUrl: imageUrl.isNotEmpty ? imageUrl : imageForError,
        height: 80,
        width: 80,
        errorWidget: (context, url, error) => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
      title: Text(
        title,
        maxLines: 2,
        style: const TextStyle(
          overflow: TextOverflow.ellipsis,
        ),
      ),
      subtitle: Text(time),
    );
  }
}
