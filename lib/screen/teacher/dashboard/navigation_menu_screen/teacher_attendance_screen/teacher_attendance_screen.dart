import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:eduflex/screen/teacher/dashboard/navigation_menu_screen/teacher_attendance_screen/widget/add_student_screen.dart';
import 'package:eduflex/utils/popups/loader.dart';
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
                            semList: semList,
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
          ShowDialog(context);
        },
      ),
    );
  }

  // ignore: non_constant_identifier_names
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
                  final time = DateTime.now().millisecondsSinceEpoch.toString();

                  FirebaseFirestore.instance
                      .collection('Attendance')
                      .doc(time)
                      .set({
                    'ClassId': time,
                    'ClassName': txtSubjectValue.text,
                    'Divison': divisonValue,
                    'Sem': semValue
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

  Future<void> deleteClass({required String classId}) async {
    await FirebaseFirestore.instance
        .collection('Attendance')
        .doc(classId)
        .delete()
        .then((value) {
      TLoader.successSnackBar(
          title: 'Success', message: 'Class Deleted Successfully');
    });
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
                      message: 'Student data updated',
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
