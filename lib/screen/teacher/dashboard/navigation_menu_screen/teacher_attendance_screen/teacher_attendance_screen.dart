import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
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
    'FYBCA-SEM1',
    'FYBCA-SEM2',
    'SYBCA-SEM3',
    'SYBCA-SEM4',
    'TYBCA-SEM5',
    'TYBCA-SEM6',
  ];

  List<String> divisonList = [
    'Divison-1',
    'Divison-2',
    'Divison-3',
    'Divison-4',
  ];

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllClasses() {
    return FirebaseFirestore.instance.collection('Attendance').snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: getAllClasses(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.none ||
              snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }

          final data = [];

          if (snapshot.hasData) {
            for (var element in snapshot.data!.docs) {
              log(element.id.toString());
            }
          }

          if (data.isNotEmpty) {
            return ListView.separated(
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(data[index]['className']),
                  subtitle: Row(
                    children: [
                      Text(data[index]['sem']),
                      Text("DIV- $data[index]['divison']")
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) => const SizedBox(
                height: 10,
              ),
              itemCount: data.length,
            );
          } else {
            return const Center(child: Text('Clsss Not Found'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Iconsax.add),
        onPressed: () {
          ShowDialog(context);
        },
      ),
    );
  }

  Future<dynamic> ShowDialog(BuildContext context) {
    return showDialog(
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
                      .collection('data')
                      .doc(semValue)
                      .set({
                    'className': txtSubjectValue.text,
                    'divison': divisonValue,
                    'sem': semValue
                  }).then((value) {
                    txtSubjectValue.clear();
                    semValue = '';
                  });

                  Navigator.pop(context);
                },
                child: const Text('Add'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
