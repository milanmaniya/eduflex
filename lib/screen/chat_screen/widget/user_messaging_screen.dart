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
  @override
  void initState() {
    Logger().i(widget.data.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: _appBar(),
      ),
    );
  }

  Widget _appBar() {
    return Row(
      children: [
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Iconsax.activity,
            color: Colors.black54,
          ),
        ),
      ],
    );
  }
}
