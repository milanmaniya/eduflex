import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eduflex/screen/chat_screen/apis/apis.dart';
import 'package:eduflex/utils/constant/sizes.dart';
import 'package:eduflex/utils/popups/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:form_validator/form_validator.dart';
import 'package:iconsax/iconsax.dart';

class AddStudentScreen extends StatefulWidget {
  const AddStudentScreen({super.key, required this.data});

  final Map<String, dynamic> data;

  @override
  State<AddStudentScreen> createState() => _AddStudentScreenState();
}

class _AddStudentScreenState extends State<AddStudentScreen> {
  bool IsPresent = true;

  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot<Map<String, dynamic>>> getAllClassStudent() {
      return FirebaseFirestore.instance
          .collection('Attendance')
          .doc(widget.data['ClassId'])
          .collection('Student')
          .orderBy('StudentRollNo')
          .snapshots();
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          '${widget.data['ClassName']} | Today',
        ),
        bottom: PreferredSize(
          preferredSize: const Size(double.infinity, 20),
          child: Column(
            children: [
              Row(
                children: [
                  const SizedBox(
                    width: 15,
                  ),
                  Text(
                    '${widget.data['Sem']} ',
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    '${widget.data['Divison']} ',
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              )
            ],
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Iconsax.search_normal,
              size: 20,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(
              Iconsax.menu,
              size: 20,
            ),
            onPressed: () {},
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Iconsax.add),
        onPressed: () {
          showAddStudentDialog(context);
        },
      ),
      body: StreamBuilder(
        stream: getAllClassStudent(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.none ||
              snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final data = [];

          if (snapshot.hasData) {
            for (var element in snapshot.data!.docs) {
              log(element.id.toString());
              log(element.data().toString());

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
                          final txtStudentRollNo = TextEditingController();
                          final txtStudentName = TextEditingController();

                          txtStudentName.text = data[index]['StudentName'];
                          txtStudentRollNo.text = data[index]['StudentRollNo'];

                          showUpdateStudentDialog(
                            context: context,
                            txtStudentRollNo: txtStudentRollNo,
                            txtStudentName: txtStudentName,
                            studentId: data[index]['StudentId'],
                          );
                        },
                        borderRadius: BorderRadius.circular(16),
                        autoClose: true,
                        backgroundColor: const Color(0xFF21B7CA),
                        foregroundColor: Colors.white,
                        icon: Icons.download,
                        label: 'Update',
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      SlidableAction(
                        borderRadius: BorderRadius.circular(16),
                        autoClose: true,
                        backgroundColor: const Color(0xFFFE4A49),
                        onPressed: (context) {
                          deleteStudent(studentId: data[index]['StudentId']);
                        },
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                        label: 'Delete',
                      )
                    ],
                  ),
                  child: studentAttendanceCard(
                    studentName: data[index]['StudentName'],
                    studentRollNo: data[index]['StudentRollNo'],
                    isPresent: IsPresent,
                    onTap: () {
                      if (IsPresent) {
                        IsPresent = !IsPresent;
                      } else {
                        IsPresent = !IsPresent;
                      }
                      setState(() {});
                    },
                  ),
                );
              },
              separatorBuilder: (context, index) => const SizedBox(
                height: 10,
              ),
              itemCount: data.length,
            );
          } else {
            return const Center(child: Text('Student Not Found'));
          }
        },
      ),
    );
  }

  Future<void> deleteStudent({required String studentId}) async {
    await FirebaseFirestore.instance
        .collection('Attendance')
        .doc(widget.data['ClassId'])
        .collection('Student')
        .doc(studentId)
        .delete()
        .then((value) {
      TLoader.successSnackBar(
          title: 'Success', message: 'Student Deleted Successfully');
    });
  }

  Future<void> showUpdateStudentDialog({
    required BuildContext context,
    required TextEditingController txtStudentRollNo,
    required TextEditingController txtStudentName,
    required String studentId,
  }) {
    return showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Update Student'),
        actions: [
          TextFormField(
            keyboardType: TextInputType.number,
            controller: txtStudentRollNo,
            validator: ValidationBuilder().required().build(),
            decoration: const InputDecoration(
              labelText: 'Student RollNo ',
              prefixIcon: Icon(Iconsax.info_circle),
            ),
          ),
          const SizedBox(
            height: 14,
          ),
          TextFormField(
            controller: txtStudentName,
            validator: ValidationBuilder().required().build(),
            decoration: const InputDecoration(
              labelText: 'Student Name ',
              prefixIcon: Icon(Iconsax.user),
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
                      .doc(widget.data['ClassId'])
                      .collection('Student')
                      .doc(studentId)
                      .update({
                    'StudentName': txtStudentName.text,
                    'StudentRollNo': txtStudentRollNo.text,
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

  Card studentAttendanceCard({
    required String studentName,
    required String studentRollNo,
    required VoidCallback onTap,
    bool isPresent = true,
  }) {
    return Card(
      color: isPresent ? Colors.green : Colors.red,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          height: 75,
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 10,
          ),
          child: Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              Text(
                studentRollNo,
                style: TextStyle(
                  height: 2,
                  fontSize: 16,
                  color: isPresent ? Colors.black : Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: TSize.spaceBtwItems),
              Text(
                studentName,
                style: TextStyle(
                  height: 2,
                  fontSize: 16,
                  color: isPresent ? Colors.black : Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              Container(
                alignment: Alignment.center,
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isPresent ? Colors.green.shade100 : Colors.red[200],
                ),
                child: Text(
                  isPresent ? 'P' : 'A',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isPresent ? Colors.black : Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> showAddStudentDialog(BuildContext context) {
    final txtStudentId = TextEditingController();

    return showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Student'),
        actions: [
          TextFormField(
            keyboardType: TextInputType.number,
            controller: txtStudentId,
            decoration: const InputDecoration(
              labelText: 'Student Id',
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
                  APIS.studentExist(txtStudentId.text, widget.data['ClassId'],
                      widget.data['ClassName']);

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
