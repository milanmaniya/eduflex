import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:eduflex/screen/teacher/dashboard/navigation_menu_screen/teacher_attendance_screen/widget/add_student_screen.dart';
import 'package:eduflex/utils/popups/loader.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
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

  String semValue = '';
  String divisonValue = '';
  final txtSubjectValue = TextEditingController();

  String fieldValue = '';

  List<String> bcaSemList = [
    'FYBCA-SEM1',
    'FYBCA-SEM2',
    'SYBCA-SEM3',
    'SYBCA-SEM4',
    'TYBCA-SEM5',
    'TYBCA-SEM6',
  ];

  List<String> bbaSemList = [
    'FYBBA-SEM1',
    'FYBBA-SEM2',
    'SYBBA-SEM3',
    'SYBBA-SEM4',
    'TYBBA-SEM5',
    'TYBBA-SEM6',
  ];

  Future<void> fetchFieldValue() async {
    final data = await FirebaseFirestore.instance
        .collection(storage.read('Screen'))
        .where('id', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get();

    for (var element in data.docs) {
      setState(() {
        fieldValue = element['fieldValue'];
      });
    }
  }

  List<String> divisonList = [
    'Divison-1',
    'Divison-2',
    'Divison-3',
    'Divison-4',
  ];

  @override
  void initState() {
    fetchFieldValue();
    super.initState();
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllClasses() {
    return FirebaseFirestore.instance
        .collection('Attendance')
        .where('TeacherId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    log(fieldValue.toString());
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Class',
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(
              Iconsax.search_normal,
              size: 20,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: StreamBuilder(
        stream: getAllClasses(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.none ||
              snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final data = [];

          if (snapshot.hasData) {
            for (var element in snapshot.data!.docs) {
              data.add(element.data());
            }
          }

          if (data.isNotEmpty) {
            return ListView.separated(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 5,
              ),
              itemBuilder: (context, index) {
                return Slidable(
                  startActionPane: ActionPane(
                    motion: const StretchMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (context) {
                          final txtClassName = TextEditingController();

                          txtClassName.text = data[index]['ClassName'];

                          showUpdateClassDialog(
                            context: context,
                            txtClassName: txtClassName,
                            semList:
                                fieldValue == 'BBA' ? bbaSemList : bcaSemList,
                            divisonList: divisonList,
                            classId: data[index]['ClassId'],
                            semValue: data[index]['Sem'],
                            divisonValue: data[index]['Divison'],
                          );
                        },
                        borderRadius: BorderRadius.circular(16),
                        autoClose: true,
                        backgroundColor: const Color(0xFF21B7CA),
                        foregroundColor: Colors.white,
                        icon: Icons.update_rounded,
                        label: 'Update',
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      SlidableAction(
                        borderRadius: BorderRadius.circular(16),
                        autoClose: true,
                        backgroundColor: const Color(0xFFFE4A49),
                        onPressed: (context) {
                          deleteClass(
                            classId: data[index]['ClassId'],
                            className: data[index]['ClassName'],
                          );
                        },
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                        label: 'Delete',
                      ),
                      const SizedBox(
                        width: 3,
                      ),
                    ],
                  ),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: InkWell(
                      onTap: () {
                        Get.to(
                          () => AddStudentScreen(
                            data: data[index],
                          ),
                        );
                      },
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 10,
                        ),
                        title: Text(
                          data[index]['ClassName'],
                          style: const TextStyle(
                            height: 2,
                            fontSize: 15,
                          ),
                        ),
                        subtitle: Row(
                          children: [
                            Text(
                              data[index]['Sem'],
                              style: const TextStyle(
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              data[index]['Divison'],
                              style: const TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        trailing: const Text(
                          'Add Student',
                          style: TextStyle(
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ),
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
          showAddClassDialog(context);
        },
      ),
    );
  }

  Future<dynamic> showAddClassDialog(BuildContext context) {
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
              items: fieldValue == 'BBA'
                  ? bbaSemList
                      .map(
                        (e) => DropdownMenuItem(
                          value: e,
                          child: Text(e),
                        ),
                      )
                      .toList()
                  : bcaSemList
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
                  final time = DateTime.now().millisecondsSinceEpoch.toString();

                  FirebaseFirestore.instance
                      .collection('Attendance')
                      .doc(time)
                      .set({
                    'ClassId': time,
                    'ClassName': txtSubjectValue.text,
                    'Divison': divisonValue,
                    'Sem': semValue,
                    'TeacherId': FirebaseAuth.instance.currentUser!.uid
                  }).then((value) {
                    TLoader.successSnackBar(
                      title: 'Success',
                      message: 'Class Created Successfully',
                    );
                  });

                  Navigator.pop(context);
                  setState(() {});
                },
                child: const Text('Add'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void deleteClass({required String classId, required String className}) {
    FirebaseFirestore.instance
        .collection('Attendance')
        .doc(classId)
        .collection('Student')
        .doc()
        .delete()
        .then((value) {
      FirebaseFirestore.instance
          .collection('Attendance')
          .doc(classId)
          .collection(className)
          .doc()
          .delete()
          .then((value) {
        FirebaseFirestore.instance
            .collection('Attendance')
            .doc(classId)
            .delete();
      });
    }).then((value) {
      TLoader.successSnackBar(
          title: 'Success', message: 'Class Deleted Successfully');
    });

    // FirebaseFirestore.instance
    //     .collection('Attendance')
    //     .doc(classId)
    //     .delete()
    //     .then((value) {
    //   FirebaseFirestore.instance
    //       .collection('Attendance')
    //       .doc(classId)
    //       .collection('Student')
    //       .doc()
    //       .delete();

    //   FirebaseFirestore.instance
    //       .collection('Attendance')
    //       .doc(classId)
    //       .collection(className)
    //       .doc()
    //       .delete();
    //   TLoader.successSnackBar(
    //       title: 'Success', message: 'Class Deleted Successfully');
    // });
  }

  Future<void> showUpdateClassDialog({
    required BuildContext context,
    required TextEditingController txtClassName,
    required List<String> semList,
    required List<String> divisonList,
    required String semValue,
    required String divisonValue,
    required String classId,
  }) {
    return showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Update Class'),
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
                semValue,
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
                divisonValue,
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
            controller: txtClassName,
            validator: ValidationBuilder().required().build(),
            decoration: const InputDecoration(
              labelText: 'Subject',
              prefixIcon: Icon(Iconsax.info_circle),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  FirebaseFirestore.instance
                      .collection('Attendance')
                      .doc(classId)
                      .update({
                    'ClassName': txtClassName.text,
                    'Sem': semValue,
                    'Divison': divisonValue
                  }).then((value) {
                    TLoader.successSnackBar(
                      title: 'Success',
                      message: 'Class updated',
                    );
                  });

                  Navigator.pop(context);
                },
                child: const Text('Update'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
