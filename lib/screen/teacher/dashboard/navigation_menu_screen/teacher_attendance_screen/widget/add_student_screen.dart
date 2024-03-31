import 'dart:developer';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eduflex/authentication_repository/authentication_repository.dart';
import 'package:eduflex/to_csv/basic.dart';
import 'package:eduflex/utils/constant/sizes.dart';
import 'package:eduflex/utils/popups/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class AddStudentScreen extends StatefulWidget {
  const AddStudentScreen({super.key, required this.data});

  final Map<String, dynamic> data;

  @override
  State<AddStudentScreen> createState() => _AddStudentScreenState();
}

class _AddStudentScreenState extends State<AddStudentScreen> {
  DateTime selectedDate = DateTime.now();

  List<bool> indexColor = [];

  Set studentRollNoList = {};

  Set studentName = {};

  @override
  Widget build(BuildContext context) {
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
                    saveChanges();
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
                  onTap: () async {
                    toCsv();
                  },
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
          fetchStudent();
        },
      ),
      body: StreamBuilder(
        stream: getAllStudent(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.none &&
              snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final data = [];
          List<bool> colorList = [];

          if (snapshot.hasData) {
            for (var element in snapshot.data!.docs) {
              data.add(element.data());

              log(element.data().toString());
              colorList.add(true);
              studentRollNoList.add(element['StudentRollNo']);
              studentName.add(element['StudentName']);
            }
          }

          indexColor.addAll(colorList);

          if (data.isNotEmpty) {
            return ListView.separated(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(
                horizontal: 5,
                vertical: 10,
              ),
              itemBuilder: (context, index) => Slidable(
                startActionPane: ActionPane(
                  motion: const StretchMotion(),
                  children: [
                    SlidableAction(
                      onPressed: (context) {
                        updateStudent(data, index);
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
                        deleteStudent(studentId: data[index]['StudentId']);
                      },
                      foregroundColor: Colors.white,
                      icon: Icons.delete,
                      label: 'Delete',
                    ),
                  ],
                ),
                child: studentAttendanceCard(
                  studentName: data[index]['StudentName'],
                  studentRollNo: data[index]['StudentRollNo'],
                  isPresent: indexColor[index],
                  onTap: () {
                    if (indexColor[index]) {
                      indexColor[index] = !indexColor[index];
                    } else {
                      indexColor[index] = !indexColor[index];
                    }
                    setState(() {});
                  },
                ),
              ),
              separatorBuilder: (context, index) => const SizedBox(
                height: 5,
              ),
              itemCount: data.length,
            );
          } else {
            return const Center(
              child: Text('Please add student in your classroom'),
            );
          }
        },
      ),
    );
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getAllStudent() {
    return FirebaseFirestore.instance
        .collection('Attendance')
        .doc(widget.data['ClassId'])
        .collection('Student')
        .orderBy('StudentRollNo')
        .snapshots();
  }

  Future<void> fetchStudent() async {
    final result = [];
    final data = await FirebaseFirestore.instance
        .collection('Student')
        .where('yearValue', isEqualTo: widget.data['Sem'])
        .where('div', isEqualTo: widget.data['Divison'])
        .get();

    for (var element in data.docs) {
      result.add(element.data());
    }

    if (result.isNotEmpty) {
      for (int i = 0; i < result.length; i++) {
        FirebaseFirestore.instance
            .collection('Attendance')
            .doc(widget.data['ClassId'])
            .collection('Student')
            .doc(result[i]['id'])
            .set({
          'StudentId': result[i]['id'],
          'StudentRollNo': result[i]['rollNo'],
          'StudentName': "${result[i]['firstName']} ${result[i]['lastName']}",
        });
      }

      TLoader.successSnackBar(
        title: 'Success',
        message: 'Student added successfully',
      );

      // final Map<String, dynamic> attendance = {};

      // for (var i = 0; i < result.length; i++) {
      //   attendance.addAll({
      //     result[i]['rollNo']: true,
      //   });
      // }

      // log(attendance.toString());

      // for (var i = 0; i < result.length; i++) {
      //   FirebaseFirestore.instance
      //       .collection('Attendance')
      //       .doc(widget.data['ClassId'])
      //       .collection(widget.data['ClassName'])
      //       .doc(
      //           "${selectedDate.day}-${selectedDate.month}-${selectedDate.year}")
      //       .set(attendance);
      // }
    } else {
      TLoader.errorSnackBar(
        title: 'Error',
        message: 'Student not found',
      );
    }
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

  void saveChanges() {
    final finalIndex = indexColor.sublist(0, studentRollNoList.length);

    log(finalIndex.length.toString());
    log(finalIndex.toString());

    final Map<String, dynamic> attendance = {};

    for (var i = 0; i < finalIndex.length; i++) {
      attendance.addAll({
        studentRollNoList.elementAt(i): finalIndex[i],
      });
    }

    log(attendance.toString());

    for (int i = 0; i < studentRollNoList.length; i++) {
      FirebaseFirestore.instance
          .collection('Attendance')
          .doc(widget.data['ClassId'])
          .collection(widget.data['ClassName'])
          .doc("${selectedDate.day}-${selectedDate.month}-${selectedDate.year}")
          .set(attendance)
          .then((value) {
        TLoader.successSnackBar(
          title: 'Success',
          message: 'Attendance saved successfully',
        );
      });
    }
  }

  void updateStudent(List<dynamic> data, int index) {
    final txtStudentRollNo = TextEditingController();
    final txtStudentName = TextEditingController();

    txtStudentRollNo.text = data[index]['StudentRollNo'];
    txtStudentName.text = data[index]['StudentName'];

    showUpdateStudentDialog(
      context: context,
      txtStudentRollNo: txtStudentRollNo,
      txtStudentName: txtStudentName,
      studentId: data[index]['StudentId'],
    );
  }

  void toCsv() async {
    //   Get.to(()=> const BasicScreen());
    List<String> header = [
      'Roll No',
      'Name',
    ];

    final data = await FirebaseFirestore.instance
        .collection('Attendance')
        .doc(widget.data['ClassId'])
        .collection(widget.data['ClassName'])
        .get();

    for (var element in data.docs) {
      log(element.id.toString());
      header.add(element.id);
    }

    AuthenticationReposotiry().workBookFunction(
      header: header,
      studentRollNoList: studentRollNoList,
      studentName: studentName,
      indexColor: indexColor,
    );
  }
}
