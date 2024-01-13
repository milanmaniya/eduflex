import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class AllChapterScreen extends StatefulWidget {
  const AllChapterScreen({super.key});

  @override
  State<AllChapterScreen> createState() => _AllChapterScreenState();
}

class _AllChapterScreenState extends State<AllChapterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Iconsax.add),
      ),
      body: const Center(
        child: Text('All Chapter Screen'),
      ),
    );
  }
}
