import 'package:flutter/material.dart';

class TeacherAccountScreen extends StatefulWidget {
  const TeacherAccountScreen({super.key});

  @override
  State<TeacherAccountScreen> createState() => _TeacherAccountScreenState();
}

class _TeacherAccountScreenState extends State<TeacherAccountScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [Text('Teacher Account Screen')],
      ),
    );
  }
}
