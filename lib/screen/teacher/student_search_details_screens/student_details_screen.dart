import 'package:flutter/material.dart';

class StudentDetialsScreen extends StatefulWidget {
  const StudentDetialsScreen({super.key, required this.data});

  final Map<String, dynamic> data;

  @override
  State<StudentDetialsScreen> createState() => _StudentDetialsScreenState();
}

class _StudentDetialsScreenState extends State<StudentDetialsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          
        ],
      ),
    );
  }
}
