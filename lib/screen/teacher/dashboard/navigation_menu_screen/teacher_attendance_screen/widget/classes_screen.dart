import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class ClassesScreen extends StatefulWidget {
  const ClassesScreen({super.key});

  @override
  State<ClassesScreen> createState() => _ClassesScreenState();
}

class _ClassesScreenState extends State<ClassesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text('Add Class'),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Iconsax.add),
        onPressed: () {
          log('Add Classes');
        },
      ),
    );
  }
}
