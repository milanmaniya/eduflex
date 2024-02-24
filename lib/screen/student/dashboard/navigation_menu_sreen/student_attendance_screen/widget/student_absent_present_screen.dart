import 'package:flutter/material.dart';

class StudentAbsentPresentScreen extends StatefulWidget {
  const StudentAbsentPresentScreen({super.key});

  @override
  State<StudentAbsentPresentScreen> createState() =>
      _StudentAbsentPresentScreenState();
}

class _StudentAbsentPresentScreenState
    extends State<StudentAbsentPresentScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Student Absent Present Screen'),
      ),
    );
  }
}
