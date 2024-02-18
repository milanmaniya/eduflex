import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iconsax/iconsax.dart';

class TeacherAttendanceScreen extends StatefulWidget {
  const TeacherAttendanceScreen({super.key});

  @override
  State<TeacherAttendanceScreen> createState() =>
      _TeacherAttendanceScreenState();
}

class _TeacherAttendanceScreenState extends State<TeacherAttendanceScreen> {
  final storage = GetStorage();

  @override
  void initState() {
    final data = storage.read('TeacherFieldValue');

    log(data.toString());

    super.initState();
  }

  bool isBca = false;

  String semValue = '';

  List<String> semList = [
    'SEM1',
    'SEM2',
    'SEM3',
    'SEM4',
    'SEM5',
    'SEM6',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text('Add Class'),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Iconsax.add),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Add Class'),
              actions: [
                // SizedBox(
                //   width: double.infinity,
                //   child: DropdownButtonFormField2(
                //     decoration: InputDecoration(
                //       contentPadding: const EdgeInsets.symmetric(vertical: 16),
                //       border: OutlineInputBorder(
                //         borderRadius: BorderRadius.circular(15),
                //       ),
                //     ),
                //     onChanged: (value) => semValue = value!,
                //     isExpanded: true,
                //     hint: Text(
                //       semValue.isEmpty ? 'Select Your Year' : semValue,
                //     ),
                //     items: semList
                //         .map(
                //           (e) => DropdownMenuItem(
                //             value: e,
                //             child: Text(e),
                //           ),
                //         )
                //         .toList(),
                //   ),
                // ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text('Add'),
                    ),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
