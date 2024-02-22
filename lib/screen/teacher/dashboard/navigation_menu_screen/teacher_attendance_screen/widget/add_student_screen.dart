import 'dart:developer';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eduflex/screen/chat_screen/apis/apis.dart';
import 'package:eduflex/utils/constant/sizes.dart';
import 'package:eduflex/utils/popups/loader.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:iconsax/iconsax.dart';

class AddStudentScreen extends StatefulWidget {
  const AddStudentScreen({super.key, required this.data});

  final Map<String, dynamic> data;

  @override
  State<AddStudentScreen> createState() => _AddStudentScreenState();
}

class _AddStudentScreenState extends State<AddStudentScreen> {
  final studentId = [];

  int studentLength = 0;

  DateTime selectedDate = DateTime.now();

  List<bool> isPresentAbsent = List.generate(2, (index) => true);

  @override
  Widget build(BuildContext context) {
    log('isPresent: $isPresentAbsent');

    Stream<QuerySnapshot<Map<String, dynamic>>> getAllClassStudent() {
      return FirebaseFirestore.instance
          .collection('Attendance')
          .doc(widget.data['ClassId'])
          .collection('Student')
          .orderBy('StudentRollNo')
          .snapshots();
    }

    Stream<QuerySnapshot<Map<String, dynamic>>> getallStudentAttendance(
        List<dynamic> studentId) {
      Stream<QuerySnapshot<Map<String, dynamic>>>? result;
      for (var i = 0; i < studentId.length;) {
        result = FirebaseFirestore.instance
            .collection('Attendance')
            .doc(widget.data['ClassId'])
            .collection('Student')
            .doc(studentId[i])
            .collection(widget.data['ClassName'])
            .snapshots();
      }

      return result!;
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          '${widget.data['ClassName']} | ${selectedDate.day}/${selectedDate.month}/${selectedDate.year} ',
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
              Iconsax.calendar,
              size: 20,
            ),
            onPressed: () async {
              final dateTime = await showCalendarDatePicker2Dialog(
                barrierDismissible: true,
                context: context,
                value: [
                  selectedDate,
                ],
                config: CalendarDatePicker2WithActionButtonsConfig(
                  calendarType: CalendarDatePicker2Type.single,
                ),
                dialogSize: const Size(350, 350),
              );

              setState(() {
                selectedDate = dateTime!.first!;
              });

              log(dateTime.toString());
            },
          ),
          PopupMenuButton(
            elevation: 10,
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  height: 45,
                  onTap: () {
                    for (var i = 0; i < studentId.length; i++) {
                      FirebaseFirestore.instance
                          .collection('Attendance')
                          .doc(widget.data['ClassId'])
                          .collection('Student')
                          .doc(studentId[i])
                          .collection(widget.data['ClassName'])
                          .doc(
                              '${selectedDate.day}-${selectedDate.month}-${selectedDate.year}')
                          .set({
                        'Value': isPresentAbsent[i],
                      });
                    }
                    TLoader.successSnackBar(
                        title: 'Success',
                        message: 'Attendance Save Successfully');
                  },
                  child: const Text(
                    'Save Changes',
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ),
                PopupMenuItem(
                  height: 45,
                  onTap: () {},
                  child: const Text(
                    'Print',
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ),
              ];
            },
          )
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
              // log(element.data().toString());

              studentId.add(element.id);

              data.add(element.data());
            }
          }
          if (data.isNotEmpty) {
            return StreamBuilder(
              stream: getAllClassStudent(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.none ||
                    snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                return const Center(
                  child: Text('jdfbhf'),
                );
              },
            );
          } else {
            return const Center(
              child: Text('Student Not Found'),
            );
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
