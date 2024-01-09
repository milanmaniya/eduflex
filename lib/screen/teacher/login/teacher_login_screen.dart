import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class TeacherLoginScreen extends StatefulWidget {
  const TeacherLoginScreen({super.key});

  @override
  State<TeacherLoginScreen> createState() => _TeacherLoginScreenState();
}

class _TeacherLoginScreenState extends State<TeacherLoginScreen> {
  @override
  void initState() {
    final storage = GetStorage();
    log(storage.read('Screen'));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final storage = GetStorage();

    return Scaffold(
      body: Center(
        child: Text(
          storage.read('Screen'),
          style: Theme.of(context).textTheme.headlineLarge,
        ),
      ),
    );
  }
}
