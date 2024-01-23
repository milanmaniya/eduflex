import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:logger/logger.dart';

class UserMessagingScreen extends StatefulWidget {
  const UserMessagingScreen({super.key, required this.data});

  final Map<String, dynamic> data;

  @override
  State<UserMessagingScreen> createState() => _UserMessagingScreenState();
}

class _UserMessagingScreenState extends State<UserMessagingScreen> {
  get child => null;

  @override
  void initState() {
    Logger().i(widget.data.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 4,
        automaticallyImplyLeading: false,
        toolbarHeight: 64,
        flexibleSpace: Padding(
          padding: const EdgeInsets.only(
            top: 40,
          ),
          child: InkWell(
            onTap: () {},
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Iconsax.arrow_left),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: CachedNetworkImage(
                    height: 45,
                    width: 45,
                    fit: BoxFit.cover,
                    imageUrl: widget.data['image'],
                    errorWidget: (context, url, error) => const CircleAvatar(
                      child: Icon(Iconsax.people),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.data['userName'],
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black87.withOpacity(0.7),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      'Last seen not available',
                      style: TextStyle(
                        fontSize: 12.5,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
