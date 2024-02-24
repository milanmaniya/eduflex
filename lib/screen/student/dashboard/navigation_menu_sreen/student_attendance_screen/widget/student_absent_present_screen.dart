import 'package:flutter/material.dart';

class StudentAbsentPresentScreen extends StatefulWidget {
  const StudentAbsentPresentScreen({super.key, required this.className});

  final String className;

  @override
  State<StudentAbsentPresentScreen> createState() =>
      _StudentAbsentPresentScreenState();
}

class _StudentAbsentPresentScreenState
    extends State<StudentAbsentPresentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          widget.className,
        ),
        centerTitle: true,
      ),
      body: const Center(
        child: Text('Student Absent Present Screen'),
      ),
    );
  }
}
