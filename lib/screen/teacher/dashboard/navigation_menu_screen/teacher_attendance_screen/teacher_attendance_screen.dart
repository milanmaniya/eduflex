import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
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

  String semValue = '';
  String divisonValue = '';
  final txtSubjectValue = TextEditingController();

  List<String> semList = [
    'SEM1',
    'SEM2',
    'SEM3',
    'SEM4',
    'SEM5',
    'SEM6',
  ];

  List<String> divisonList = [
    'Divison-1',
    'Divison-2',
    'Divison-3',
    'Divison-4',
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
            barrierDismissible: true,
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Add Class'),
              actions: [
                SizedBox(
                  width: double.infinity,
                  child: DropdownButtonFormField2(
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(vertical: 16),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    onChanged: (value) => semValue = value!,
                    isExpanded: true,
                    hint: Text(
                      semValue.isEmpty ? 'Select Semester' : semValue,
                    ),
                    items: semList
                        .map(
                          (e) => DropdownMenuItem(
                            value: e,
                            child: Text(e),
                          ),
                        )
                        .toList(),
                  ),
                ),
                const SizedBox(
                  height: 14,
                ),
                SizedBox(
                  width: double.infinity,
                  child: DropdownButtonFormField2(
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(vertical: 16),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    onChanged: (value) => divisonValue = value!,
                    isExpanded: true,
                    hint: Text(
                      divisonValue.isEmpty ? 'Select Divison' : divisonValue,
                    ),
                    items: divisonList
                        .map(
                          (e) => DropdownMenuItem(
                            value: e,
                            child: Text(e),
                          ),
                        )
                        .toList(),
                  ),
                ),
                const SizedBox(
                  height: 14,
                ),
                TextFormField(
                  controller: txtSubjectValue,
                  validator: ValidationBuilder().required().build(),
                  decoration: const InputDecoration(
                    labelText: 'Subject ',
                    prefixIcon: Icon(Iconsax.info_circle),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        semValue = '';
                        txtSubjectValue.clear();
                        Navigator.pop(context);
                      },
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        FirebaseFirestore.instance
                            .collection('Teacher')
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .collection('Attendance')
                            .doc(semValue)
                            .collection(divisonValue)
                            .doc(txtSubjectValue.text)
                            .set({}).then((value) {
                          semValue = '';
                          txtSubjectValue.clear();
                        });
                        Navigator.pop(context);
                      },
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
