import 'package:flutter/material.dart';

class TeacherUpdateProfileScreen extends StatefulWidget {
  const TeacherUpdateProfileScreen({super.key});

  @override
  State<TeacherUpdateProfileScreen> createState() => _TeacherUpdateProfileScreenState();
}

class _TeacherUpdateProfileScreenState extends State<TeacherUpdateProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Edit Profile',
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 8),
        child: Column(
          children: [
            
          ],
        ),
      ),
    );
  }
}