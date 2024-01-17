import 'package:flutter/material.dart';

class TeacherInformationScreen extends StatefulWidget {
  const TeacherInformationScreen({
    super.key,
    required this.data,
  });

  final Map<String, dynamic> data;

  @override
  State<TeacherInformationScreen> createState() =>
      _TeacherInformationScreenState();
}

class _TeacherInformationScreenState extends State<TeacherInformationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Information',
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(
          top: 10,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 120,
              width: 120,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image(
                  image: NetworkImage(
                    widget.data['image'],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
