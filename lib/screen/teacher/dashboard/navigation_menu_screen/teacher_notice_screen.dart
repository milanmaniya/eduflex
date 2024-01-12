import 'package:flutter/material.dart';

class TeacherNoticeScreen extends StatefulWidget {
  const TeacherNoticeScreen({super.key});

  @override
  State<TeacherNoticeScreen> createState() => _TeacherNoticeScreenState();
}

class _TeacherNoticeScreenState extends State<TeacherNoticeScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Teacher Notice Screen'),
      ),
    );
  }
}
